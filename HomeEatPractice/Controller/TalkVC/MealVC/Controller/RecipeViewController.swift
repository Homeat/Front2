
//
//  RecipeViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/6/24.
//
import UIKit
import Then
import AVFoundation
import Photos
import PhotosUI
import SnapKit
class RecipeViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - 사진과 앨범 파트
    private var selectedImages: [UIImage] = []
    //MARK: - 사진과 앨범 파트
    private enum Mode {
            case camera
            case album
    }
    //MARK: - 사진과 앨범 파트
    private var currentMode: Mode = .camera
    private lazy var customButton: UIButton = makeCustomButton()
    
    //MARK: - 사진과 앨범 파트
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        //셀 만들어야 함
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
        return collectionView
    }()
    
    //MARK: - UIButton 파트
    private let addImageButton : UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("사진 추가", for: .normal)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.backgroundColor = UIColor(named: "searchtf")
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        return button
    }()
    
    
        //MARK: - UIImage 파트
        //첫번째 이미지 뷰
        private let imageView: UIImageView = {
            let view = UIImageView()
            view.layer.cornerRadius = 14
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
          }()
    
    // 카메라 접근허용??
    private var isCameraAuthorized: Bool {
       AVCaptureDevice.authorizationStatus(for: .video) == .authorized
     }
    
    //MARK: - 사진과 앨범 파트
    // 버튼 액션 함수
    @objc func touchUpImageAddButton(button: UIButton) {
        // 갤러리 접근 권한 허용 여부 체크
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                DispatchQueue.main.async {
                    self.showAlert(message: "갤러리를 불러올 수 없습니다. 핸드폰 설정에서 사진 접근 허용을 모든 사진으로 변경해주세요.")
                }
            case .denied, .restricted:
                DispatchQueue.main.async {
                    self.showAlert(message: "갤러리를 불러올 수 없습니다. 핸드폰 설정에서 사진 접근 허용을 모든 사진으로 변경해주세요.")
                }
            case .authorized, .limited: // 모두 허용, 일부 허용
                self.pickImage() // 갤러리 불러오는 동작을 할 함수
            @unknown default:
                print("PHPhotoLibrary::execute - \"Unknown case\"")
            }
        }
    }
    
    //MARK: - 사진과 앨범 파트
    // 갤러리 불러오기
    func pickImage(){
        let photoLibrary = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

        configuration.selectionLimit = 3 //한번에 가지고 올 이미지 갯수 제한
        configuration.filter = .any(of: [.images]) // 이미지, 비디오 등의 옵션

        DispatchQueue.main.async { // 메인 스레드에서 코드를 실행시켜야함
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            picker.isEditing = true
            self.present(picker, animated: true, completion: nil) // 갤러리뷰 프리젠트
        }
    }
    
    
    
    //MARK: - 사진과 앨범 파트
    @objc func buttonTapped() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.currentMode = .camera
            self.openCamera()
        }

        let chooseFromLibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
            self.currentMode = .album
            self.customButton.isHidden = true
            self.collectionView.isHidden = false
            self.touchUpImageAddButton(button: self.customButton)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        takePhotoAction.setValue(UIColor.white, forKey: "titleTextColor")
        chooseFromLibraryAction.setValue(UIColor.white, forKey: "titleTextColor")
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")

        actionSheetController.addAction(takePhotoAction)
        actionSheetController.addAction(chooseFromLibraryAction)
        actionSheetController.addAction(cancelAction)

        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK: - 사진과 앨범 파트
    @objc private func openCamera() {
       #if targetEnvironment(simulator)
       fatalError()
       #endif
       
       AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
         guard isAuthorized else {
           self?.showAlertGoToSetting()
           return
         }
           
         
         DispatchQueue.main.async {
           let pickerController = UIImagePickerController()
           pickerController.sourceType = .camera
           pickerController.allowsEditing = false
           pickerController.mediaTypes = ["public.image"]
           pickerController.delegate = self
           self?.present(pickerController, animated: true)
         }
       }
     }
    
    func showAlertGoToSetting() {
        let alertController = UIAlertController(
            title: "현재 카메라 사용에 대한 접근 권한이 없습니다.",
            message: "설정 > {앱 이름}탭에서 접근을 활성화 할 수 있습니다.",
            preferredStyle: .alert
        )
        let cancelAlert = UIAlertAction(
            title: "취소",
            style: .cancel
        ) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let goToSettingAlert = UIAlertAction(
            title: "설정으로 이동하기",
            style: .default) { _ in
                guard
                    let settingURL = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingURL)
                else { return }
                UIApplication.shared.open(settingURL, options: [:])
            }
        [cancelAlert, goToSettingAlert]
            .forEach(alertController.addAction(_:))
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    //MARK: - scrollView 생성
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(named: "gray2")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "gray2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func makeCustomButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("사진 추가")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .bold)
        config.attributedTitle = attributedTitle
        let pointSize = CGFloat(30)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        config.image = UIImage.init(named: "Talk1")
        config.preferredSymbolConfigurationForImage = imageConfig

        config.imagePlacement = .top
        config.background.backgroundColor = .darkGray
        config.baseForegroundColor = .lightGray
        config.cornerStyle = .small

        // 이미지와 텍스트 간격 조절
        config.imagePadding = 12.7
        config.titlePadding = 10

        let customButton = UIButton(configuration: config)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        customButton.translatesAutoresizingMaskIntoConstraints = false

        return customButton
    }
    //MARK: - 일반프로퍼티
    // 레시피 라벨
    private let recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textColor = UIColor(named: "green")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 위쪽 경계선
    private let overBorderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 102, g: 102, b: 102)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 스텝을 나타내는 라벨
    lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(r: 187, g: 187, b: 187)
        label.text = "Step 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 레시피작성 텍스트뷰
    lazy var recipeTextView: UITextView = {
        let textView = UITextView()
        textView.text = "레시피를 작성해주세요."
        textView.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textView.textColor = UIColor(r: 204, g: 204, b: 204)
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(named: "gray4")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.delegate = self
        return textView
    }()
    
    // 재료입력 텍스트필드
    lazy var sourceTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "해당 단계에서 사용된 재료를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 204, g: 204, b: 204)])
        textField.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        textField.textColor = UIColor(r: 204, g: 204, b: 204)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 18.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    // 요리팁 텍스트필드
    lazy var tipTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "해당 단계의 요리팁을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 204, g: 204, b: 204)])
        textField.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        textField.textColor = UIColor(r: 204, g: 204, b: 204)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 18.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    // 아래쪽 경계선
    private let underBorderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 102, g: 102, b: 102)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 스텝 추가 버튼
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(r: 150, g: 150, b: 150).cgColor
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 레시피 추가하기 버튼
    lazy var recipePlusButton: UIButton = {
        let button = UIButton()
        button.setTitle("레시피 추가하기", for: .normal)
        button.backgroundColor = UIColor(named: "green")
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - @objc 메서드
    var prevStepLabel = UILabel()
    var prevImageView = UIImageView()
    var prevCollectionVIew: UICollectionView!
    var prevCustomButton = UIButton()
    var prevRecipeTextView = UITextView()
    var prevSourceTextField = UITextField()
    var prevTipTextField = UITextField()
    var prevUnderBorderLine = UIView()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
       // view에 탭 제스처를 추가.
        self.view.addGestureRecognizer(tapGesture)
        navigationControl()
        recipeTextView.delegate = self
        self.view.backgroundColor = UIColor(named: "gray2")
        let layout = UICollectionViewFlowLayout()
        setAddViews()
        setConstraints()
        
        prevStepLabel = stepLabel
        prevImageView = imageView
        prevCollectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        prevCustomButton = customButton
        prevRecipeTextView = recipeTextView
        prevSourceTextField = sourceTextField
        prevTipTextField = tipTextField
        prevUnderBorderLine = underBorderLine
    }
    
    //MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨김.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 넘어갈 때 커스텀 탭바를 다시 보이게 함.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = false
        }
    }
    
    //MARK: - 키보드처리
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // NotificationCenter에 관찰자를 등록하는 행위.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
    }
        
    // 관찰자 분리.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func viewDidTap(gesture: UITapGestureRecognizer) {
        // 뷰를 탭하면 에디팅을 멈추게함.
        // 에디팅이 멈추므로 키보드가 내려감.
        view.endEditing(true)
    }
    
    //MARK: - 일반메서드
    func setAddViews() {
        self.customButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.mainView)
        self.mainView.addSubview(self.recipeLabel)
        self.mainView.addSubview(self.overBorderLine)
        self.mainView.addSubview(self.imageView)
        mainView.bringSubviewToFront(self.imageView)
        self.mainView.addSubview(collectionView)
        
        self.mainView.addSubview(self.stepLabel)
        
        self.mainView.addSubview(self.recipeTextView)
        self.mainView.addSubview(self.sourceTextField)
        self.mainView.addSubview(self.tipTextField)
        self.mainView.addSubview(self.underBorderLine)
        self.mainView.addSubview(self.plusButton)
        self.mainView.addSubview(self.recipePlusButton)
        self.mainView.addSubview(self.customButton)
        recipeTextView.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
    }
    
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            // 스크롤뷰 제약조건
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        mainView.snp.makeConstraints { make in
            
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(600)
        }
//            // 메인뷰 제약조건
//            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            mainView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor), // 콘텐츠 크기를 버튼이 모두 보일 수 있도록 설정
        NSLayoutConstraint.activate([
            // 레시피 라벨 제약조건
            recipeLabel.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 31),
            recipeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 21),
            recipeLabel.heightAnchor.constraint(equalToConstant: 26),
            
            // 위쪽 경계선 제약조건
            overBorderLine.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 15.5),
            overBorderLine.leadingAnchor.constraint(equalTo: recipeLabel.leadingAnchor),
            overBorderLine.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            overBorderLine.heightAnchor.constraint(equalToConstant: 1),
            
            // STEP 제약조건
            stepLabel.leadingAnchor.constraint(equalTo: overBorderLine.leadingAnchor),
            stepLabel.topAnchor.constraint(equalTo: overBorderLine.bottomAnchor, constant: 15.5),
            stepLabel.heightAnchor.constraint(equalToConstant: 17),
            
            self.imageView.topAnchor.constraint(equalTo: self.stepLabel.bottomAnchor,constant: 15),
            self.imageView.leadingAnchor.constraint(equalTo: self.stepLabel.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -262),
            self.imageView.heightAnchor.constraint(equalToConstant: 111),
            
            collectionView.topAnchor.constraint(equalTo: self.stepLabel.bottomAnchor, constant:  15),
            collectionView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 111),
            
            
            
            // 레시피 텍스트뷰
            recipeTextView.leadingAnchor.constraint(equalTo: overBorderLine.leadingAnchor),
            recipeTextView.trailingAnchor.constraint(equalTo: overBorderLine.trailingAnchor),
            recipeTextView.topAnchor.constraint(equalTo: customButton.bottomAnchor, constant: 20),
            recipeTextView.heightAnchor.constraint(equalToConstant: 110),
            
            // 재료 텍스트필드
            sourceTextField.leadingAnchor.constraint(equalTo: overBorderLine.leadingAnchor),
            sourceTextField.trailingAnchor.constraint(equalTo: overBorderLine.trailingAnchor),
            sourceTextField.topAnchor.constraint(equalTo: recipeTextView.bottomAnchor, constant: 18),
            sourceTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // 팁 텍스트필드
            tipTextField.leadingAnchor.constraint(equalTo: overBorderLine.leadingAnchor),
            tipTextField.trailingAnchor.constraint(equalTo: overBorderLine.trailingAnchor),
            tipTextField.topAnchor.constraint(equalTo: sourceTextField.bottomAnchor, constant: 18),
            tipTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // 아래쪽 경계선
            underBorderLine.leadingAnchor.constraint(equalTo: overBorderLine.leadingAnchor),
            underBorderLine.trailingAnchor.constraint(equalTo: overBorderLine.trailingAnchor),
            underBorderLine.topAnchor.constraint(equalTo: tipTextField.bottomAnchor, constant: 18),
            underBorderLine.heightAnchor.constraint(equalToConstant: 1),
            
            // 스택뷰 추가버튼
            plusButton.leadingAnchor.constraint(equalTo: underBorderLine.leadingAnchor),
            plusButton.trailingAnchor.constraint(equalTo: underBorderLine.trailingAnchor),
            plusButton.topAnchor.constraint(equalTo: underBorderLine.bottomAnchor, constant: 25),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 레시피 추가버튼
            recipePlusButton.leadingAnchor.constraint(equalTo: overBorderLine.leadingAnchor),
            recipePlusButton.trailingAnchor.constraint(equalTo: overBorderLine.trailingAnchor),
            recipePlusButton.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 45),
            recipePlusButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
        customButton.topAnchor.constraint(equalTo: self.stepLabel.bottomAnchor, constant: 15),
        customButton.leadingAnchor.constraint(equalTo: self.stepLabel.leadingAnchor),
        customButton.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -262),
        customButton.heightAnchor.constraint(equalToConstant: 111),
        ])


    }
    //MARK: - 사진과 앨범 파트 and 태그파트
    // sizeForItemAt 메서드 추가
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기 설정
        if collectionView == self.collectionView {
            return CGSize(width: 176, height: 176)
        }
        return CGSize.zero
    }
    
    // contentSize의 변경을 관찰하여 동적으로 높이 조정
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            let newHeight = max(newSize.height, 50) // 최소 높이 제약 조건 설정
            recipeTextView.constraints.filter { $0.firstAttribute == .height }.first?.constant = newHeight
            view.layoutIfNeeded()
        }
    }
    deinit {
        // 뷰 컨트롤러가 할당 해제될 때 옵저버를 제거
        recipeTextView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    //네비게이션바 커스텀
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "집밥토크 글쓰기"
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "gray2")
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "gray2")
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    
    
   
    
    // 레시피 추가버튼을 눌렀을 때 발생할 이벤트
    @objc func plusButtonTapped() {
        // 스텝을 나타내는 라벨
        lazy var newStepLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
            label.textColor = UIColor(r: 187, g: 187, b: 187)
            label.text = "Step 2"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
                //MARK: - 사진과 앨범 파트
        lazy var newCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            //셀 만들어야 함
            collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            
            return collectionView
        }()
        
        //MARK: - UIButton 파트
        lazy var newAddImageButton : UIButton = {
            let button = UIButton()
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
            let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("사진 추가", for: .normal)
            button.setImage(image, for: .normal)
            button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 18)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.backgroundColor = UIColor(named: "searchtf")
            button.layer.cornerRadius = 14
            button.clipsToBounds = true
            return button
        }()
        
        
            //MARK: - UIImage 파트
            //첫번째 이미지 뷰
            lazy var newImageView: UIImageView = {
                let view = UIImageView()
                view.layer.cornerRadius = 14
                view.clipsToBounds = true
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
              }()
        
        lazy var newCustomButton: UIButton = makeCustomButton()
        
        // 레시피작성 텍스트뷰
        lazy var newRecipeTextView: UITextView = {
            let textView = UITextView()
            textView.text = "레시피를 작성해주세요."
            textView.font = UIFont(name: "NotoSansKR-Medium", size: 16)
            textView.textColor = UIColor(r: 204, g: 204, b: 204)
            textView.layer.cornerRadius = 10
            textView.clipsToBounds = true
            textView.backgroundColor = UIColor(named: "gray4")
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
            return textView
        }()
        
        // 재료입력 텍스트필드
        lazy var newSourceTextField: UITextField = {
            let textField = UITextField()
            textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
            textField.attributedPlaceholder = NSAttributedString(string: "해당 단계에서 사용된 재료를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 204, g: 204, b: 204)])
            textField.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            textField.textColor = UIColor(r: 204, g: 204, b: 204)
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 18.0, height: 0.0))
            textField.leftViewMode = .always
            return textField
        }()
        
        // 요리팁 텍스트필드
        lazy var newTipTextField: UITextField = {
            let textField = UITextField()
            textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
            textField.attributedPlaceholder = NSAttributedString(string: "해당 단계의 요리팁을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 204, g: 204, b: 204)])
            textField.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            textField.textColor = UIColor(r: 204, g: 204, b: 204)
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 18.0, height: 0.0))
            textField.leftViewMode = .always
            return textField
        }()
        
        // 아래쪽 경계선
        lazy var newUnderBorderLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(r: 102, g: 102, b: 102)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        // 스텝 추가 버튼
        lazy var newplusButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "addIcon"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor(r: 150, g: 150, b: 150).cgColor
            button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
            return button
        }()
        
        // 레시피 추가하기 버튼
        lazy var newrecipePlusButton: UIButton = {
            let button = UIButton()
            button.setTitle("레시피 추가하기", for: .normal)
            button.backgroundColor = UIColor(named: "green")
            button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 20)
            button.setTitleColor(.black, for: .normal)
            button.clipsToBounds = true
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        mainView.addSubview(newStepLabel)
        mainView.addSubview(newImageView)
        mainView.bringSubviewToFront(newImageView)
        mainView.addSubview(newCollectionView)
        mainView.addSubview(newCustomButton)
        mainView.addSubview(newRecipeTextView)
        mainView.addSubview(newSourceTextField)
        mainView.addSubview(newTipTextField)
        mainView.addSubview(newUnderBorderLine)
        mainView.addSubview(newplusButton)
        mainView.addSubview(newrecipePlusButton)
        NSLayoutConstraint.activate([
            newStepLabel.topAnchor.constraint(equalTo: prevUnderBorderLine.bottomAnchor, constant: 13.5),
            newStepLabel.leadingAnchor.constraint(equalTo: prevUnderBorderLine.leadingAnchor),
            newStepLabel.heightAnchor.constraint(equalToConstant: 17),
            
            newImageView.topAnchor.constraint(equalTo: self.prevStepLabel.bottomAnchor,constant: 15),
            newImageView.leadingAnchor.constraint(equalTo: self.prevStepLabel.leadingAnchor),
            newImageView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -262),
            newImageView.heightAnchor.constraint(equalToConstant: 111),
            
            newCollectionView.topAnchor.constraint(equalTo: self.prevStepLabel.bottomAnchor, constant:  15),
            newCollectionView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            newCollectionView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            newCollectionView.heightAnchor.constraint(equalToConstant: 111),
            
            newCustomButton.topAnchor.constraint(equalTo: newStepLabel.bottomAnchor, constant: 15),
            newCustomButton.leadingAnchor.constraint(equalTo: newStepLabel.leadingAnchor),
            newCustomButton.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -262),
            newCustomButton.heightAnchor.constraint(equalToConstant: 111),
            
            newRecipeTextView.topAnchor.constraint(equalTo: newCustomButton.bottomAnchor, constant: 20),
            newRecipeTextView.leadingAnchor.constraint(equalTo: newStepLabel.leadingAnchor),
            newRecipeTextView.trailingAnchor.constraint(equalTo: prevUnderBorderLine.trailingAnchor),
            newRecipeTextView.heightAnchor.constraint(equalToConstant: 110),
            
            newSourceTextField.topAnchor.constraint(equalTo: newRecipeTextView.bottomAnchor , constant: 18),
            newSourceTextField.leadingAnchor.constraint(equalTo: newRecipeTextView.leadingAnchor),
            newSourceTextField.trailingAnchor.constraint(equalTo: newRecipeTextView.trailingAnchor),
            newSourceTextField.heightAnchor.constraint(equalToConstant: 50),
            
            newTipTextField.leadingAnchor.constraint(equalTo: newRecipeTextView.leadingAnchor),
            newTipTextField.trailingAnchor.constraint(equalTo: newRecipeTextView.trailingAnchor),
            newTipTextField.topAnchor.constraint(equalTo: newSourceTextField.bottomAnchor, constant: 18),
            newTipTextField.heightAnchor.constraint(equalToConstant: 50),
            
            newUnderBorderLine.leadingAnchor.constraint(equalTo: newRecipeTextView.leadingAnchor),
            newUnderBorderLine.trailingAnchor.constraint(equalTo: newRecipeTextView.trailingAnchor),
            newUnderBorderLine.topAnchor.constraint(equalTo: newTipTextField.bottomAnchor, constant: 19.5),
            newUnderBorderLine.heightAnchor.constraint(equalToConstant: 1),
            
            // 스택뷰 추가버튼
            newplusButton.leadingAnchor.constraint(equalTo: newUnderBorderLine.leadingAnchor),
            newplusButton.trailingAnchor.constraint(equalTo: newUnderBorderLine.trailingAnchor),
            newplusButton.topAnchor.constraint(equalTo: newUnderBorderLine.bottomAnchor, constant: 25),
            newplusButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 레시피 추가버튼
            newrecipePlusButton.leadingAnchor.constraint(equalTo: newplusButton.leadingAnchor),
            newrecipePlusButton.trailingAnchor.constraint(equalTo: newplusButton.trailingAnchor),
            newrecipePlusButton.topAnchor.constraint(equalTo: newplusButton.bottomAnchor, constant: 45),
            newrecipePlusButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        // 새로운 뷰의 높이 계산 및 contentSize 업데이트
            let newViewHeight: CGFloat = 17 + 16 + 111 + 20 + 110 + 18 + 50 + 18 + 50 + 19.5
            scrollView.contentSize.height += newViewHeight

            // contentOffset 조정
            let offsetY = scrollView.contentSize.height - scrollView.bounds.height
            scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)

            // 새로운 뷰를 포함한 스크롤뷰의 크기 조정
            scrollView.frame.size.height += newViewHeight
        

            // 새로운 뷰들이 추가된 후에 plusButton과 recipePlusButton을 맨 아래로 이동
            DispatchQueue.main.async {
                //let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
              //  self.scrollView.setContentOffset(bottomOffset, animated: true)
                
                // plusButton 위치 업데이트
                //self.plusButton.topAnchor.constraint(equalTo: newUnderBorderLine.bottomAnchor, constant: 26.5).isActive = true
                    
                    // recipePlusButton 위치 업데이트
               // self.recipePlusButton.topAnchor.constraint(equalTo: self.plusButton.bottomAnchor, constant: 43).isActive = true
            }
        
        prevStepLabel = newStepLabel
        prevImageView = newImageView
        prevCollectionVIew = newCollectionView
        prevCustomButton = newCustomButton
        prevRecipeTextView = newRecipeTextView
        prevSourceTextField = newSourceTextField
        prevTipTextField = newTipTextField
        prevUnderBorderLine = newUnderBorderLine
        plusButton.isHidden = true
        recipePlusButton.isHidden = true
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: underBorderLine.leadingAnchor),
            plusButton.trailingAnchor.constraint(equalTo: underBorderLine.trailingAnchor),
            plusButton.topAnchor.constraint(equalTo: newUnderBorderLine.bottomAnchor, constant: 25),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
           
            recipePlusButton.leadingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            recipePlusButton.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor),
            recipePlusButton.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 25),
            recipePlusButton.heightAnchor.constraint(equalToConstant: 50), ])
        self.view.layoutIfNeeded()
    }
    
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }
}

// MARK: - Extension
extension RecipeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        
        // 버튼을 숨기고 이미지 뷰를 표시하도록 설정
        //addImageButton.isHidden = true
        imageView.isHidden = false
        customButton.isHidden = true // customButton도 함께 숨김

        self.imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -200), //화면 밖으로 이동시킬려고 밖으로 빼냄
            customButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
            customButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
            customButton.heightAnchor.constraint(equalToConstant: 176),
        ])
    }
}

//MARK: - 사진과 앨범 파트
extension RecipeViewController: PHPickerViewControllerDelegate {
    // 사진 선택이 끝났을 때 호출되는 함수
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let identifiers = results.compactMap(\.assetIdentifier)
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)

        let group = DispatchGroup()
        fetchResult.enumerateObjects { asset, index, pointer in
//            print("위도: \(asset.location?.coordinate.latitude)")
//            print("경도: \(asset.location?.coordinate.longitude)")
//            print("시간: \(asset.location?.timestamp)")
        }
        for result in results {
            group.enter()
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    guard let self = self else { return }

                    if let error = error {
                        print("Error loading image: \(error)")
                        group.leave()
                        return
                    }

                    if let image = image as? UIImage {
                        selectedImages.append(image)
                    }

                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        group.notify(queue: .main) {
            // 모든 이미지가 로드되었을 때 실행되는 부분
            DispatchQueue.main.async { [self] in
                if self.currentMode == .album {
                    // 앨범 모드일 경우의 처리
                    self.customButton.isHidden = true
                    self.collectionView.isHidden = false
                    self.selectedImages = selectedImages

                    // 이미지가 추가되었을 때 디버깅 정보 출력
                    print("selectedImages contents: \(self.selectedImages)")

                    self.collectionView.reloadData() // collectionView 갱신
                }
            }
            // 이미지 피커를 닫음
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - 사진과 앨범 파트 and 태그 파트
extension RecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    // 셀 개수 카운팅
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.collectionView { //사진과 앨범 부분
                return selectedImages.count
            }
            return 0
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == self.collectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
                let image = selectedImages[indexPath.item]
                cell.imageView.image = image
                return cell
            }

            return UICollectionViewCell()
    }
}

extension RecipeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "레시피를 작성해주세요." {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "레시피를 작성해주세요."
        }
    }
}

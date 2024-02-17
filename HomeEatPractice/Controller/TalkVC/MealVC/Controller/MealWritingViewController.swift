

import UIKit
import Then
import AVFoundation
import Photos
import PhotosUI

class MealWritingViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
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
    
    // MARK: - 버튼 스텍뷰
    private let container: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 30
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let breackfastButton: UIButton = {
        let button = UIButton()
        button.setTitle("#아침", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(hashtagTapped(_ :)), for: .touchUpInside)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.isSelected = true
        button.layer.borderColor = UIColor(named: "green")?.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private let lunchButton: UIButton = {
        let button = UIButton()
        button.setTitle("#점심", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(hashtagTapped(_ :)), for: .touchUpInside)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    private let dinnerButton: UIButton = {
        let button = UIButton()
        button.setTitle("#저녁", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(hashtagTapped(_ :)), for: .touchUpInside)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    //MARK: - container 파트
  //  let imagePicker = UIImagePickerController()
    private let hashContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - 일반 프로퍼티
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = "음식이름"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "오늘 먹은 음식 이름은?", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 204, g: 204, b: 204)])
        textField.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        textField.textColor = UIColor(r: 204, g: 204, b: 204)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 18.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let memoTextView: UITextView = {
        let textView = UITextView()
        textView.text = "오늘의 음식이 담고 있는 이야기는?"
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = UIColor(named: "font5")
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(named: "gray4")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 0)
        return textView

    }()
    
    private var isCameraAuthorized: Bool {
       AVCaptureDevice.authorizationStatus(for: .video) == .authorized
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gray3")
        // 화면의 다른 곳을 누려면 키보드가 내려가는 메서드.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
       // view에 탭 제스처를 추가.
        self.view.addGestureRecognizer(tapGesture)
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        
        selectedButton = breackfastButton
        nameTextField.delegate = self
        memoTextView.delegate = self
        navigationControl()
        configUI()
        
    }
    
//MARK: - ViewSet
        func navigationControl() {
            let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
            //간격을 배열로 설정
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            flexibleSpace.width = 5.0
            navigationItem.leftBarButtonItem = backbutton
            let rightBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save(_:)))
            rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            navigationItem.rightBarButtonItem = rightBarButton
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
        
        func configUI() {
            //let customButton = makeCustomButton()
            customButton.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.imageView)
            view.bringSubviewToFront(self.imageView)
            self.view.addSubview(collectionView)
            self.view.addSubview(self.customButton)
            self.view.addSubview(self.container)
            self.container.addArrangedSubview(self.breackfastButton)
            self.container.addArrangedSubview(self.lunchButton)
            self.container.addArrangedSubview(self.dinnerButton)
            self.view.addSubview(self.mealNameLabel)
            self.view.addSubview(self.nameTextField)
            self.view.addSubview(self.memoLabel)
            self.view.addSubview(self.memoTextView)
            memoTextView.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
            
            
            NSLayoutConstraint.activate([
                self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 51),
                self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
                self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
                self.imageView.heightAnchor.constraint(equalToConstant: 176),
                
            ])
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 51),
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 176),
            ])
            
            NSLayoutConstraint.activate([
                customButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48),
                customButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
                customButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
                customButton.heightAnchor.constraint(equalToConstant: 176),
            ])
            
            NSLayoutConstraint.activate([
                self.container.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 370),
                self.container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 47),
                self.container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -47),
                self.container.heightAnchor.constraint(equalToConstant: 40),

                
                self.breackfastButton.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
                self.breackfastButton.topAnchor.constraint(equalTo: self.container.topAnchor),
                self.breackfastButton.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
                
                self.breackfastButton.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
                self.breackfastButton.topAnchor.constraint(equalTo: self.container.topAnchor),
                
                self.dinnerButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
                self.dinnerButton.topAnchor.constraint(equalTo: self.container.topAnchor),
                self.dinnerButton.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
            ])
            
            NSLayoutConstraint.activate([
                self.mealNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21),
                self.mealNameLabel.topAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 44),
                self.mealNameLabel.heightAnchor.constraint(equalToConstant: 26)
            ])
            
            NSLayoutConstraint.activate([
                self.nameTextField.leadingAnchor.constraint(equalTo: self.mealNameLabel.leadingAnchor),
                self.nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
                self.nameTextField.topAnchor.constraint(equalTo: self.mealNameLabel.bottomAnchor, constant: 9),
                self.nameTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            NSLayoutConstraint.activate([
                self.memoLabel.leadingAnchor.constraint(equalTo: self.mealNameLabel.leadingAnchor),
                self.memoLabel.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 31),
                self.memoLabel.heightAnchor.constraint(equalToConstant: 26),
            ])
            
            NSLayoutConstraint.activate([
                self.memoTextView.leadingAnchor.constraint(equalTo: self.mealNameLabel.leadingAnchor),
                self.memoTextView.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
                self.memoTextView.topAnchor.constraint(equalTo: self.memoLabel.bottomAnchor, constant: 9),
                self.memoTextView.heightAnchor.constraint(equalToConstant: 50),
            ])
            
        }

// MARK: - 탭바처리
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨깁니다.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 넘어갈 때 커스텀 탭바를 다시 보이게 합니다.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = false
        }
    }

//MARK: - 키보드 처리
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
        // 뷰를 탭하면 키보드가 내려감.
        view.endEditing(true)
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        // 키보드 높이만큼 뷰를 스크롤하는 코드로 수정
        if let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.view.frame.origin.y = -keyboardFrame.height
        }
    }

    @objc override func keyboardWillHide(_ sender: Notification) {
        // 키보드가 사라질 때 뷰를 원래 위치로 되돌리는 코드로 수정
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 다음 텍스트 필드로 포커스를 이동하는 코드로 수정
        if textField == nameTextField {
            memoTextView.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    
    // contentSize의 변경을 관찰하여 동적으로 높이 조정
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            let newHeight = max(newSize.height, 50) // 최소 높이 제약 조건 설정
            memoTextView.constraints.filter { $0.firstAttribute == .height }.first?.constant = newHeight
            view.layoutIfNeeded()
        }
    }
    deinit {
        // 뷰 컨트롤러가 할당 해제될 때 옵저버를 제거
        memoTextView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    //MARK: - objc 메서드
    var selectedButton: UIButton? = nil
    // 해시태그 버튼을 클릭했을 때 이벤트
    @objc func hashtagTapped(_ sender: UIButton) {
        if let selectedButton = selectedButton {
                // 이전에 선택된 버튼이 있는 경우, 선택 해제
                selectedButton.setTitleColor(UIColor(named: "green"), for: .normal)
                selectedButton.layer.borderColor = UIColor(named: "green")?.cgColor
            selectedButton.layer.borderWidth = 0
            }
            
        // 현재 선택된 버튼 처리
                sender.setTitleColor(UIColor(named: "green"), for: .normal)
                sender.layer.borderColor = UIColor(named: "green")?.cgColor
                sender.layer.borderWidth = 2
                selectedButton = sender
        }
    
    //뒤로가기
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    
    //저장
    @objc func save(_ sender: UIBarButtonItem) {
        let buttonText = selectedButton?.titleLabel?.text
        let trimmedText = buttonText?.replacingOccurrences(of: "#", with: "")
        guard let name = nameTextField.text,
              let memo = memoTextView.text,
              let tag = trimmedText,
              let accessToken = UserDefaults.standard.string(forKey: "loginToken") // 사용자의 토큰을 가져옴
        else {
                // 필요한 정보가 없을 경우 에러 처리 또는 사용자에게 알림
            return
        }
        FoodGeneralAPI.saveFoodTalk(name: name, memo: memo, tag: tag, accessToken: accessToken) { result in
            switch result {
            case .success(let foodTalk):
                    print("FoodTalk 저장 성공: \(foodTalk)")
                    print("title:\(name)")
                    print("content:\(memo)")
                    print("tag:\(tag)")
                
                // 이미지 업로드를 수행합니다.
                FoodGeneralAPI.uploadImages(foodTalkID: foodTalk.id, images: self.selectedImages) { uploadResult in
                    switch uploadResult {
                    case .success:
                        print("이미지 업로드 성공")
                        // 성공 시 처리할 내용 추가
                    case .failure(let error):
                        print("이미지 업로드 실패: \(error.localizedDescription)")
                        // 실패 시 처리할 내용 추가
                    }
                }
                case .failure(let error):
                    print("API 호출 실패: \(error.localizedDescription)")
                    // 실패 시 처리할 내용 추가
                }
            }
        let nextVC = RecipeViewController()
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환
        navigationController?.pushViewController(nextVC, animated: true)
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
    
    
    }

// MARK: - 카메라 버튼 extension
extension MealWritingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        
        // 이미지를 selectedImages 배열에 추가
        selectedImages.append(image)
        // 이미지 뷰에 선택된 이미지 표시
        imageView.image = image
        
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

//MARK: - 사진과 앨범 extension
extension MealWritingViewController: PHPickerViewControllerDelegate {
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
extension MealWritingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

//MARK: - TextView Extension
extension MealWritingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "오늘의 음식이 담고 있는 이야기는?" {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "오늘의 음식이 담고 있는 이야기는?"
        }
    }
}











import UIKit
import Then
import AVFoundation
import Photos
import PhotosUI

class MealWritingViewController: UIViewController{
    
    private lazy var customButton: UIButton = makeCustomButton()
    
    // MARK: - ScrollView 생성
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "gray2")
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        return view
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
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
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(hashtagTapped(_ :)), for: .touchUpInside)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
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
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        return button
    }()
    
    private let dinnerButton: UIButton = {
        let button = UIButton()
        button.setTitle("#저녁", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
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
    
    
    //MARK: - UIButton 파트
    private let addImageButton : UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("사진 추가", for: .normal)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
    //두번째 이미지 뷰
    private let imageView2: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
    //세번째 이미지 뷰
    private let imageView3: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
    
    // MARK: - 일반 프로퍼티
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = "음식이름"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
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
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let memoTextView: UITextView = {
        let textView = UITextView()
        textView.text = "오늘의 음식이 담고 있는 이야기는?"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor(named: "font5")
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(named: "gray4")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 내용 여백 조절
        return textView

    }()
    
    private let recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "green")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let borderLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 102, g: 102, b: 102)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    private var isCameraAuthorized: Bool {
       AVCaptureDevice.authorizationStatus(for: .video) == .authorized
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gray3")
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        memoTextView.delegate = self
        navigationControl()
        configUI()
        
    }
    

    // MARK: - 탭바제거
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
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.mainView)
        self.mainView.addSubview(self.customButton)
        self.mainView.addSubview(self.container)
        self.container.addArrangedSubview(self.breackfastButton)
        self.container.addArrangedSubview(self.lunchButton)
        self.container.addArrangedSubview(self.dinnerButton)
        self.mainView.addSubview(self.mealNameLabel)
        self.mainView.addSubview(self.nameTextField)
        self.mainView.addSubview(self.memoLabel)
        self.mainView.addSubview(self.memoTextView)
        memoTextView.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
        self.mainView.addSubview(self.recipeLabel)
        self.mainView.addSubview(self.borderLine)
        
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.mainView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.mainView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.mainView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.mainView.heightAnchor.constraint(equalToConstant: 1000)
        ])
        
        NSLayoutConstraint.activate([
            self.customButton.topAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.topAnchor, constant: 48),
            self.customButton.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 108),
            self.customButton.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -108),
            self.customButton.heightAnchor.constraint(equalToConstant: 176),
        ])
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.customButton.bottomAnchor, constant: 44),
            self.container.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 47),
            self.container.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -47),
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
            self.mealNameLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 21),
            self.mealNameLabel.topAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 44),
            self.mealNameLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        NSLayoutConstraint.activate([
            self.nameTextField.leadingAnchor.constraint(equalTo: self.mealNameLabel.leadingAnchor),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor,constant: -20),
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
        
        NSLayoutConstraint.activate([
            self.recipeLabel.leadingAnchor.constraint(equalTo: self.mealNameLabel.leadingAnchor),
            self.recipeLabel.topAnchor.constraint(equalTo: self.memoTextView.bottomAnchor, constant: 31),
            self.recipeLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        NSLayoutConstraint.activate([
            self.borderLine.leadingAnchor.constraint(equalTo: self.mealNameLabel.leadingAnchor),
            self.borderLine.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.borderLine.heightAnchor.constraint(equalToConstant: 1),
            self.borderLine.topAnchor.constraint(equalTo: self.recipeLabel.bottomAnchor, constant: 16.6)
            
        ])
        
    }
    
    //뒤로가기
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    
    //저장
    @objc func save(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, let memo = memoTextView.text, let tag = breackfastButton.titleLabel?.text else {
            // title 또는 content가 nil이라면 에러 처리 또는 사용자에게 알림
                return
        }

        MealGeneralAPI.saveFoodTalk(name: name, memo: memo, tag: tag) { result in
            switch result {
                case .success:
                    print("API 호출 성공")
                    // 성공 시 처리할 내용 추가
                case .failure(let error):
                    print("API 호출 실패: \(error.localizedDescription)")
                    // 실패 시 처리할 내용 추가
                }
            }
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
        customButton.translatesAutoresizingMaskIntoConstraints = false  // Add this line to set constraints programmatically

        return customButton
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
    
    // MARK: - @objc 메서드
    @objc func buttonTapped() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.openCamera()
        }

        let chooseFromLibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
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
    
    @objc func hashtagTapped(_ sender: UIButton) {
        print("click")
    }
    
    @objc func navigateToTagPlusViewController(_ sender: Any) {
        let tagplusVC = TagPlusViewController()
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환

        self.navigationController?.pushViewController(tagplusVC, animated: true)
        print("tagplus click")
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

// MARK: - Extension
extension MealWritingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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

extension MealWritingViewController: PHPickerViewControllerDelegate {
    // 사진 선택이 끝났을때 들어오는 함수
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let identifiers = results.compactMap(\.assetIdentifier)
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        
        // asset - 메타데이터 들어있음
        fetchResult.enumerateObjects { asset, index, pointer in
            // 사진 위치 정보
            print("위도: \(asset.location?.coordinate.latitude)")
            print("경도: \(asset.location?.coordinate.longitude)")
            // 위도, 경도를 CLGeocoder를 사용하여 주소로 바꿀 수 있다. (이건 생략)
            
            // 사진 시간 정보
            print("시간: \(asset.location?.timestamp)")
        }
        
        let itemProvider = results.first?.itemProvider
        
        // UIImage로 추출
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                guard let image = image as? UIImage else { return }
                // code...
            }
        }
        
        // 갤러리뷰 닫기
        picker.dismiss(animated: true, completion: nil)
    }
}
extension MealWritingViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

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




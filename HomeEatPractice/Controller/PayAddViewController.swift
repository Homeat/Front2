//
//  AddExpenditureViewController.swift
//  Homeat
//
//  Created by 강삼고 on 1/6/24.
//

import Foundation
import UIKit
import AVFoundation
import Photos
import PhotosUI

class PayAddViewController : UIViewController, UITextFieldDelegate{
    var hashTag = ""
    var memoString = ""
    var expenseData = 0
    
    
    private var selectedImages : UIImage?
    let talk12Image: UIImage? = UIImage(named: "Talk12")

    private lazy var customButton: UIButton = makeCustomButton()
    private enum Mode {
            case camera
            case album
    }
    private var currentMode: Mode = .camera
    private let postLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "메모"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    //첫번째 이미지 뷰
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
    
    //MARK: - UItextField
    
    private let priceTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "지출 금액을 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont")])
        textField.backgroundColor = UIColor(named: "gray4")
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.textColor = .white
        textField.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField

    }()
    
    private let postTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "gray4")
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textField.attributedPlaceholder = NSAttributedString(string: "오늘의 지출이 담고 있는 이야기는?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont")])
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.textColor = .white
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    

    //MARK: - container 파트
    
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
    private lazy var tagButton1: UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("#장보기")
        attributedTitle.font = .systemFont(ofSize: 15, weight: .bold)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "gray4")
        config.baseForegroundColor = UIColor(named: "green")
        
        let buttonAction = UIAction { _ in
            self.tagButton1.isSelected.toggle()
            if self.tagButton2.isSelected{
                self.tagButton2.isSelected.toggle()
            }
            if self.tagButton3.isSelected{
                self.tagButton3.isSelected.toggle()
            }
            self.hashTag = "장보기"
            print(self.hashTag ?? "nil")
        }
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        
        button.configurationUpdateHandler = { button in
            
            switch button.state{
            case .selected:
                button.layer.borderColor = UIColor(named: "green")?.cgColor
            default:
                button.layer.borderColor = UIColor(named: "gray2")?.cgColor
            }
        }
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "gray2")?.cgColor
        return button
         }()
    
    private lazy var tagButton2: UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("#외식비")
        attributedTitle.font = .systemFont(ofSize: 15, weight: .bold)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "gray4")
        config.baseForegroundColor = UIColor(named: "green")
        
        let buttonAction = UIAction { _ in
            self.tagButton2.isSelected.toggle()
            if self.tagButton1.isSelected{
                self.tagButton1.isSelected.toggle()
            }
            if self.tagButton3.isSelected{
                self.tagButton3.isSelected.toggle()
            }
            
            self.hashTag = "외식비"
            print(self.hashTag ?? "nil")
        }
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        
        button.configurationUpdateHandler = { button in
            
            switch button.state{
            case .selected:
                button.layer.borderColor = UIColor(named: "green")?.cgColor
            default:
                button.layer.borderColor = UIColor(named: "gray2")?.cgColor
            }
        }
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "gray2")?.cgColor
        return button
         }()
    
    private lazy var tagButton3: UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("#배달비")
        attributedTitle.font = .systemFont(ofSize: 15, weight: .bold)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "gray4")
        config.baseForegroundColor = UIColor(named: "green")
        
        let buttonAction = UIAction { _ in
            self.tagButton3.isSelected.toggle()
            if self.tagButton2.isSelected{
                self.tagButton2.isSelected.toggle()
            }
            if self.tagButton1.isSelected{
                self.tagButton1.isSelected.toggle()
            }
            self.hashTag = "배달비"
            print(self.hashTag)

        }
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        
        button.configurationUpdateHandler = { button in
            
            switch button.state{
            case .selected:
                button.layer.borderColor = UIColor(named: "green")?.cgColor
            default:
                button.layer.borderColor = UIColor(named: "gray2")?.cgColor
            }
        }
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "gray2")?.cgColor
        return button
         }()
    //MARK: - 사진과 앨범 파트
    private var isCameraAuthorized: Bool {
       AVCaptureDevice.authorizationStatus(for: .video) == .authorized
     }
//MARK: - 뷰에 추가
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: "loginToken"))
        
        self.view.backgroundColor = UIColor(named: "gray2")
        //현재 뷰에서는 tabBar 사용 안 함
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        configUI()
        //네비게이션 바
        let saveButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save(_:)))
        saveButtonItem.tintColor = UIColor(named: "green")
        self.navigationItem.setRightBarButton(saveButtonItem, animated: false)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.tabBarController?.tabBar.isHidden = true
        self.title = "지출 추가"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        postTextField.delegate = self
        priceTextField.delegate = self
        customButton.translatesAutoresizingMaskIntoConstraints = false
//MARK: - 제약설정
        NSLayoutConstraint.activate([
            
//            customButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -526),
            
            priceTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 267),
            priceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
            priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
            priceTextField.heightAnchor.constraint(equalToConstant: 43),
            
            self.hashContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37),
            self.hashContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -37),
            self.hashContainer.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 37),
            self.hashContainer.heightAnchor.constraint(equalToConstant: 40),
            
            self.postLabel.topAnchor.constraint(equalTo: hashContainer.bottomAnchor, constant: 25),
            self.postLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            self.postTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.postTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.postTextField.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 5),
//            self.postTextField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -272),
            
        ])
       
        
    }
    func configUI() {
        self.view.addSubview(self.hashContainer)
        self.hashContainer.addArrangedSubview(tagButton1)
        self.hashContainer.addArrangedSubview(tagButton2)
        self.hashContainer.addArrangedSubview(tagButton3)
        self.view.addSubview(postLabel)
        self.view.addSubview(postTextField)
        self.view.addSubview(priceTextField)
        self.view.addSubview(self.imageView)
        view.bringSubviewToFront(self.imageView)
        self.view.addSubview(customButton)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 51),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
            self.imageView.heightAnchor.constraint(equalToConstant: 176),
            
        ])
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48),
            customButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
            customButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
            customButton.heightAnchor.constraint(equalToConstant: 176),
        ])
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
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == postTextField{
            memoString = textField.text ?? ""
        }
    }
    //memo textfield 입력 종료시에 update
    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField == priceTextField{
            if let text = textField.text, let intValue = Int(text) {
                print(text)
                expenseData = intValue
            } else {
                // 변환 실패 시 기본값(0)을 사용합니다.
                expenseData = 0
            }
        }

    }
    
    func makeCustomButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("영수증 사진 촬영")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .bold)
        config.attributedTitle = attributedTitle
        let pointSize = CGFloat(30)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        config.image = UIImage(named: "cameraIcon")
        config.preferredSymbolConfigurationForImage = imageConfig

        config.imagePlacement = .top
        config.background.backgroundColor = UIColor(named: "searchtf")
        config.baseForegroundColor = .white
//        config.baseBackgroundColor = .darkGray
        config.cornerStyle = .small

        // 이미지와 텍스트 간격 조절
        config.imagePadding = 19.7

        let customButton = UIButton(configuration: config)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        return customButton
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
                self.pickImage()
            @unknown default:
                print("PHPhotoLibrary::execute - \"Unknown case\"")
            }
        }
    }
    func pickImage() {
        let photoLibrary = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])

        DispatchQueue.main.async {
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self // 이 부분을 추가해줍니다.
            picker.isEditing = true
            self.present(picker, animated: true, completion: nil)
        }
    }
//MARK: - save 버튼 파트
    @objc func save(_ sender: UIBarButtonItem){
        print(expenseData)
        print(memoString)
        print(hashTag)
        print(selectedImages)
        
        if let selectedImage = self.selectedImages {
            HomeAPI.uploadImage(image: selectedImage) { uploadResult in
                switch uploadResult {
                case .success:
                    print("이미지 업로드 성공")
                    let ocrPrice = UserDefaults.standard.value(forKey: "ocrPrice")
                    
                    HomeAPI.postExpense(money: ocrPrice as! Int , type: self.hashTag, memo: self.memoString) { result in
                        switch result {
                        case .success:
                            print("(ocr)payAdd API 호출 성공")
                            
                            HomeAPI.getHomeData(){result in
                                switch result{
                                case .success:
                                    print("data불러오기 성공")
                                case .failure(_):
                                    print("data불러오기 실패")
                                }
                                
                            }
                        case .failure(_):
                            print("(ocr)payAdd API 호출 실패")
                        }
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                case .failure(let error):
                    print("이미지 업로드 실패: \(error.localizedDescription)")
                    // 실패 시 처리할 내용 추가
                }
            }
        } else {
            print("선택된 이미지가 없습니다.")
            // 선택된 이미지가 없을 때 처리할 내용 추가
            HomeAPI.postExpense(money: expenseData , type: hashTag, memo: memoString) { result in
                switch result {
                case .success:
                    print("payAdd API 호출 성공")
                    
                    HomeAPI.getHomeData(){result in
                        switch result{
                        case .success:
                            print("data불러오기 성공")
                        case .failure(_):
                            print("data불러오기 실패")
                        }
                        
                    }
                case .failure(_):
                    print("payAdd API 호출 실패")
                }
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        

        
    }
    @objc func buttonTapped(){
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.currentMode = .camera
            self.openCamera()
        }
        let chooseFromLibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
            self.currentMode = .album

            self.customButton.isHidden = true
            self.touchUpImageAddButton(button: self.customButton)
        }
        let cancleAction = UIAlertAction(title: "취소", style: .cancel , handler: nil)
        takePhotoAction.setValue(UIColor.white, forKey: "titleTextColor")
        chooseFromLibraryAction.setValue(UIColor.white, forKey: "titleTextColor")
        cancleAction.setValue(UIColor.red, forKey: "titleTextColor")
//        firstAction.setValue(UIColor.darkGray, forKey: "backgroundColor")
//        secondAction.setValue(UIColor.darkGray, forKey: "backgroundColor")
//        cancleAction.setValue(UIColor.darkGray, forKey: "backgroundColor")
        
        
        actionSheetController.addAction(takePhotoAction)
        actionSheetController.addAction(chooseFromLibraryAction)
        actionSheetController.addAction(cancleAction)
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
    func showAlert(message: String) {
            let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
             }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    
}


// 키보드 숨기기
extension UIViewController {
    
    
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
            self.view.frame.origin.y = -100
    }
    //키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
            self.view.frame.origin.y = 0
    }
    
    
}

extension PayAddViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        // 이미지를 selectedImages 배열에 추가
        selectedImages = image
        
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
extension PayAddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let provider = results.first?.itemProvider else { return }
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    // 이미지를 selectedImages 배열에 추가
                    self?.selectedImages = image
                    // 이미지 뷰에 선택된 이미지 표시
                    self?.imageView.image = image
                    // 버튼을 숨기고 이미지 뷰를 표시하도록 설정
                    self?.imageView.isHidden = false
                    self?.customButton.isHidden = true
                }
            }
        }
    }
}





//
//  AddExpenditureViewController.swift
//  Homeat
//
//  Created by 강삼고 on 1/6/24.
//

//구현 해야 하는 부분
//1. 네비게이션 바?
//2. 사진 추가(버튼) 동작은 나중에 구현
//3. 해시태그 부분(버튼) 누르면 색 바뀌게 구현
//4. 메모 (오늘의 지출이 담긴 부분은?)

//남은거
//- 네비게이션 바 구현
//- 키보드 return 누르면 키보드 내려가게
//- 키보드 입력시 화면 밀리게 만들기
//- uibutton 커스텀 공부해서 다시 만들기
//- 버튼들 기능구현
import Foundation
import UIKit
import AVFoundation
import Photos


class PayAddViewController : UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    
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

            
            //continueButton 활성화 비활성화 구문
//            if self.maleButton.isSelected || self.femaleButton.isSelected{
//                self.continueButton.isEnabled = true
//                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "green")
//            }
//            else{
//                self.continueButton.isEnabled = false
//                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
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

            
            //continueButton 활성화 비활성화 구문
//            if self.maleButton.isSelected || self.femaleButton.isSelected{
//                self.continueButton.isEnabled = true
//                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "green")
//            }
//            else{
//                self.continueButton.isEnabled = false
//                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
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

            //continueButton 활성화 비활성화 구문
//            if self.maleButton.isSelected || self.femaleButton.isSelected{
//                self.continueButton.isEnabled = true
//                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "green")
//            }
//            else{
//                self.continueButton.isEnabled = false
//                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
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
    
    // price Label -> textField 로 수정 및 콤마 자동으로 찍히게, 원 표시 어떻게 할 것인가 생각해봐야함
    private let priceLabel : UILabel = {
        let label = UILabel()
        let text = "23,800원"
        label.text = text
//        let attributedString = NSAttributedString(string: text)
//        attributedString.addAttribute(<#T##NSAttributedString.Key#>, value: <#T##Any#>, range: <#T##NSRange#>)
        
        label.font = UIFont.systemFont(ofSize: 30, weight : .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - UItextField
    
    
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
    private let addImageButton : UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("사진 추가", for: .normal)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        return button
    }()
    

//MARK: - 뷰에 추가
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "gray2")
        //현재 뷰에서는 tabBar 사용 안 함
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        self.imagePicker.delegate = self

        //네비게이션 바
        let saveButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: nil)
        saveButtonItem.tintColor = .green
        self.navigationItem.setRightBarButton(saveButtonItem, animated: false)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.tabBarController?.tabBar.isHidden = true
        self.title = "지출 추가"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        postTextField.delegate = self
    
        self.view.addSubview(self.hashContainer)
        self.hashContainer.addArrangedSubview(tagButton1)
        self.hashContainer.addArrangedSubview(tagButton2)
        self.hashContainer.addArrangedSubview(tagButton3)
        self.view.addSubview(postLabel)
        self.view.addSubview(postTextField)
        self.view.addSubview(priceLabel)
        
        let customButton = makeCustomButton()
        customButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(customButton)
//MARK: - 제약설정
        NSLayoutConstraint.activate([
            self.hashContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37),
            self.hashContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -37),
            self.hashContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 426),
            self.hashContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -386),
            
            self.postLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 491),
            self.postLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            self.postTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.postTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.postTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530),
            self.postTextField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -272),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 355),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -463),
            self.priceLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            
            customButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            customButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
            customButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
            customButton.bottomAnchor.constraint(equalTo: self.priceLabel.topAnchor, constant: -29)
            
        ])
       
        
    }
    
    func cameraAuth() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                print("카메라 권한 허용")
                self.openCamera()
            } else {
                print("카메라 권한 거부")
                self.showAlertAuth("카메라")
            }
        }
    }
    
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨깁니다.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = true
        }
    }
    

    func albumAuth() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .denied:
            print("거부")
            self.showAlertAuth("앨범")
        case .authorized:
            print("허용")
            self.openPhotoLibrary()
        case .notDetermined, .restricted:
            print("아직 결정하지 않은 상태")
            PHPhotoLibrary.requestAuthorization { state in
                if state == .authorized {
                    self.openPhotoLibrary()
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        default:
            break
        }
    }
    private func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.modalPresentationStyle = .currentContext
            self.present(self.imagePicker,animated: true,completion: nil)
        } else {
            print("카메라에 접근할 수 없습니다.")
        }
    }
    private func openPhotoLibrary() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.modalPresentationStyle = .currentContext
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            print("앨범에 접근할 수 없습니다.")
        }
    }
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("image_info = \(image)")
        }
        dismiss(animated: true, completion: nil)
    }
    func showAlertAuth(
        _ type: String
    ) {
        if let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
            let alertVC = UIAlertController(
                title: "설정",
                message: "\(appName)이(가) \(type) 접근 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?",
                preferredStyle: .alert
            )
            let cancelAction = UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: nil
            )
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            alertVC.addAction(cancelAction)
            alertVC.addAction(confirmAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    
    func makeCustomButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("사진 추가")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .bold)
        config.attributedTitle = attributedTitle
        let pointSize = CGFloat(30)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        config.image = UIImage(systemName: "camera.fill")
        config.preferredSymbolConfigurationForImage = imageConfig

        config.imagePlacement = .top
        config.background.backgroundColor = .darkGray
        config.baseForegroundColor = .lightGray
//        config.baseBackgroundColor = .darkGray
        config.cornerStyle = .small

        // 이미지와 텍스트 간격 조절
        config.imagePadding = 12.7
        config.titlePadding = 10

        let customButton = UIButton(configuration: config)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        return customButton
    }
    
    @objc func buttonTapped(){
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.cameraAuth()
        }
        let secondAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
            self.albumAuth()
        }
        let cancleAction = UIAlertAction(title: "취소", style: .cancel , handler: nil)
        firstAction.setValue(UIColor.white, forKey: "titleTextColor")
        secondAction.setValue(UIColor.white, forKey: "titleTextColor")
        cancleAction.setValue(UIColor.red, forKey: "titleTextColor")
//        firstAction.setValue(UIColor.darkGray, forKey: "backgroundColor")
//        secondAction.setValue(UIColor.darkGray, forKey: "backgroundColor")
//        cancleAction.setValue(UIColor.darkGray, forKey: "backgroundColor")
        
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancleAction)
        self.present(actionSheetController, animated: true, completion: nil)
        
        
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
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
    //키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
            self.view.frame.origin.y = -100
    }
    //키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
            self.view.frame.origin.y = 0
    }
    
    
}



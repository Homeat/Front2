//
//  RegisterViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//

import Foundation
import UIKit

class RegisterViewController : UIViewController ,UITextFieldDelegate{
    
    private let registerContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let emailContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 11
        stackView.axis = .horizontal
        stackView.alignment = .fill
        
        return stackView
    }()
    
    
    private let tagLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이메일"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let tagLabel2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이메일 인증"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let tagLabel3 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let tagLabel4 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호 확인"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let tagLabel5 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "닉네임"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private lazy var notiLabel1 : UILabel = {
        let label = makeNotiLabel(massage: " ")
        return label
    }()
    
    private lazy var notiLabel2 : UILabel = {
        let label = makeNotiLabel(massage: " ")
        return label
    }()
    private lazy var notiLabel3 : UILabel = {
        let label = makeNotiLabel(massage: " ")
        return label
    }()
    private lazy var notiLabel4 : UILabel = {
        let label = makeNotiLabel(massage: " ")
        return label
    }()
    private lazy var notiLabel5 : UILabel = {
        let label = makeNotiLabel(massage: " ")
        label.textColor = .white
        return label
    }()
    
    
    
    private let emailTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해 주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private let emailCheckTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "이메일에 전송된 번호를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private let pwTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "비밀번호는 8~20자로 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private let pwCheckTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private let nickNameTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "한국어, 영어 모두 가능해요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private lazy var certifyButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("인증")
        attributedTitle.font = .systemFont(ofSize: 16, weight: .medium)
        config.attributedTitle = attributedTitle
        config.cornerStyle = .small
        config.background.backgroundColor = UIColor(named: "searchfont")
        config.baseForegroundColor = .black
        
        let buttonAction = UIAction { _ in
        
         }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        button.widthAnchor.constraint(equalToConstant: 79).isActive = true
        return button
    }()
    
    private lazy var continueButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("계속하기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "searchfont")
        config.baseForegroundColor = .black
        config.cornerStyle = .small

        let buttonAction = UIAction{ _ in
            
            guard let email = self.emailTextField.text, let password = self.pwTextField.text, let nickname = self.nickNameTextField.text else {
                // title 또는 content가 nil이라면 에러 처리 또는 사용자에게 알림
                
                
                
                return
            }
            
            MemberAPI.saveMemberInfo(email: email, password: password, nickname: nickname) { result in
                switch result {
                case .success:
                    print("API 호출 성공")
                    // 성공 시 처리할 내용 추가
                case .failure(let error):
                    print("API 호출 실패: \(error.localizedDescription)")
                    // 실패 시 처리할 내용 추가
                }
            }
            
            self.navigationController?.pushViewController(RegisterDoneViewController(), animated: true)
            
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        return customButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        let _ = continueButton
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //keyboard 유무 인식 notificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.view.addSubview(registerContainer)
        self.view.addSubview(emailContainer)
        
        //return 입력시 키보드 사라지게 하기 위한 delegate 위임
        emailTextField.delegate = self
        emailCheckTextField.delegate = self
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
        nickNameTextField.delegate = self
        
        //textField 타이핑 인식 추가
        emailTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        emailCheckTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        pwCheckTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        emailCheckTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        nickNameTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        self.emailContainer.addArrangedSubview(emailTextField)
        self.emailContainer.addArrangedSubview(certifyButton)
        
        self.registerContainer.addArrangedSubview(tagLabel1)
        self.registerContainer.addArrangedSubview(emailContainer)
        self.registerContainer.addArrangedSubview(notiLabel1)
        
        self.registerContainer.addArrangedSubview(tagLabel2)
        self.registerContainer.addArrangedSubview(emailCheckTextField)
        self.registerContainer.addArrangedSubview(notiLabel2)
        
        self.registerContainer.addArrangedSubview(tagLabel3)
        self.registerContainer.addArrangedSubview(pwTextField)
        self.registerContainer.addArrangedSubview(notiLabel3)
        
        self.registerContainer.addArrangedSubview(tagLabel4)
        self.registerContainer.addArrangedSubview(pwCheckTextField)
        self.registerContainer.addArrangedSubview(notiLabel4)
        
        self.registerContainer.addArrangedSubview(tagLabel5)
        self.registerContainer.addArrangedSubview(nickNameTextField)
        self.registerContainer.addArrangedSubview(notiLabel5)
        
        self.registerContainer.addArrangedSubview(continueButton)
        //        registerContainer.setCustomSpacing(21, after: emailTextField)
        //        registerContainer.setCustomSpacing(21, after: emailCheckTextField)
        //        registerContainer.setCustomSpacing(21, after: pwTextField)
        //        registerContainer.setCustomSpacing(21, after: pwCheckTextField)
        //        registerContainer.setCustomSpacing(38, after: nickNameTextField)
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 127),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76)
            
        ])
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPw(_ pw: String) -> Bool {
        let pwRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
        let pwPredicate = NSPredicate(format: "SELF MATCHES %@", pwRegex)
        return pwPredicate.evaluate(with: pw)
    }
    
    //notilabel 띄우는 함수
    @objc func didTextFieldChanged(_ sender: UITextField){
        if sender == emailTextField{
            if isValidEmail(emailTextField.text ?? "") || emailTextField.text == ""{
                notiLabel1.text = " "
            }
            else{
                notiLabel1.text = "이메일은 yejin09071@gmail.com의 형태로 입력해주세요."
            }
        }
        //인증번호 조건 설정 필요
        else if sender == emailCheckTextField {
            if (sender.text ?? "").count >= 5 || emailCheckTextField.text == ""{
                notiLabel2.text = " "
            }
            else{
                notiLabel2.text = "다시 입력해주세요."
            }
        }
        else if sender == pwTextField{
            if isValidPw(pwTextField.text ?? "") || pwTextField.text == ""{
                notiLabel3.text = " "
            }
            else{
                notiLabel3.text = "8~20자, 영문 대소문자, 숫자, 특수문자 혼합"
            }
        }
        
        else if sender == pwCheckTextField {
            if pwCheckTextField.text == pwTextField.text || pwCheckTextField.text == ""{
                notiLabel4.text = " "
            }
            else{
                notiLabel4.text = "다시 입력해주세요."
            }
        }
        
        else if sender == nickNameTextField {
            if nickNameTextField.text == ""{
                notiLabel5.text = " "
            }
            else{
                notiLabel5.text = "멋진 닉네임이네요:)"
            }
            
        }
        
    }
    
    
    func setupSpacing() {
        registerContainer.setCustomSpacing(11, after: tagLabel1)
        registerContainer.setCustomSpacing(11, after: tagLabel2)
        registerContainer.setCustomSpacing(11, after: tagLabel3)
        registerContainer.setCustomSpacing(11, after: tagLabel4)
        registerContainer.setCustomSpacing(11, after: tagLabel5)
        
        registerContainer.setCustomSpacing(17, after: notiLabel1)
        registerContainer.setCustomSpacing(17, after: notiLabel2)
        registerContainer.setCustomSpacing(17, after: notiLabel3)
        registerContainer.setCustomSpacing(17, after: notiLabel4)
        registerContainer.setCustomSpacing(28, after: notiLabel5)
        
    }
    
    func makeNotiLabel(massage : String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = massage
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(r: 255, g: 109, b: 109)
        label.textAlignment = .left
        return label
    }
    
    //키보드 관련 func
    
    //화면 터치해서 키패드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
             }
    
    //done버튼 클릭해서 키패드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}

func makeTextField() -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = UIColor(named: "gray4")
    textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    textField.layer.cornerRadius = 10
    textField.layer.masksToBounds = true
    textField.textColor = .white
    textField.heightAnchor.constraint(equalToConstant: 57).isActive = true
    
    let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: textField.frame.height))
    textField.leftView = leftPaddingView
    textField.leftViewMode = .always
    return textField
}



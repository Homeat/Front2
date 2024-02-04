//
//  FindPwViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/2/24.
//

import Foundation
import UIKit

class FindPwViewController : UIViewController ,UITextFieldDelegate{
    let scrollView : UIScrollView = UIScrollView()
    let contentView : UIView! = UIView()
    
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
    
    private let mainLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "등록된 이메일로 찾기"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let mainLabel2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "가입 당시 입력한 이메일을 통해 인증 후\n새 비밀번호를 등록해주세요."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
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

    
    
    private let emailTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "가입한 이메일을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private let emailCheckTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "이메일에 전송된 번호를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private let pwTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "변경할 비밀번호를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return TextField
        
    }()
    
    private let pwCheckTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "gray2")
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.contentView.addSubview(registerContainer)
        let continueButton = makeCustomButton(viewController: self, nextVC: PwChangedViewController())
        continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
        continueButton.configuration?.title = "변경하기"
        
        //return 입력시 키보드 사라지게 하기 위한 delegate 위임
        emailTextField.delegate = self
        emailCheckTextField.delegate = self
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
        
        //textField 타이핑 인식 추가
        emailTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        emailCheckTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        pwCheckTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        emailCheckTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)

        self.emailContainer.addArrangedSubview(emailTextField)
        self.emailContainer.addArrangedSubview(certifyButton)
        
        self.registerContainer.addArrangedSubview(mainLabel1)
        self.registerContainer.addArrangedSubview(mainLabel2)
        
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

        
        self.registerContainer.addArrangedSubview(continueButton)
        setupSpacing()

        
        
        
        
        
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                        
            
            self.registerContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 42),
            self.registerContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
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
        else if sender == emailCheckTextField{
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
        
        
    }
    
    
    func setupSpacing() {
        registerContainer.setCustomSpacing(20, after: mainLabel1)
        registerContainer.setCustomSpacing(30, after: mainLabel2)
        
        registerContainer.setCustomSpacing(11, after: tagLabel1)
        registerContainer.setCustomSpacing(11, after: tagLabel2)
        registerContainer.setCustomSpacing(11, after: tagLabel3)
        registerContainer.setCustomSpacing(11, after: tagLabel4)
        
        registerContainer.setCustomSpacing(17, after: notiLabel1)
        registerContainer.setCustomSpacing(17, after: notiLabel2)
        registerContainer.setCustomSpacing(17, after: notiLabel3)
        registerContainer.setCustomSpacing(17, after: notiLabel4)
        
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

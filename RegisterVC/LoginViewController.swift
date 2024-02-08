//
//  LoginViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//

// textField에 입력 시 x버튼 나오게 구현해야함

import Foundation
import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate {
    
    
    
    private let homeatLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let Container : UIStackView = { //register & findPw container
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
//        stackView.spacing = 2
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
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let slash : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "|"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "gray2")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(tapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private let findPwButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "gray2")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(tapFindPwButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton : UIButton = {
            var config = UIButton.Configuration.plain()
            var attributedTitle = AttributedString("로그인")
            attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
            config.attributedTitle = attributedTitle
            config.background.backgroundColor = UIColor(named: "green")
            config.baseForegroundColor = .black
            let buttonAction = UIAction{ _ in
                let newRootViewController = MainTabBarController()
                
                guard let email = self.emailTextField.text, let password = self.pwTextField.text else {
                    // title 또는 content가 nil이라면 에러 처리 또는 사용자에게 알림
                    
                    return
                }
                
                MemberAPI.postLoginInfo(email: email, password: password) { result in
                    switch result {
                    case .success:
                        print("API 호출 성공")
                        
                        //유저 데이터 받아와서 저장
                        let jwtToken = UserDefaults.standard.string(forKey: "loginToken")

                        MemberAPI.getUserInfo(jwtToken: jwtToken ?? " ") { result in
                            switch result {
                            case .success(let userData):
                                // 받아온 데이터를 저장
                                UserDefaults.standard.set(userData.email, forKey: "userEmail")
                                UserDefaults.standard.set(userData.nickname, forKey: "userNickname")
                            case .failure(let error):
                                // 에러가 발생한 경우
                                print("요청 실패:", error)
                            }
                        }
                        
                        // 애니메이션을 설정합니다.
                        let transition = CATransition()
                        transition.duration = 0.3
                        transition.type = CATransitionType.push
                        transition.subtype = CATransitionSubtype.fromRight
                        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                        
                        // 애니메이션을 적용하고 루트 뷰 컨트롤러를 변경합니다.
                        if let window = UIApplication.shared.keyWindow {
                            window.layer.add(transition, forKey: kCATransition)
                            window.rootViewController = newRootViewController
                        }
                        
                    case .failure(let error):
                        print("API 호출 실패: \(error.localizedDescription)")
                        // 실패 시 처리할 내용 추가
                    }
                }

            }
        
            let button = UIButton(configuration: config, primaryAction: buttonAction)
            button.heightAnchor.constraint(equalToConstant: 57).isActive = true

            return button
        }()
    
    private let emailTextField : UITextField = {
        let emailTextField = makeTextField()
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return emailTextField
        
    }()
    
    private let pwTextField : UITextField = {
        let pwTextField = makeTextField()
        pwTextField.clearButtonMode = .whileEditing
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호 입력", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        pwTextField.isSecureTextEntry = true
        return pwTextField
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        
        self.view.addSubview(homeatLogo)
        self.view.addSubview(loginContainer)
        self.view.addSubview(Container)
        

        self.loginContainer.addArrangedSubview(tagLabel1)
        self.loginContainer.addArrangedSubview(emailTextField)
        self.loginContainer.addArrangedSubview(tagLabel2)
        self.loginContainer.addArrangedSubview(pwTextField)
       
        
        self.loginContainer.addArrangedSubview(loginButton)
        loginContainer.setCustomSpacing(41, after: emailTextField)
        loginContainer.setCustomSpacing(197, after: pwTextField)
    
        self.Container.addArrangedSubview(registerButton)
        self.Container.addArrangedSubview(slash)
        self.Container.addArrangedSubview(findPwButton)
        
        
        //return 입력시 키보드 사라지게 하기 위한 delegate 위임
        emailTextField.delegate = self
        pwTextField.delegate = self
        
        
        
        NSLayoutConstraint.activate([
            //loginContainer 안에 container 넣을 수 있는지 확인
            self.homeatLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 117),
            self.homeatLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -118),
            self.homeatLogo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 211),
//            self.homeatLogo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -615),
            
            self.loginContainer.topAnchor.constraint(equalTo: homeatLogo.bottomAnchor, constant: 55),
            self.loginContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.loginContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            self.loginContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
            self.Container.topAnchor.constraint(equalTo: self.loginContainer.topAnchor, constant: 261),
            self.Container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120),
            self.Container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -120),
//            self.Container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -281)
            
        ])
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
    
    @objc func tapRegisterButton(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func tapFindPwButton(_ sender: Any) {
        self.navigationController?.pushViewController(FindPwViewController(), animated: true)
    }
}


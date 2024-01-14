//
//  LoginViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//

// textField에 입력 시 x버튼 나오게 구현해야함

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    
    
    private let homeatLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HomeatLogo")
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
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = .green
        label.textAlignment = .left
        return label
    }()
    
    private let tagLabel2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = .green
        label.textAlignment = .left
        return label
    }()
    
    private let slash : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "|"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "RegisterBackground")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)

        return button
    }()
    
    private let findPwButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "RegisterBackground")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)

        return button
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "WarmGray")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true


        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "RegisterBackground")
        
        self.view.addSubview(homeatLogo)
        self.view.addSubview(loginContainer)
        self.view.addSubview(Container)
        
        let emailTextField = makeTextField()
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해 주세요!", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "WarmGray") ?? .white])
        let pwTextField = makeTextField()
        pwTextField.attributedPlaceholder = NSAttributedString(string: "최소 6자리로 입력해주세요!", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "WarmGray") ?? .white])
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
        
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            //loginContainer 안에 container 넣을 수 있는지 확인
            self.homeatLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 117),
            self.homeatLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -118),
            self.homeatLogo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 211),
            self.homeatLogo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -615),
            
            self.loginContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 291),
            self.loginContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.loginContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.loginContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
            self.Container.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 552),
            self.Container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 126),
            self.Container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -126),
            self.Container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -281)
            
        ])
    }
}

//
//  RegisterSelectViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//

import Foundation
import UIKit
import Then
class RegisterSelectViewController : UIViewController {
    
    private let registerContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let policyContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .fill
        
    
        return stackView
    }()
    
    private let homeatLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "가입하기를 누르면"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    private let label2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "로 간주합니다."
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        
        return label
    }()
    
    private let label3 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "에"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        return label
    }()
    
    private let label4 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오신 것을 환영합니다!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        return label
    }()
    
    
    private let tagLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1인 가구를 위한 식비 챌린지 커뮤니티"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var policyButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("이용약관 동의")
        attributedTitle.font = .systemFont(ofSize: 13, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "gray2")
        config.baseForegroundColor = UIColor(named: "green")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0 , leading: 0, bottom: 0, trailing: 0)

        
        let buttonAction = UIAction{ _ in
            self.present(TermsOfUseViewController(), animated: true, completion: nil)
        }
        let button = UIButton(configuration: config, primaryAction: buttonAction)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = policyButton
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        
        self.view.backgroundColor = UIColor(named: "gray2")
        self.view.addSubview(registerContainer)
        let registerButton = makeCustomButton(viewController: self ,nextVC: RegisterViewController() )
        registerButton.setTitle("가입하기", for: .normal)
        registerButton.configuration?.background.backgroundColor = UIColor(named: "green")
        
        let existButton = makeCustomButton(viewController: self, nextVC: LoginViewController())
        existButton.setTitle("계정이 이미 있어요", for: .normal)
        existButton.configuration?.baseForegroundColor = UIColor(named: "green")
        existButton.configuration?.background.backgroundColor = UIColor(named: "gray2")
        existButton.configuration?.background.strokeColor = UIColor(named: "green")
        existButton.configuration?.background.strokeWidth = 2
        
        self.policyContainer.addArrangedSubview(label1)
        self.policyContainer.addArrangedSubview(policyButton)
        self.policyContainer.addArrangedSubview(label2)
        
        self.registerContainer.addArrangedSubview(registerButton)
        self.registerContainer.addArrangedSubview(existButton)
        
        self.view.addSubview(tagLabel1)
        self.view.addSubview(policyContainer)
        self.view.addSubview(homeatLogo)
        self.view.addSubview(label3)
        self.view.addSubview(label4)
        registerContainer.setCustomSpacing(330, after: tagLabel1)
        
        
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            tagLabel1.topAnchor.constraint(equalTo: view.topAnchor, constant: 281),
            tagLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            tagLabel1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -500),
           
            homeatLogo.topAnchor.constraint(equalTo: tagLabel1.bottomAnchor, constant: 31),
            homeatLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 102),
            homeatLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -133),
            
            label3.topAnchor.constraint(equalTo: tagLabel1.bottomAnchor, constant: 27),
            label3.leadingAnchor.constraint(equalTo: homeatLogo.trailingAnchor, constant: 5),
            label3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -102),
            
            label4.topAnchor.constraint(equalTo: homeatLogo.bottomAnchor, constant: 12.1),
            label4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            policyContainer.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: 190),
            policyContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            policyContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            registerContainer.topAnchor.constraint(equalTo: policyContainer.bottomAnchor, constant: 17),
            registerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            registerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -76)
            
        ])
    }
    
    
}


func makeCustomButton(viewController : UIViewController, nextVC : UIViewController) -> UIButton {
    var config = UIButton.Configuration.plain()
    var attributedTitle = AttributedString("계속하기")
    attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
    config.attributedTitle = attributedTitle
    config.background.backgroundColor = UIColor(named: "searchfont")
    config.baseForegroundColor = .black
    config.cornerStyle = .small

    let buttonAction = UIAction{ _ in
        viewController.navigationController?.pushViewController(nextVC, animated: true)
    }
    let customButton = UIButton(configuration: config, primaryAction: buttonAction)
    customButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
    
    return customButton
}


//
//  AddAccountViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/21/24.
//

import Foundation
import UIKit

class AddAccountViewController : UIViewController {
    
    private let registerContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "계좌번호를 입력해주세요."
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let label2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "캐시를 받을 때 필요해요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "searchfont")
        label.textAlignment = .left
        return label
    }()
    
    private let label3 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "은행 선택"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let label4 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "계좌번호"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let searchButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "Login1")
        image?.withTintColor(UIColor(named: "searchfont") ?? .white)
        button.setImage(image, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        self.view.addSubview(registerContainer)
        self.registerContainer.addArrangedSubview(label1)
        self.registerContainer.addArrangedSubview(label2)
        self.registerContainer.addArrangedSubview(label3)
        let bankButton = makeCustomButton(viewController: self, nextVC: BankSelectViewController())
        self.registerContainer.addArrangedSubview(bankButton)
        self.registerContainer.addArrangedSubview(label4)
        
        let accountTextField = makeTextField()
        accountTextField.attributedPlaceholder = NSAttributedString(string: "계좌 번호를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        
        registerContainer.addArrangedSubview(accountTextField)
        let continueButton = makeCustomButton(viewController: self, nextVC: BankCertifyViewController())
        self.registerContainer.addArrangedSubview(continueButton)
        registerContainer.setCustomSpacing(51, after: label1)
        registerContainer.setCustomSpacing(41, after: label2)
        registerContainer.setCustomSpacing(44, after: bankButton)
        registerContainer.setCustomSpacing(153, after: accountTextField)
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
        
        ])
    }
    
    
}

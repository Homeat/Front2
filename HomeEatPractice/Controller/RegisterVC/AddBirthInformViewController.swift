//
//  AddInformViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//

import Foundation
import UIKit

class AddBirthInformViewController : UIViewController {
    
    private let registerContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "생년월일을\n입력해주세요."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let label2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "생년월일"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = UIColor(named: "Green")
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "RegisterBackground")
        self.view.addSubview(registerContainer)
        self.registerContainer.addArrangedSubview(label1)
        self.registerContainer.addArrangedSubview(label2)
        let birthTextField = makeTextField()
        birthTextField.attributedPlaceholder = NSAttributedString(string: "YYYY / MM / DD", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "WarmGray") ?? .white])
        self.registerContainer.addArrangedSubview(birthTextField)
        
        let continueButton = makeCustomButton()
        self.registerContainer.addArrangedSubview(continueButton)
        registerContainer.setCustomSpacing(79, after: label1)
        registerContainer.setCustomSpacing(293, after: birthTextField)
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
        ])
    }
    
    
}

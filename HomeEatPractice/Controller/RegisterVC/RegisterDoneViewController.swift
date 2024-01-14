//
//  RegisterDoneViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//

import Foundation
import UIKit

class RegisterDoneViewController : UIViewController {
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "회원가입 완료"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let label2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "꼭 맞는 혜택을 위해\n추가 정보를 입력해주세요!"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = UIColor(named: "Green")
        label.textAlignment = .center
        return label
    }()
    
    private let button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("추가 정보 입력하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "Green")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true


        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "RegisterBackground")
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            self.label1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 326),
            self.label1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -492),
            
            self.label2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label2.topAnchor.constraint(equalTo: self.label1.bottomAnchor, constant: 37),
            self.label2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -396),
            
            self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.button.topAnchor.constraint(equalTo: self.label2.bottomAnchor, constant: 263),
            self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76)
            
        ])
    }
}

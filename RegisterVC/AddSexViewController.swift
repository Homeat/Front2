//
//  AddSexViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/23/24.
//

import Foundation
import UIKit

class AddSexViewController : UIViewController {
    
    private let registerContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 468
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let selectContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 21
        stackView.axis = .horizontal
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "성별을\n선택해주세요."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var maleButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("남")
        attributedTitle.font = .systemFont(ofSize: 24, weight: .bold)
        config.attributedTitle = attributedTitle
        config.cornerStyle = .small
        config.background.backgroundColor = UIColor(named: "gray4")
        config.baseForegroundColor = .white
        config.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
        config.background.strokeWidth = 2
        
        //테두리 변경
//        let buttonAction = UIAction{ _ in
//            if config.background.strokeColor == UIColor(r: 83, g: 85, b: 86) {
//                config.background.strokeColor = UIColor(named: "green")
//                config.baseForegroundColor = UIColor(named: "green")
//            }
//            else
//            {
//                config.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
//                config.baseForegroundColor = .white
//            }
//            
//            self.maleButton.configuration = config
//        }
        let buttonAction = UIAction { _ in
             self.handleGenderSelection(isMale: true)
         }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )

    
        return button
    }()
    
    private lazy var femaleButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("여")
        attributedTitle.font = .systemFont(ofSize: 24, weight: .bold)
        config.attributedTitle = attributedTitle
        config.cornerStyle = .small
        config.background.backgroundColor = UIColor(named: "gray4")
        config.baseForegroundColor = .white
        config.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
        config.background.strokeWidth = 2
        
        //테두리 변경
//        let buttonAction = UIAction{ _ in
//            if config.background.strokeColor == UIColor(r: 83, g: 85, b: 86) {
//                config.background.strokeColor = UIColor(named: "green")
//                config.baseForegroundColor = UIColor(named: "green")
//            }
//            else
//            {
//                config.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
//                config.baseForegroundColor = .white
//            }
//            
//            self.femaleButton.configuration = config
//        }
        let buttonAction = UIAction { _ in
                    self.handleGenderSelection(isMale: false)
                }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )

    
        return button
    }()
    
    lazy var continueButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("계속하기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "searchfont")
        config.baseForegroundColor = .black
        config.cornerStyle = .small

        let buttonAction = UIAction{ _ in
            self.navigationController?.pushViewController(AddLocationInfromViewController(), animated: true)
            
            //나중에 남자/여자 정보 보낼 부분
            if self.maleButton.configuration?.baseForegroundColor == UIColor(named: "green"){
                print("남")
            }else{
                print("여")
            }
            
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        return customButton
    }()
    
    private func handleGenderSelection(isMale: Bool) {
            if isMale {
                maleButton.configuration?.background.strokeColor = UIColor(named: "green")
                maleButton.configuration?.baseForegroundColor = UIColor(named: "green")
                femaleButton.configuration?.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
                femaleButton.configuration?.baseForegroundColor = .white
            } else {
                maleButton.configuration?.background.strokeColor = UIColor(r: 83, g: 85, b: 86)
                maleButton.configuration?.baseForegroundColor = .white
                femaleButton.configuration?.background.strokeColor = UIColor(named: "green")
                femaleButton.configuration?.baseForegroundColor = UIColor(named: "green")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = continueButton
        self.view.backgroundColor = UIColor(named: "gray2")
        self.view.addSubview(registerContainer)
        self.view.addSubview(selectContainer)
        self.registerContainer.addArrangedSubview(label1)
        
//        self.registerContainer.addArrangedSubview(selectContainer)
        self.view.addSubview(selectContainer)
        self.selectContainer.addArrangedSubview(maleButton)
        self.selectContainer.addArrangedSubview(femaleButton)
        self.registerContainer.addArrangedSubview(continueButton)
//        registerContainer.setCustomSpacing(279, after: selectContainer)
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
            self.selectContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 344),
            self.selectContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.selectContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.selectContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -412),
        ])
    }
    
    
}

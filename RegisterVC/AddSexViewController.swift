//
//  AddSexViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/23/24.
//

import Foundation
import UIKit

class AddSexViewController : CustomProgressViewController {
    
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
        
        let buttonAction = UIAction { _ in
            self.maleButton.isSelected.toggle()
            if self.femaleButton.isSelected{
                self.femaleButton.isSelected.toggle()
            }
            
            //continueButton 활성화 비활성화 구문
            if self.maleButton.isSelected || self.femaleButton.isSelected{
                self.continueButton.isEnabled = true
                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "green")
            }
            else{
                self.continueButton.isEnabled = false
                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
            }
            
            
         }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        
        button.configurationUpdateHandler = { button in
            
            switch button.state{
            case .selected:
                button.configuration?.baseForegroundColor = UIColor(named: "green")
                button.configuration?.background.strokeColor = UIColor(named: "green")
                
                
            default:
                button.configuration = config
                
                
            }
            
        }
        
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
        
        let buttonAction = UIAction { _ in
            self.femaleButton.isSelected.toggle()
            if self.maleButton.isSelected{
                self.maleButton.isSelected.toggle()
            }
            
            if self.maleButton.isSelected || self.femaleButton.isSelected{
                self.continueButton.isEnabled = true
                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "green")
            }
            else{
                self.continueButton.isEnabled = false
                self.continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
            }
            
        }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        
        
        button.configurationUpdateHandler = { button in
            
            switch button.state{
            case .selected:
                button.configuration?.baseForegroundColor = UIColor(named: "green")
                button.configuration?.background.strokeColor = UIColor(named: "green")
                
                
            default:
                button.configuration = config

                
            }
            
        }
        
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
            
            //sever에 성별 정보 보낼 부분
            if self.maleButton.isSelected{
                print("남")
            }else if self.femaleButton.isSelected{
                print("여")
            }
            
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        customButton.isEnabled = false
        return customButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = continueButton
        updateProgressBar(progress: 2/6)
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "정보 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
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
        
        femaleButton.heightAnchor.constraint(equalToConstant: 96).isActive = true
        maleButton.heightAnchor.constraint(equalToConstant: 96).isActive = true
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
            self.selectContainer.topAnchor.constraint(equalTo: registerContainer.topAnchor, constant: 166),
            self.selectContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.selectContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            self.selectContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -412),
        ])
    }
    
    
}

//
//  TermsOfUseViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/21/24.
//

import Foundation
import UIKit

class TermsOfUseViewController: UIViewController {
    
    private let mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 29
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    private func makeCheckContainer(title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .leading
        
        let checkButton = makeCheckButton()
        let label = makeLabel(text: title)
        let viewButton = makeViewButton()
        
        stackView.addArrangedSubview(checkButton)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(viewButton)
        
        return stackView
    }
    
    private func makeCheckButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "checkIcon")
        config.background.backgroundColor = UIColor(named: "gray2")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let buttonAction = UIAction { _ in
            self.present(TermsOfUseViewController(), animated: true, completion: nil)
        }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction)
        return button
    }
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .right
        return label
    }
    
    private func makeViewButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("보기")
        attributedTitle.font = .systemFont(ofSize: 15, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "gray2")
        config.baseForegroundColor = UIColor(named: "green")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let buttonAction = UIAction { _ in
            self.present(TermsOfUseViewController(), animated: true, completion: nil)
        }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction)
        return button
    }
    
   lazy var continueButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("동의하고 가입하기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.cornerStyle = .small
        config.background.backgroundColor = UIColor(named: "green")
        config.baseForegroundColor = .black
        
        let buttonAction = UIAction{ _ in
            self.dismiss(animated: true, completion: nil)
            print("check")
        }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        
        
    
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = continueButton
        self.view.backgroundColor = UIColor(named: "gray2")
        self.view.addSubview(mainContainer)
        
        let checkContainer1 = makeCheckContainer(title: "[필수] 이용 약관 동의")
        let checkContainer2 = makeCheckContainer(title: "[필수] 개인정보 수집 및 이용 동의")
        let checkContainer3 = makeCheckContainer(title: "[필수] 위치기반 정보 수집 동의")
        let checkContainer4 = makeCheckContainer(title: "[선택] 마케팅 활용 동의")
        
        mainContainer.addArrangedSubview(checkContainer1)
        mainContainer.addArrangedSubview(checkContainer2)
        mainContainer.addArrangedSubview(checkContainer3)
        mainContainer.addArrangedSubview(checkContainer4)
        mainContainer.addArrangedSubview(continueButton)
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 127),
            mainContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 26),
            mainContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -98),
            mainContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -400),
            
            continueButton.topAnchor.constraint(equalTo: self.mainContainer.bottomAnchor, constant: 267),
            continueButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76)
            
            
        ])
    }
}


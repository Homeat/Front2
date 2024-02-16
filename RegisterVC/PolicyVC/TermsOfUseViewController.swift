//
//  TermsOfUseViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/21/24.
//

import Foundation
import UIKit

class TermsOfUseViewController: UIViewController, buttonChecked, buttonChecked1, buttonChecked2, buttonChecked3{
    
    weak var delegate : viewCheck?
    
    var checkButton1 : UIButton!
    var checkButton2 : UIButton!    
    var checkButton3 : UIButton!
    var checkButton4 : UIButton!
    
    var checkContainer1 : UIStackView!
    var checkContainer2 : UIStackView!
    var checkContainer3 : UIStackView!
    var checkContainer4 : UIStackView!
    
    
    private let allCheckcontainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 11
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let allCheckButton : UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "uncheckedIcon1")
        config.background.backgroundColor = UIColor(named: "gray2")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.addAction(UIAction {_ in button.isSelected.toggle()}, for: .touchUpInside)
        button.configurationUpdateHandler = { button in
            
            var config = button.configuration
            switch button.state{
            case .selected:
                config?.image = UIImage(named: "checkIcon1")
                button.configuration = config
            default:
                config?.image = UIImage(named: "uncheckedIcon1")
                button.configuration = config
                
            }
            
            
        }
        return button
    }()
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.text = "약관 전체 동의"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "이용약관"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let homeatLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "homeatLogo1")
        return imageView
    }()
    
    private let mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 29
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var continueButton : UIButton = {
         var config = UIButton.Configuration.plain()
         var attributedTitle = AttributedString("동의하고 가입하기")
         attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
         config.attributedTitle = attributedTitle
         config.cornerStyle = .small
         config.background.backgroundColor = UIColor(named: "green")
         config.baseForegroundColor = .black
         
         let buttonAction = UIAction{ _ in
             self.dismiss(animated: true, completion: {
                 self.delegate?.viewCheck()
             }
             )
         }
         
         let button = UIButton(configuration: config, primaryAction: buttonAction )
         
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
         return button
     }()
    
    lazy var closeButton : UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "closeIcon")
        config.background.backgroundColor = UIColor(named: "gray2")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let buttonAction = UIAction{ _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private func makeCheckContainer(title: String, nextVC : String) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        let checkButton = makeCheckButton()
        let label = makeLabel(text: title)
        let viewButton = makeViewButton(nextVC: nextVC)
        
        stackView.addArrangedSubview(checkButton)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(viewButton)
        
        return stackView
    }
    
    private func makeCheckButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "uncheckedIcon")
        config.background.backgroundColor = UIColor(named: "gray2")
//        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.addAction(UIAction {_ in button.isSelected.toggle()}, for: .touchUpInside)
        button.configurationUpdateHandler = { button in
            
            var config = button.configuration
            switch button.state{
            case .selected:
                config?.image = UIImage(named: "checkIcon")
                button.configuration = config
            default:
                config?.image = UIImage(named: "uncheckedIcon")
                button.configuration = config
                if self.allCheckButton.isSelected {
                    self.allCheckButton.isSelected.toggle()
                }

            }
            
            
        }
        
        return button
    }
    
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }
    
    private func makeViewButton(nextVC : String) -> UIButton {
        var config = UIButton.Configuration.plain()
        let attributedText = NSAttributedString(string: "보기", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor(named: "green") ?? UIColor.green])
            
        config.attributedTitle = AttributedString(attributedText)
        config.background.backgroundColor = UIColor(named: "gray2")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let a = Policy1ViewController()
        let b = Policy2ViewController()
        let c = Policy3ViewController()
        let d = Policy4ViewController()
        a.delegate = self
        b.delegate = self
        c.delegate = self
        d.delegate = self
        print(nextVC)
        let buttonAction = UIAction { _ in
            if nextVC == "a"{
                self.present(a, animated: true, completion: nil)
            }
            if nextVC == "b"{
                self.present(b, animated: true, completion: nil)
            }
            if nextVC == "c"{
                self.present(c, animated: true, completion: nil)
            }
            if nextVC == "d"{
                self.present(d, animated: true, completion: nil)
            }
        }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction)
        return button
        
    }
    
    
    func buttonChecked() {
        checkButton1.isSelected = true
        updateButtonStates()
        print("buttonChecked")
    }
    func buttonChecked1() {
        checkButton2.isSelected = true
        updateButtonStates()
        print("buttonChecked1")
    }
    func buttonChecked2() {
        checkButton3.isSelected = true
        updateButtonStates()
    }
    func buttonChecked3() {
        checkButton4.isSelected = true
        updateButtonStates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let _ = continueButton
        self.view.backgroundColor = UIColor(named: "gray2")
        self.view.addSubview(mainContainer)
        view.addSubview(mainLabel)
        view.addSubview(closeButton)
        view.addSubview(continueButton)
        
        checkContainer1 = makeCheckContainer(title: "[필수] 이용 약관 동의", nextVC: "a")
        checkContainer2 = makeCheckContainer(title: "[필수] 개인정보 수집 및 이용 동의" , nextVC: "b")
        checkContainer3 = makeCheckContainer(title: "[필수] 위치기반 정보 수집 동의" , nextVC: "c")
        checkContainer4 = makeCheckContainer(title: "[선택] 마케팅 활용 동의" , nextVC: "d")
        
        
        checkButton1 = checkContainer1.subviews.compactMap { $0 as? UIButton }.first
        checkButton2 = checkContainer2.subviews.compactMap { $0 as? UIButton }.first
        checkButton3 = checkContainer3.subviews.compactMap { $0 as? UIButton }.first
        checkButton4 = checkContainer4.subviews.compactMap { $0 as? UIButton }.first
        let checkButtons = [checkButton1, checkButton2, checkButton3, checkButton4].compactMap { $0 }
        let mustChecked = [checkButton1, checkButton2, checkButton3].compactMap { $0 }
        
        //전부 체크돼어있으면 allcheckButton 체크되게 액션 추가
        checkButtons.forEach { button in
            button.addAction(UIAction { _ in
                if button.isSelected{
                    if checkButtons.allSatisfy({$0.isSelected == true}){
                        self.allCheckButton.isSelected = true
                    }
                }else{
                    
                }
            }, for: .touchUpInside)
            
            
        }
        //필수 버튼 체크돼있을때만 동의하고 가입하기 버튼 활성화
        mustChecked.forEach { button in
            button.addAction(UIAction { _ in
                if button.isSelected{
                    if mustChecked.allSatisfy({$0.isSelected == true}){
                        self.continueButton.isEnabled = true
                    }else{
                        self.continueButton.isEnabled = false
                    }
                }else{
                    if mustChecked.allSatisfy({$0.isSelected == true}){
                        self.continueButton.isEnabled = true
                    }else{
                        self.continueButton.isEnabled = false
                    }
                }
            }, for: .touchUpInside)
            
            
        }
        
        allCheckButton.addAction(UIAction { _ in
            if self.allCheckButton.isSelected{
                self.continueButton.isEnabled = true
            }else{
                self.continueButton.isEnabled = false
                
            }
        }, for: .touchUpInside)
        
        //allCheckButton이 눌리면 나머지 버튼 체크되게
        allCheckButton.addAction(UIAction { _ in
            let isSelected = self.allCheckButton.isSelected
            for button in checkButtons {
                button.isSelected = isSelected
            }
        }, for: .touchUpInside)
        
        
        
        mainContainer.addArrangedSubview(allCheckcontainer)
        mainContainer.addArrangedSubview(checkContainer1)
        mainContainer.addArrangedSubview(checkContainer2)
        mainContainer.addArrangedSubview(checkContainer3)
        mainContainer.addArrangedSubview(checkContainer4)
        allCheckcontainer.addArrangedSubview(allCheckButton)
        allCheckcontainer.addArrangedSubview(homeatLogo)
        allCheckcontainer.addArrangedSubview(label1)
        
        NSLayoutConstraint.activate([
            
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 128),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainContainer.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 31),
            mainContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 26),
            mainContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -26),
//            mainContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -500),
            
            continueButton.topAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: 200),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 57)
            

            
            
        ])
    }
    
    func updateButtonStates() {
        // 모든 체크 버튼이 선택되었을 때 allCheckButton을 선택 상태로 변경
        if [checkButton1, checkButton2, checkButton3, checkButton4].allSatisfy({ $0.isSelected }) {
            allCheckButton.isSelected = true
        }
        
        // 필수 버튼이 모두 선택되었을 때 continueButton을 활성화 상태로 변경
        if [checkButton1, checkButton2, checkButton3].allSatisfy({ $0.isSelected }) {
            continueButton.isEnabled = true
        }
    }
    
    }



func checkboxButton(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            
        }else {
            sender.isSelected = true
        }
    }


protocol viewCheck : AnyObject{
    func viewCheck()
}

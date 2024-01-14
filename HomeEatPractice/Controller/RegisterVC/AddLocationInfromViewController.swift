//
//  AddLocationInfromViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//


//돋보기부터
//전체가 버튼인지 질문
import Foundation
import UIKit

class AddLocationInfromViewController : UIViewController {
    
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
        label.text = "거주하고 있는 동네는\n어디인가요?"
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
        label.text = "게시판 사용에 필요해요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = UIColor(named: "WarmGray")
        label.textAlignment = .left
        return label
    }()
    
    private let label3 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주소"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "RegisterBackground")
        label.textColor = UIColor(named: "Green")
        label.textAlignment = .left
        return label
    }()
    
    private let searchButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "magnifyingglass")
        image?.withTintColor(UIColor(named: "WarmGray") ?? .white)
        button.setImage(image, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "RegisterBackground")
        self.view.addSubview(registerContainer)
        self.registerContainer.addArrangedSubview(label1)
        self.registerContainer.addArrangedSubview(label2)
        self.registerContainer.addArrangedSubview(label3)
        let locationTextField = makeTextField()
        locationTextField.attributedPlaceholder = NSAttributedString(string: "도로명, 지번, 건물명 검색", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "WarmGray") ?? .white])
        self.registerContainer.addArrangedSubview(locationTextField)
//        locationTextField.inputAccessoryView = searchButton
        
        let continueButton = makeCustomButton()
        self.registerContainer.addArrangedSubview(continueButton)
        registerContainer.setCustomSpacing(41, after: label2)
        registerContainer.setCustomSpacing(293, after: locationTextField)
//        locationTextField.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
        
        ])
    }
    
    
}

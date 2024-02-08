//
//  SearchLocationViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/23/24.
//

import Foundation
import UIKit
import SnapKit

class SearchLocationViewController : UIViewController, UITextFieldDelegate {
    
    let scrollView : UIScrollView = UIScrollView()
    let contentView : UIView! = UIView()
    
    private let SearchView =  UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "gray4")
        if let borderColor = UIColor(named: "gray2")?.cgColor {
            $0.layer.borderColor = borderColor
        }
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    // 텍스트 필드
    private let searchTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "동명 (읍, 면)으로 검색 (ex.서초동)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? UIColor(named: "searhfont") ?? .white])
        return TextField
        
    }()
    // 검색 이미지
    private let searchImageView = UIImageView().then {
        $0.image = UIImage(named: "Login1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
       
    }
    
    private lazy var currentLocationButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("현재 위치로 찾기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.image = UIImage(named: "gpsIcon")
        config.imagePadding = 9
        config.background.backgroundColor = UIColor(named: "gray2")
        config.baseForegroundColor = UIColor(named: "green")
        config.cornerStyle = .medium
        config.background.strokeColor = UIColor(named: "green")
        config.background.strokeWidth = 2
    

        let buttonAction = UIAction{ _ in
            self.navigationController?.pushViewController(MapViewController(), animated: true)
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    private lazy var registerButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("등록하기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "green")
        config.baseForegroundColor = .black
        config.cornerStyle = .small
        

        let buttonAction = UIAction{ _ in
            self.navigationController?.pushViewController(AddIncomeViewController(), animated: true)
            
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    
    private let mainContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let townContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
             }
    
    //done버튼 클릭해서 키패드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        let _ = registerButton
        searchTextField.delegate = self
        
        //스크롤뷰 관련 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "동네 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.view.addSubview(SearchView)
        self.view.addSubview(currentLocationButton)
        self.view.addSubview(registerButton)
        
        self.SearchView.addSubview(searchTextField)
        self.SearchView.addSubview(searchImageView)
        
        self.contentView.addSubview(townContainer)
        let label1 = makeLabel(text: "근처 동네")
        let label2 = makeLabel(text: "근처 동네")
        let label3 = makeLabel(text: "근처 동네")
        let label4 = makeLabel(text: "근처 동네")
        let label5 = makeLabel(text: "근처 동네")
        let label6 = makeLabel(text: "근처 동네")
        let label7 = makeLabel(text: "근처 동네")
        let label8 = makeLabel(text: "근처 동네")
        let label9 = makeLabel(text: "근처 동네")
        let label10 = makeLabel(text: "근처 동네")
        let label11 = makeLabel(text: "근처 동네")
        
        
        townContainer.addArrangedSubview(label1)
        townContainer.addArrangedSubview(label2)
        townContainer.addArrangedSubview(label3)
        townContainer.addArrangedSubview(label4)
        townContainer.addArrangedSubview(label5)
        townContainer.addArrangedSubview(label6)
        townContainer.addArrangedSubview(label7)
        townContainer.addArrangedSubview(label8)
        townContainer.addArrangedSubview(label9)
        townContainer.addArrangedSubview(label10)
        townContainer.addArrangedSubview(label11)
        
        
        NSLayoutConstraint.activate([
            
            self.SearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.SearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 21),
            self.SearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -21),
//            self.SearchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -677),
            
            searchTextField.leadingAnchor.constraint(equalTo: SearchView.leadingAnchor, constant: 0),
            searchTextField.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: 0),

            searchImageView.trailingAnchor.constraint(equalTo: SearchView.trailingAnchor, constant: -23),
            searchImageView.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 21), // Adjust the width as needed
            searchImageView.heightAnchor.constraint(equalToConstant: 21) // Adjust the height as needed
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.currentLocationButton.bottomAnchor, constant: 33),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -141),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            
            self.currentLocationButton.topAnchor.constraint(equalTo: self.SearchView.bottomAnchor,constant: 27),
            self.currentLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.currentLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.currentLocationButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -601),
            
            registerButton.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 13),
            registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            registerButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -71)
            
            
        ])
    }
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "searchfont")
        return label
    }
}



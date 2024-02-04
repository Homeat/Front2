//
//  AddLocationInfromViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
///


//돋보기부터
//전체가 버튼인지 질문
import Foundation
import UIKit

class AddLocationInfromViewController : CustomProgressViewController, UITextFieldDelegate {
    
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
        TextField.attributedPlaceholder = NSAttributedString(string: "도로명, 지번, 건물명 검색", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? UIColor(named: "searhfont") ?? .white])
        return TextField
        
    }()
    // 검색 이미지
    private let searchImageView = UIImageView().then {
        $0.image = UIImage(named: "Login1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
       
    }
    
    private let registerContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 12
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
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let label2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "게시판 사용에 필요해요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "searchfont")
        label.textAlignment = .left
        return label
    }()
    
    private let label3 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주소"
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
    
    private lazy var currentLocationButton : UIButton = {
        let currentLocationButton = makeCustomButton(viewController: self, nextVC: SearchLocationViewController())
        currentLocationButton.setTitle("현재 위치로 찾기", for: .normal)
        currentLocationButton.configuration?.image = UIImage(named: "gpsIcon")
        currentLocationButton.configuration?.imagePadding = 9
        currentLocationButton.configuration?.baseForegroundColor = UIColor(named: "green")
        currentLocationButton.configuration?.background.backgroundColor = UIColor(named: "gray2")
        currentLocationButton.configuration?.background.strokeColor = UIColor(named: "green")
        currentLocationButton.configuration?.background.strokeWidth = 2
        
        return currentLocationButton
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
        let _ = currentLocationButton
        self.view.backgroundColor = UIColor(named: "gray2")
        updateProgressBar(progress: 3/6)
        searchTextField.delegate = self
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "정보 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
        
        self.SearchView.addSubview(searchTextField)
        self.SearchView.addSubview(searchImageView)
        
        self.view.addSubview(registerContainer)
        self.registerContainer.addArrangedSubview(label1)
        self.registerContainer.addArrangedSubview(label2)
        self.registerContainer.addArrangedSubview(label3)
        self.registerContainer.addArrangedSubview(SearchView)
//        locationTextField.inputAccessoryView = searchButton
        
        
        
        let continueButton = makeCustomButton(viewController: self, nextVC: AddIncomeViewController())
        
        
        self.registerContainer.addArrangedSubview(currentLocationButton)
        self.registerContainer.addArrangedSubview(continueButton)

        registerContainer.setCustomSpacing(41, after: label2)
        registerContainer.setCustomSpacing(5, after: label3)
        registerContainer.setCustomSpacing(225, after: currentLocationButton)
//        locationTextField.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            self.SearchView.heightAnchor.constraint(equalToConstant: 57),
            
            searchTextField.leadingAnchor.constraint(equalTo: SearchView.leadingAnchor, constant: 0),
            searchTextField.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: 0),

            searchImageView.trailingAnchor.constraint(equalTo: SearchView.trailingAnchor, constant: -23),
            searchImageView.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 15), // Adjust the width as needed
            searchImageView.heightAnchor.constraint(equalToConstant: 15) // Adjust the height as needed
        ])
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 91),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
        
        ])
    }
    
    
}

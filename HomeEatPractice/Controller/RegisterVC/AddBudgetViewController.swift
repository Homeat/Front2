//
//  AddBudgetViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/21/24.
//

import Foundation
import UIKit

class AddBudgetViewController : CustomProgressViewController{
    
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
        return TextField
        
    }()
    // 검색 이미지
    private let searchlabel : UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = UIColor(named: "gray4")
        label.textColor = UIColor(named: "searchfont")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        label.text = "한 주 목표 식비는\n얼마인가요?"
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
        label.text = "외식, 배달비 모두 포함이에요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "searchfont")
        label.textAlignment = .left
        return label
    }()
    
    private let label3 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "한 주 목표 식비"
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
    
    lazy var continueButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("계속하기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "searchfont")
        config.baseForegroundColor = .black
        config.cornerStyle = .small

        let buttonAction = UIAction{ _ in
            UserDefaults.standard.setValue(Int(self.searchTextField.text ?? ""), forKey: "regiBudget")
            let birth = UserDefaults.standard.value(forKey: "regiBirth") ?? ""
            let gender = UserDefaults.standard.value(forKey: "regiSex")  ?? ""
            let income = UserDefaults.standard.value(forKey: "regiIncome")  ?? 0
            let goalPrice = UserDefaults.standard.value(forKey: "regiBudget")  ?? 0
            let addressId = UserDefaults.standard.value(forKey: "regiaddressId")  ?? 0
            print(birth)
            print(gender)
            print(income)
            print(goalPrice)
            print(addressId)
            RegisterAPI.addExtraData(gender: gender as! String, birth: birth as! String, income: income as! Int, goalPrice: goalPrice as! Int, adderessId: addressId as! Int){result in
                switch result{
                case .success:
                    print("추가 정보 저장 성공")
                case .failure(_):
                    print("추가 정보 저장 실패")
                }
            }
            
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        return customButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        let _ = continueButton
        updateProgressBar(progress: 5/6)
        searchTextField.delegate = self
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "정보 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //textfield view 등록
        self.SearchView.addSubview(searchTextField)
        self.SearchView.addSubview(searchlabel)
        
        self.view.addSubview(registerContainer)
        self.registerContainer.addArrangedSubview(label1)
        self.registerContainer.addArrangedSubview(label2)
        self.registerContainer.addArrangedSubview(label3)
        self.registerContainer.addArrangedSubview(SearchView)
        
        self.registerContainer.addArrangedSubview(continueButton)
        registerContainer.setCustomSpacing(41, after: label2)
        registerContainer.setCustomSpacing(5, after: label3)
        registerContainer.setCustomSpacing(293, after: SearchView)
        
        NSLayoutConstraint.activate([
            self.SearchView.heightAnchor.constraint(equalToConstant: 57),
            
            searchTextField.leadingAnchor.constraint(equalTo: SearchView.leadingAnchor, constant: 0),
            searchTextField.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchlabel.leadingAnchor, constant: 0),

            searchlabel.trailingAnchor.constraint(equalTo: SearchView.trailingAnchor, constant: -18.2),
            searchlabel.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
        
        ])
    }
    
    //키보드 동작 관련 함수
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
             }
    
    //done버튼 클릭해서 키패드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}


//텍스트필드에 새로운 문자를 입력하거나 삭제할때마다 이 메서드가 호출
extension AddBudgetViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //백스페이스 처리
        if string.isEmpty {
            return true
        }
        
        if string.count > 0 {
            guard string.rangeOfCharacter(from: charSet) == nil else {
                return false
            }
        }
        
        //글자수제한
        if textField.text?.count ?? 0 > 15 {
            return false
        }
        return true
    }
}

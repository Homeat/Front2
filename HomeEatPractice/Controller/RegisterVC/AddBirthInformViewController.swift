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
    
    private let inputContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 11
        stackView.axis = .horizontal
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "생년월일을\n입력해주세요."
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
        label.text = "생년월일"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let yearTextField : UITextField = {
        let yearTextField = makeTextField()
        yearTextField.attributedPlaceholder = NSAttributedString(string: "YYYY", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: yearTextField.frame.size.height))
            yearTextField.rightView = rightPaddingView
            yearTextField.rightViewMode = .always
        return yearTextField
        
    }()
    
    private let monthTextField : UITextField = {
        let monthTextField = makeTextField()
        monthTextField.attributedPlaceholder = NSAttributedString(string: "MM", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return monthTextField
        
    }()
    
    private let dayTextField : UITextField = {
        let dayTextField = makeTextField()
        dayTextField.attributedPlaceholder = NSAttributedString(string: "DD", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? .white])
        return dayTextField
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        self.view.addSubview(registerContainer)
        self.view.addSubview(inputContainer)
        self.registerContainer.addArrangedSubview(label1)
        self.registerContainer.addArrangedSubview(label2)
 
        yearTextField.delegate = self
        monthTextField.delegate = self
        dayTextField.delegate = self
        
        self.inputContainer.addArrangedSubview(yearTextField)
        self.inputContainer.addArrangedSubview(monthTextField)
        self.inputContainer.addArrangedSubview(dayTextField)
        
        self.registerContainer.addArrangedSubview(inputContainer)

        let continueButton = makeCustomButton(viewController: self, nextVC: AddSexViewController())

        self.registerContainer.addArrangedSubview(continueButton)
        
        registerContainer.setCustomSpacing(79, after: label1)
        registerContainer.setCustomSpacing(293, after: inputContainer)
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
        ])
    }
    
    //키보드 관련 func
    
    //화면 터치해서 키패드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
             }
    
    //done버튼 클릭해서 키패드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
}



//숫자 이외에 입력 안 되게 설정
let charSet : CharacterSet = {
    var cs = CharacterSet.decimalDigits
    return cs.inverted
}()


extension AddBirthInformViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count > 0 {
            guard string.rangeOfCharacter(from: charSet) == nil else {
                return false
            }
        
            guard textField.text!.count < 4 else { return false }
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 키보드 업
        textField.becomeFirstResponder()
        // 입력 시 textField 를 강조하기 위한 테두리 설정
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "green")?.cgColor
    }
    
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            //버튼 활성화 기능
//            if yearTextField.hasText && monthTextField.hasText && dayTextField.hasText {
//                NotificationCenter.default.post(name: .AddBirthInformViewController, object: false)
//                    } else {
//                        NotificationCenter.default.post(name: .frontCardtextFieldIsEmpty, object: true)
//                    }
            
            //corner 색 없애기
            textField.layer.borderWidth = 0
        }
    
}

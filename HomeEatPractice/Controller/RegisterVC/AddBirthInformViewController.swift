//
//  AddInformViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
//

import Foundation
import UIKit

class AddBirthInformViewController : CustomProgressViewController{
    var birthInfo : String?
    
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
    
    lazy var continueButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("계속하기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "searchfont")
        config.baseForegroundColor = .black
        config.cornerStyle = .small

        let buttonAction = UIAction{ _ in
            
            if let year = self.yearTextField.text,
               let month = self.monthTextField.text,
               let day = self.dayTextField.text {
                // 각각의 값이 옵셔널이 아닌 경우에만 실행됩니다.
                self.birthInfo = "\(year)-\(month)-\(day)"
                UserDefaults.standard.setValue(self.birthInfo, forKey: "regiBirth")
                print(self.birthInfo)
            } else {
                // 텍스트 필드의 값 중에 하나라도 옵셔널인 경우
                print("텍스트 필드의 값 중에 옵셔널이 포함되어 있습니다.")
            }
            
            
            self.navigationController?.pushViewController(AddSexViewController(), animated: true)
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        
        return customButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = continueButton
        self.view.backgroundColor = UIColor(named: "gray2")
        updateProgressBar(progress: 1/6)
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "정보 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
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

        
        continueButton.isEnabled = false
        self.registerContainer.addArrangedSubview(continueButton)
        
        registerContainer.setCustomSpacing(79, after: label1)
        registerContainer.setCustomSpacing(293, after: inputContainer)
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
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
    
    func checkEnableButton() {
            // 각 텍스트 필드의 글자수가 각각 4, 2, 2인 경우에만 버튼을 활성화
            if yearTextField.text?.count == 4, monthTextField.text?.count == 2, dayTextField.text?.count == 2 {
                continueButton.isEnabled = true
                continueButton.configuration?.background.backgroundColor = UIColor(named: "green")
            } else {
                continueButton.isEnabled = false
                continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
            }
        }
    
    
}



//숫자 이외에 입력 안 되게 설정
let charSet : CharacterSet = {
    var cs = CharacterSet.decimalDigits
    return cs.inverted
}()


//입력숫자제한 + 숫자 이외 입력 제한
extension AddBirthInformViewController: UITextFieldDelegate {
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
        if textField == yearTextField {
            guard textField.text!.count < 4 else { return false }
        }
        
        // monthTextField에 대한 처리
        if textField == monthTextField {
            guard textField.text!.count < 2 else { return false }
        }
        
        // dayTextField에 대한 처리
        if textField == dayTextField {
            guard textField.text!.count < 2 else { return false }
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
        //corner 색 없애기
        textField.layer.borderWidth = 0
        checkEnableButton()
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkEnableButton()
    }
    
}

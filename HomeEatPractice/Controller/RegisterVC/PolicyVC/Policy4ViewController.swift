//
//  Policy4ViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/10/24.
//

import Foundation
import UIKit

class Policy4ViewController : UIViewController {

    weak var delegate : buttonChecked3?
    
    
    let scrollView : UIScrollView = UIScrollView()
    let contentView : UIView! = UIView()
    
    private let mainLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text =
"""
홈잇은 개인정보 보호법 제 22조 제4항과 제39조의 3에 따라 사용자의 광고성 정보 수신과 이에 따른 개인정보 처리에 대한 동의를 받고 있습니다. 약관에 동의하지 않으셔도 홈잇의 모든 서비스를 이용하실 수 있습니다. 다만, 이벤트, 혜택 등의 제한이 있을 수 있습니다.

1) 개인정보 수집 항목
- 이메일, 생년월일, 성별, 거주지

2) 개인정보 수집 이용 목적
- 이벤트 운영 및 광고성 정보 전송
- 서비스 관련 정보 전송

3) 보유 및 이용 기간
- 동의 철회 시 또는 회원 탈퇴 시까지

4) 동의 철회 방법
- 개인정보관리 페이지에서 변경 혹은 이메일으로 문의

5) 전송 방법
- 이메일

6) 전송 내용
- 혜택 정보, 이벤트 정보, 상품 정보, 신규 서비스 안내 등의 광고성 정보 제공

"""
        
        let attributedString = NSMutableAttributedString(string: text)
        
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.attributedText = attributedString
        label.backgroundColor = UIColor(named: "gray2")
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "마케팅 활용 동의"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    lazy var continueButton : UIButton = {
         var config = UIButton.Configuration.plain()
         var attributedTitle = AttributedString("동의하고 가입하기")
         attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
         config.attributedTitle = attributedTitle
         config.cornerStyle = .small
         config.background.backgroundColor = UIColor(named: "green")
         config.baseForegroundColor = .black
         
         let buttonAction = UIAction{ _ in
             self.delegate?.buttonChecked3()
             self.dismiss(animated: true, completion: nil)
         }
         
         let button = UIButton(configuration: config, primaryAction: buttonAction )
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let _ = continueButton
        self.view.backgroundColor = UIColor(named: "gray2")
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        contentView.addSubview(mainLabel1)
        view.addSubview(continueButton)
        contentView.addSubview(mainLabel)
        contentView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            mainLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: mainLabel.topAnchor),
//            closeButton.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 64),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            mainLabel1.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 38),
            mainLabel1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainLabel1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainLabel1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
            
            continueButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 650),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 57),
            
        ])
    }
    

    
    
}


protocol buttonChecked3 : AnyObject{
    func buttonChecked3()
}

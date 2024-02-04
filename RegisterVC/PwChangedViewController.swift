//
//  PwChangedViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/2/24.
//

import Foundation
import UIKit

class PwChangedViewController : UIViewController {
    
    private let doneImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doneIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호 변경이 완료되었습니다."
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        
        let continueButton = makeCustomButton(viewController: self, nextVC: LoginViewController())
        continueButton.configuration?.background.backgroundColor = UIColor(named: "searchfont")
        continueButton.configuration?.title = "돌아가기"
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(doneImage)
        view.addSubview(mainLabel)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            
            doneImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            doneImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneImage.widthAnchor.constraint(equalToConstant: 129),
            doneImage.heightAnchor.constraint(equalToConstant: 129),
            
            mainLabel.topAnchor.constraint(equalTo: self.doneImage.bottomAnchor, constant: 45),
            mainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            
            continueButton.topAnchor.constraint(equalTo: self.doneImage.bottomAnchor, constant: 352),
            continueButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76)
            
            
        ])
    }
    
    
}

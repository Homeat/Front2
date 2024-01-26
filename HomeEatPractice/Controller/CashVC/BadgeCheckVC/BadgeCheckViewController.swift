//
//  BadgeCheckViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/19.
//

import UIKit
class BadgeCheckViewController: UIViewController {
    
    private lazy var cashIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Cash1")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "홈잇뱃지 4개"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    func setConstraints() {
        self.view.addSubview(self.cashIcon)
        self.view.addSubview(self.badgeLabel)
        self.view.addSubview(self.badgeView)
        
        NSLayoutConstraint.activate([
            
            self.cashIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            self.cashIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            self.cashIcon.heightAnchor.constraint(equalToConstant: 15),
            self.cashIcon.widthAnchor.constraint(equalToConstant: 15),
            
            self.badgeLabel.leadingAnchor.constraint(equalTo: cashIcon.trailingAnchor, constant: 6),
            self.badgeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            self.badgeLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.badgeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.badgeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.badgeView.topAnchor.constraint(equalTo: badgeLabel.bottomAnchor, constant: 21),
            self.badgeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

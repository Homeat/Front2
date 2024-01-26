//
//  BadgeCheckViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/19.
//

import UIKit
import Then
class WeekCashViewController: UIViewController {
    
    private lazy var cashIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Cash1")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let cashLabel = UIButton().then {
        $0.setTitle("홈잇캐시 2100원", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(navigateToCashCheckViewController), for: .touchUpInside)
        
    }
    
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
        self.view.addSubview(self.cashLabel)
        self.view.addSubview(self.badgeView)
        
        NSLayoutConstraint.activate([
            
            self.cashIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            self.cashIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            self.cashIcon.heightAnchor.constraint(equalToConstant: 15),
            self.cashIcon.widthAnchor.constraint(equalToConstant: 15),
            
            self.cashLabel.leadingAnchor.constraint(equalTo: cashIcon.trailingAnchor, constant: 6),
            self.cashLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            self.cashLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.badgeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.badgeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.badgeView.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: 21),
            self.badgeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    @objc func navigateToCashCheckViewController(_ sender: Any) {
        let cashCheckVC = CashCheckViewController()

        self.navigationController?.pushViewController(cashCheckVC, animated: true)
        print("cashcheck click")
    }
}

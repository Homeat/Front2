//
//  CashCheckViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/20.
//

import UIKit
import Then

class CashCheckViewController: UIViewController {
    //네비게이션 바 구분 선
    private let borderView = UIView().then {
        $0.backgroundColor = UIColor(named: "gray1")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //홈잇캐시 이미지
    private let cashimageView = UIImageView().then {
        $0.image = UIImage(named: "Cash15")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
    }
    //홈잇캐시 label
    private let cashLabel = UILabel().then {
        $0.text = "홈잇캐시"
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //금액 나오는 화면
    private let cashView = UIView().then {
        $0.backgroundColor = UIColor(named: "gray4")
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //현재 금액
    private let cashAmountLabel = UILabel().then {
        $0.text = "2,300 원"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //계좌로 보내기
    private let sendBankLabel = UIButton().then {
        $0.setTitle("계좌로 보내기", for: .normal)
        $0.setTitleColor(UIColor.init(named: "green"), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationControl()
        addSubviews()
        configUI()
        view.backgroundColor = UIColor(named: "gray2")
    }
    
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "홈잇캐시 내역"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    func addSubviews() {
        view.addSubview(borderView)
        view.addSubview(cashimageView)
        view.addSubview(cashLabel)
        view.addSubview(cashView)
        cashView.addSubview(cashAmountLabel)
        view.addSubview(sendBankLabel)
    }
    func configUI() {
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 24),
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            cashimageView.topAnchor.constraint(equalTo: borderView.topAnchor ,constant: 34),
            cashimageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 21),
            cashimageView.widthAnchor.constraint(equalToConstant: 31.6),
            cashimageView.heightAnchor.constraint(equalToConstant: 33),
        ])
        NSLayoutConstraint.activate([
            cashLabel.topAnchor.constraint(equalTo: borderView.topAnchor ,constant: 28),
            cashLabel.leadingAnchor.constraint(equalTo: cashimageView.trailingAnchor,constant: 9.4),
            cashLabel.widthAnchor.constraint(equalToConstant: 111),
            cashLabel.heightAnchor.constraint(equalToConstant: 36),
        ])
        NSLayoutConstraint.activate([
            cashView.topAnchor.constraint(equalTo: cashimageView.topAnchor ,constant: 55.5),
            cashView.leadingAnchor.constraint(equalTo: cashimageView.leadingAnchor),
            cashView.widthAnchor.constraint(equalToConstant: 351),
            cashView.heightAnchor.constraint(equalToConstant: 93),
        ])
        NSLayoutConstraint.activate([
            cashAmountLabel.centerXAnchor.constraint(equalTo: cashView.centerXAnchor),
            cashAmountLabel.centerYAnchor.constraint(equalTo: cashView.centerYAnchor),
            
        ])
        NSLayoutConstraint.activate([
            sendBankLabel.topAnchor.constraint(equalTo: cashView.bottomAnchor ,constant: 16),
            sendBankLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -18),
            sendBankLabel.widthAnchor.constraint(equalToConstant: 104),
            sendBankLabel.heightAnchor.constraint(equalToConstant: 26),
            
        ])
    }
    //뒤로가기
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    //저장
    @objc func save(_ sender: UIBarButtonItem) {
        
    }

}

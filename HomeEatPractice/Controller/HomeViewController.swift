//
//  Home.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/02.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    // 지출추가 버튼
    private let payAddButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.setTitle("지출 추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let spacing: CGFloat = 8.0 // 원하는 간격 값으로 조절
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        

        return button
    }()
    
    // 지출확인 버튼
    private let payCheckButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .black
        button.setTitle("지출 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let spacing: CGFloat = 8.0 // 원하는 간격 값으로 조절
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)

        
        return button
    }()
    
    // 지출분석 버튼
    private let payAnalyzeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setImage(UIImage(systemName: "chart.bar.fill"), for: .normal)
        button.tintColor = .black
        button.setTitle("지출 분석", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let spacing: CGFloat = 8.0 // 원하는 간격 값으로 조절
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        return button
    }()
    
    // 버튼을 포함하는 스택뷰
    private let buttonContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 15
        container.alignment = .center
        container.distribution = .fillEqually
        return container
    }()
    
    // 진행상황 이미지뷰
    private let progressView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
//        label.text = "(OO)님 훌륭해요!\n 저번달보다 8% 절약하고 있어요"
        let attributedString = NSMutableAttributedString(string: "(OO)님 훌륭해요!\n 저번달보다 8% 절약하고 있어요")
        let stringLength = attributedString.length
        attributedString.addAttributes([.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 25, weight: .bold)], range: NSRange(location: 0, length: 11))
        attributedString.addAttributes([.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 20, weight: .bold)], range: NSRange(location: 12, length: 6))
        attributedString.addAttributes([.foregroundColor : UIColor.systemGreen, .font : UIFont.systemFont(ofSize: 20, weight: .bold)], range: NSRange(location: 18, length: 3))
        attributedString.addAttributes([.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 20, weight: .bold)], range: NSRange(location: 21, length: 9))
        label.attributedText = attributedString
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        self.payAddButton.addTarget(self, action: #selector(tabAddButton), for: .touchUpInside)
        self.payCheckButton.addTarget(self, action: #selector(tabCheckButton), for: .touchUpInside)
        self.payAnalyzeButton.addTarget(self, action: #selector(tabAnalyzeButton), for: .touchUpInside)
    }
    //HomeView가 나타날 때 tabBar 다시 띄우기 및 저장버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
        
        self.navigationItem.setRightBarButton(nil, animated: false)
    }
    
    func setView() {
        self.view.addSubview(self.buttonContainer)
        self.buttonContainer.addArrangedSubview(self.payAddButton)
        self.buttonContainer.addArrangedSubview(self.payCheckButton)
        self.buttonContainer.addArrangedSubview(self.payAnalyzeButton)
        self.view.addSubview(self.progressView)
        self.view.addSubview(self.infoLabel)
        
        self.buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        self.payAddButton.translatesAutoresizingMaskIntoConstraints = false
        self.payCheckButton.translatesAutoresizingMaskIntoConstraints = false
        self.payAnalyzeButton.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            self.buttonContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.buttonContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.buttonContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.buttonContainer.heightAnchor.constraint(equalToConstant: 180),
            
            self.payAddButton.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.payAddButton.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            
            self.payCheckButton.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.payCheckButton.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            
            self.payAnalyzeButton.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.payAnalyzeButton.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            
            self.progressView.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            self.progressView.bottomAnchor.constraint(equalTo: self.buttonContainer.topAnchor, constant: -20),
            self.progressView.heightAnchor.constraint(equalTo: self.buttonContainer.heightAnchor, constant: 200),
            
            self.infoLabel.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            self.infoLabel.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor),
            self.infoLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -15)
            
        ])
    }
    
    // 지출추가 버튼을 클릭했을 때
    @objc func tabAddButton(_ sender: Any) {
        let nextVC = PayAddViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
            backBarButtonItem.tintColor = .white
            self.navigationItem.backBarButtonItem = backBarButtonItem

    }
    // 지출추가 뷰에서 back 버튼을 눌렀을 때
    @objc func backAddButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    // 지출확인 버튼을 클릭했을 때
    @objc func tabCheckButton(_ sender: Any) {
        let nextVC = PayCheckViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
            backBarButtonItem.tintColor = .white
            self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    // 지출확인 뷰에서 back 버튼을 눌렀을 때
    @objc func backCheckButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButton(_ sender: Any) {
        //구현예정
    }
    
    // 지출분석 버튼을 클릭했을 때
    @objc func tabAnalyzeButton(_ sender: Any) {
        let nextVC = PayAnalyzeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
            backBarButtonItem.tintColor = .white
            self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // 지출분석 뷰에서 back 버튼을 눌렀을 때
    @objc func backAnalyzeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

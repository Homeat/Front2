//
//  LeaveViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/01.
// 탈퇴하기 화면

import UIKit
import Then

class LeaveViewController: UIViewController {
    private let WhyLabel = UILabel().then {
        $0.text = "탈퇴하는 이유가 무엇인가요?"
        $0.textColor = UIColor.white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let optionButton1: UIButton = {
        let button = UIButton()
        button.setTitle("쓰지 않는 앱이에요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton2: UIButton = {
        let button = UIButton()
        button.setTitle("오류가 생겨서 쓸 수 없어요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton3: UIButton = {
        let button = UIButton()
        button.setTitle("보완이 걱정돼요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton4: UIButton = {
        let button = UIButton()
        button.setTitle("개인정보가 불안해요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let optionButton5: UIButton = {
        let button = UIButton()
        button.setTitle("앱 사용법을 모르겠어요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor(r: 187, g: 187, b: 187).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        view.backgroundColor = UIColor(named: "gray2")
        navigationControl()
        addSubviws()
        configUI()
    }
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨깁니다.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 넘어갈 때 커스텀 탭바를 다시 보이게 합니다.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = false
        }
    }
    func addSubviws() {
        view.addSubview(WhyLabel)
        view.addSubview(container)
        container.addArrangedSubview(optionButton1)
        container.addArrangedSubview(optionButton2)
        container.addArrangedSubview(optionButton3)
        container.addArrangedSubview(optionButton4)
        container.addArrangedSubview(optionButton5)

    }
    func configUI() {
        NSLayoutConstraint.activate([
            WhyLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 139),
            WhyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 52),
            WhyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -52),
            WhyLabel.heightAnchor.constraint(equalToConstant: 28),
            
            self.container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21),
            self.container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
            self.container.topAnchor.constraint(equalTo: self.WhyLabel.bottomAnchor, constant: 50),
            self.container.heightAnchor.constraint(equalToConstant: 355),
            
            self.optionButton1.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton1.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton2.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton2.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton3.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton3.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton4.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton4.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            self.optionButton5.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.optionButton5.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.optionButton5.bottomAnchor.constraint(equalTo: self.container.bottomAnchor),
        ])
        
    }
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        let rightBarButton = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(jump(_:)))
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.title = "탈퇴하기"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    //뒤로가기
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    //건너뛰기
    @objc func jump(_ sender: UIBarButtonItem) {
        
    }
}

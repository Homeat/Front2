//
//  EditViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/17.
//

import UIKit

class EditViewController: UIViewController {
    //프로필이미지 넣을 원형뷰
    private let circleView = UIView().then {
        $0.layer.cornerRadius = 55
        $0.layer.borderWidth = 3.9 // 흰 테두리 두께 조절
        $0.layer.borderColor = UIColor.white.cgColor // 흰 테두리 색상 설정
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "green")
    }
    //프로필 이미지
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "Mypage1") // 실제 프로필 이미지의 이름으로 변경
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let profileEditBtn = UIImageView().then {
        $0.image = UIImage(named: "Mypage5")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gray2")
        self.title = "회원정보"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        addSubView()
        configUI()
        navigationControl()
        
    }
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        let rightBarButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(save(_:)))
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.title = "회원정보"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    func addSubView() {
        view.addSubview(circleView)
        circleView.addSubview(profileImageView)
        view.addSubview(profileEditBtn)
    }
    func configUI() {
        NSLayoutConstraint.activate([
           circleView.widthAnchor.constraint(equalToConstant: 113), // 원형 뷰의 크기 설정
           circleView.heightAnchor.constraint(equalToConstant: 113), // 원형 뷰의 크기 설정
           circleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
           circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
           
           profileImageView.widthAnchor.constraint(equalToConstant: 88.8), // 원형 뷰의 크기 설정
           profileImageView.heightAnchor.constraint(equalToConstant: 69), // 원형 뷰의 크기 설정
           profileImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
           profileImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
           
           profileEditBtn.widthAnchor.constraint(equalToConstant: 38),
           profileEditBtn.heightAnchor.constraint(equalToConstant: 38),
           profileEditBtn.topAnchor.constraint(equalTo:circleView.topAnchor, constant:72),
           profileEditBtn.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant:217)
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

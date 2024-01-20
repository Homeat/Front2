//
//  MyPageViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/02.
//

import Foundation
import UIKit
import Then
import SnapKit

class MyPageViewController: UIViewController {
    //네비게이션 바 구분 선
    lazy var borderView: UIView = {
        let borderView = UIView()
        borderView.backgroundColor = UIColor(named: "gray1")
        borderView.translatesAutoresizingMaskIntoConstraints = false
        return borderView
    } ()
    //프로필이미지 넣을 원형뷰
    lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 43
        view.layer.borderWidth = 3.0 // 흰 테두리 두께 조절
        view.layer.borderColor = UIColor.white.cgColor // 흰 테두리 색상 설정
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "green")
        return view
    }()
    //프로필 이미지
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Mypage4") // 실제 프로필 이미지의 이름으로 변경
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //프로필 이름
    lazy var profileName : UILabel = {
        let label = UILabel()
        label.text = "예진 님"
        label.textColor = .white
        
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    } ()
    //프로필 아이디 뷰
    lazy var profileIdView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    //프로필 아이디 label
    lazy var profileIdLabel : UILabel = {
        let label = UILabel()
        label.text = "@yejin_woo"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    //회원 정보 수정 버튼
    private let profileEditBtn = UIButton().then {
        $0.setTitle("회원 정보 수정", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.init(named: "gray3")
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(navigateToEditViewController), for: .touchUpInside)
    }
    //홈잇캐시
    private let settingCash =  UIButton().then {
        $0.setTitle("홈잇캐시", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .left // 이미지 오른쪽 정렬
    }
    //화살표 버튼
    private let arrowBtn = UIImageView().then {
        $0.image = UIImage(named: "Mypage3")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //캐릭터 설정
    private let settingCharacter =  UIButton().then {
        $0.setTitle("캐릭터 설정", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .left // 이미지 오른쪽 정렬
    }
    //화살표 버튼
    private let arrowBtn2 = UIImageView().then {
        $0.image = UIImage(named: "Mypage3")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar2 = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //비밀번호 변경
    private let settingPassword =  UIButton().then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .left // 이미지 오른쪽 정렬
    }
    //화살표 버튼
    private let arrowBtn3 = UIImageView().then {
        $0.image = UIImage(named: "Mypage3")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar3 = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let settingLogout =  UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .left // 이미지 오른쪽 정렬
    }
    //화살표 버튼
    private let arrowBtn4 = UIImageView().then {
        $0.image = UIImage(named: "Mypage3")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar4 = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let settingLeave =  UIButton().then {
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .left // 이미지 오른쪽 정렬
    }
    //화살표 버튼
    private let arrowBtn5 = UIImageView().then {
        $0.image = UIImage(named: "Mypage3")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "마이페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        addSubView()
        configUI()
    }
    
    //HomeView가 나타날 때 tabBar 다시 띄우기 및 저장버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
        
        self.navigationItem.setRightBarButton(nil, animated: false)
    }

    
    func addSubView() {
        view.addSubview(borderView)
        view.addSubview(circleView)
        circleView.addSubview(profileImageView)
        view.addSubview(profileName)
        view.addSubview(profileIdView)
        profileIdView.addSubview(profileIdLabel)
        view.addSubview(profileEditBtn)
        view.addSubview(settingCash)
        view.addSubview(arrowBtn)
        view.addSubview(UnderlineBar)
        view.addSubview(settingCharacter)
        view.addSubview(arrowBtn2)
        view.addSubview(UnderlineBar2)
        view.addSubview(settingPassword)
        view.addSubview(arrowBtn3)
        view.addSubview(UnderlineBar3)
        view.addSubview(settingLogout)
        view.addSubview(arrowBtn4)
        view.addSubview(UnderlineBar4)
        view.addSubview(settingLeave)
        view.addSubview(arrowBtn5)
        
    }
    func configUI() {
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
           circleView.widthAnchor.constraint(equalToConstant: 86), // 원형 뷰의 크기 설정
           circleView.heightAnchor.constraint(equalToConstant: 86), // 원형 뷰의 크기 설정
           circleView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 32),
           circleView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor,constant: 22),
           
           profileImageView.topAnchor.constraint(equalTo: circleView.topAnchor,constant: 16.5),
           profileImageView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor,constant: 9),
           
           profileName.topAnchor.constraint(equalTo: circleView.topAnchor,constant: 8),
           profileName.leadingAnchor.constraint(equalTo: circleView.trailingAnchor,constant: 18)
           
        ])
        NSLayoutConstraint.activate([
            profileIdView.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 14),
            profileIdView.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 15),
            profileIdView.widthAnchor.constraint(equalToConstant: 102),
            profileIdView.heightAnchor.constraint(equalToConstant: 29),
            
            profileIdLabel.centerXAnchor.constraint(equalTo: profileIdView.centerXAnchor),
            profileIdLabel.centerYAnchor.constraint(equalTo: profileIdView.centerYAnchor),
            
            profileEditBtn.widthAnchor.constraint(equalToConstant: 353),
            profileEditBtn.heightAnchor.constraint(equalToConstant: 51),
            profileEditBtn.topAnchor.constraint(equalTo: circleView.bottomAnchor,constant: 15),
            profileEditBtn.leadingAnchor.constraint(equalTo: circleView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            settingCash.widthAnchor.constraint(equalToConstant: 59),
            settingCash.heightAnchor.constraint(equalToConstant: 17),
            settingCash.topAnchor.constraint(equalTo: profileEditBtn.bottomAnchor, constant: 37),
            settingCash.leadingAnchor.constraint(equalTo: circleView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            arrowBtn.widthAnchor.constraint(equalToConstant: 11.3),
            arrowBtn.heightAnchor.constraint(equalToConstant: 11.3),
            arrowBtn.topAnchor.constraint(equalTo: profileEditBtn.bottomAnchor, constant: 41.3),
            arrowBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27)
        ])

        NSLayoutConstraint.activate([
            UnderlineBar.widthAnchor.constraint(equalToConstant: 354),
            UnderlineBar.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar.topAnchor.constraint(equalTo: settingCash.bottomAnchor, constant: 22),
            UnderlineBar.leadingAnchor.constraint(equalTo: settingCash.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            settingCharacter.widthAnchor.constraint(equalToConstant: 78),
            settingCharacter.heightAnchor.constraint(equalToConstant: 17),
            settingCharacter.topAnchor.constraint(equalTo: UnderlineBar.bottomAnchor, constant: 23),
            settingCharacter.leadingAnchor.constraint(equalTo: settingCash.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            arrowBtn2.widthAnchor.constraint(equalToConstant: 11.3),
            arrowBtn2.heightAnchor.constraint(equalToConstant: 11.3),
            arrowBtn2.topAnchor.constraint(equalTo: UnderlineBar.bottomAnchor, constant: 25.3),
            arrowBtn2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27)
        ])

        NSLayoutConstraint.activate([
            UnderlineBar2.widthAnchor.constraint(equalToConstant: 354),
            UnderlineBar2.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar2.topAnchor.constraint(equalTo: settingCharacter.bottomAnchor, constant: 22),
            UnderlineBar2.leadingAnchor.constraint(equalTo: settingCharacter.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            settingPassword.widthAnchor.constraint(equalToConstant: 92),
            settingPassword.heightAnchor.constraint(equalToConstant: 17),
            settingPassword.topAnchor.constraint(equalTo: UnderlineBar2.bottomAnchor, constant: 23),
            settingPassword.leadingAnchor.constraint(equalTo: settingCash.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            arrowBtn3.widthAnchor.constraint(equalToConstant: 11.3),
            arrowBtn3.heightAnchor.constraint(equalToConstant: 11.3),
            arrowBtn3.topAnchor.constraint(equalTo: UnderlineBar2.bottomAnchor, constant: 25.3),
            arrowBtn3.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27)
        ])

        NSLayoutConstraint.activate([
            UnderlineBar3.widthAnchor.constraint(equalToConstant: 354),
            UnderlineBar3.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar3.topAnchor.constraint(equalTo: settingPassword.bottomAnchor, constant: 22),
            UnderlineBar3.leadingAnchor.constraint(equalTo: settingPassword.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            settingLogout.widthAnchor.constraint(equalToConstant: 59),
            settingLogout.heightAnchor.constraint(equalToConstant: 17),
            settingLogout.topAnchor.constraint(equalTo: UnderlineBar3.bottomAnchor, constant: 23),
            settingLogout.leadingAnchor.constraint(equalTo: settingCash.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            arrowBtn4.widthAnchor.constraint(equalToConstant: 11.3),
            arrowBtn4.heightAnchor.constraint(equalToConstant: 11.3),
            arrowBtn4.topAnchor.constraint(equalTo: UnderlineBar3.bottomAnchor, constant: 25.3),
            arrowBtn4.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27)
        ])

        NSLayoutConstraint.activate([
            UnderlineBar4.widthAnchor.constraint(equalToConstant: 354),
            UnderlineBar4.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar4.topAnchor.constraint(equalTo: settingLogout.bottomAnchor, constant: 22),
            UnderlineBar4.leadingAnchor.constraint(equalTo: settingLogout.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            settingLeave.widthAnchor.constraint(equalToConstant: 59),
            settingLeave.heightAnchor.constraint(equalToConstant: 17),
            settingLeave.topAnchor.constraint(equalTo: UnderlineBar4.bottomAnchor, constant: 23),
            settingLeave.leadingAnchor.constraint(equalTo: settingCash.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            arrowBtn5.widthAnchor.constraint(equalToConstant: 11.3),
            arrowBtn5.heightAnchor.constraint(equalToConstant: 11.3),
            arrowBtn5.topAnchor.constraint(equalTo: UnderlineBar4.bottomAnchor, constant: 25.3),
            arrowBtn5.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27)
        ])
        }
    //회원 정보 수정 으로 넘어감 
    @objc func navigateToEditViewController(_ sender: Any) {
        let editVC = EditViewController()
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(editVC, animated: true)
        print("present click")
    }
    @objc func backAddButton(_ sender:Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

   
}

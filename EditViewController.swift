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
    //닉네임
    private let ProfileNickname = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let NicknameLabel = UILabel().then {
        $0.text = "아리"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //아이디
    private let ProfileID = UILabel().then {
        $0.text = "아이디"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let IDLabel = UILabel().then {
        $0.text = "yejin_woo"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar2 = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //이메일 주소
    private let ProfileEmailAdress = UILabel().then {
        $0.text = "이메일 주소"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let EmailAdressLabel = UILabel().then {
        $0.text = "yejin09071@gmail.com"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    // 이메일 화살표 버튼
    private lazy var arrowBtn: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Mypage3")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true // 이미지뷰에 사용자 상호 작용을 가능하게 함
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 탭 제스처 생성
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToEmailEditViewController))
        imageView.addGestureRecognizer(tapGesture)

        return imageView
    }()
    // 한 달 수입 화살표 버튼
    private lazy var arrowBtn2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Mypage3")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true // 이미지뷰에 사용자 상호 작용을 가능하게 함
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 탭 제스처 생성
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToMonthMoneyEditViewController))
        imageView.addGestureRecognizer(tapGesture)

        return imageView
    }()
    //한달 수입
    private let MonthMoney = UILabel().then {
        $0.text = "한 달 수입"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let MonthMoneyLabel = UILabel().then {
        $0.text = "2,500,000원"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar3 = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let UnderlineBar4 = UIView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userData불러와서 설정
        if let name = UserDefaults.standard.string(forKey: "userNickname"), let email = UserDefaults.standard.string(forKey: "userEmail") {
            NicknameLabel.text = name
            EmailAdressLabel.text = email
        } else {
            // UserDefaults에서 값이 없는 경우에 대한 처리
            NicknameLabel.text = "설정되지 않았습니다."
            EmailAdressLabel.text = "설정되지 않았습니다."
            
        }
        view.backgroundColor = UIColor(named: "gray2")
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        self.title = "회원정보"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        addSubView()
        configUI()
        navigationControl()
        
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
    // MARK: - 네비게이션
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        let rightBarButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(save(_:)))
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(named: "green")], for: .normal)
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
        view.addSubview(ProfileNickname)
        view.addSubview(NicknameLabel)
        view.addSubview(UnderlineBar)
        view.addSubview(ProfileID)
        view.addSubview(IDLabel)
        view.addSubview(UnderlineBar2)
        view.addSubview(ProfileEmailAdress)
        view.addSubview(EmailAdressLabel)
        view.addSubview(arrowBtn)
        view.addSubview(UnderlineBar3)
        view.addSubview(MonthMoney)
        view.addSubview(MonthMoneyLabel)
        view.addSubview(arrowBtn2)
        view.addSubview(UnderlineBar4)
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
           
           profileEditBtn.heightAnchor.constraint(equalToConstant: 38),
           profileEditBtn.topAnchor.constraint(equalTo:circleView.topAnchor, constant:72),
           profileEditBtn.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant:217),
           profileEditBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -138)
           ])
        NSLayoutConstraint.activate([
            ProfileNickname.widthAnchor.constraint(equalToConstant: 45),
            ProfileNickname.heightAnchor.constraint(equalToConstant: 17),
            ProfileNickname.topAnchor.constraint(equalTo: view.topAnchor, constant: 290),
            ProfileNickname.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25)
        ])
        NSLayoutConstraint.activate([
            NicknameLabel.heightAnchor.constraint(equalToConstant: 17),
            NicknameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 290),
            NicknameLabel.leadingAnchor.constraint(equalTo: ProfileNickname.trailingAnchor,constant: 80)
        ])
        NSLayoutConstraint.activate([
            UnderlineBar.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar.topAnchor.constraint(equalTo: ProfileNickname.bottomAnchor, constant: 19),
            UnderlineBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            UnderlineBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -19),
        ])
        NSLayoutConstraint.activate([
            ProfileID.widthAnchor.constraint(equalToConstant: 45),
            ProfileID.heightAnchor.constraint(equalToConstant: 17),
            ProfileID.topAnchor.constraint(equalTo: UnderlineBar.bottomAnchor, constant: 23),
            ProfileID.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25)
        ])
        NSLayoutConstraint.activate([
            IDLabel.heightAnchor.constraint(equalToConstant: 17),
            IDLabel.topAnchor.constraint(equalTo: UnderlineBar.bottomAnchor, constant: 19),
            IDLabel.leadingAnchor.constraint(equalTo: ProfileID.trailingAnchor,constant: 80)
        ])
        NSLayoutConstraint.activate([
            UnderlineBar2.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar2.topAnchor.constraint(equalTo: ProfileID.bottomAnchor, constant: 19),
            UnderlineBar2.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            UnderlineBar2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -19),
        ])
        NSLayoutConstraint.activate([
            ProfileEmailAdress.widthAnchor.constraint(equalToConstant: 78),
            ProfileEmailAdress.heightAnchor.constraint(equalToConstant: 17),
            ProfileEmailAdress.topAnchor.constraint(equalTo: UnderlineBar2.bottomAnchor, constant: 23),
            ProfileEmailAdress.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25)
        ])
        NSLayoutConstraint.activate([
            EmailAdressLabel.heightAnchor.constraint(equalToConstant: 17),
            EmailAdressLabel.topAnchor.constraint(equalTo: UnderlineBar2.bottomAnchor, constant: 19),
            EmailAdressLabel.leadingAnchor.constraint(equalTo: IDLabel.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            arrowBtn.widthAnchor.constraint(equalToConstant: 11.3),
            arrowBtn.heightAnchor.constraint(equalToConstant: 11.3),
            arrowBtn.topAnchor.constraint(equalTo: UnderlineBar2.bottomAnchor, constant: 25.3),
            arrowBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27)
        ])
        NSLayoutConstraint.activate([
            UnderlineBar3.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar3.topAnchor.constraint(equalTo: ProfileEmailAdress.bottomAnchor, constant: 19),
            UnderlineBar3.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            UnderlineBar3.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -19),
        ])
        NSLayoutConstraint.activate([
            MonthMoney.widthAnchor.constraint(equalToConstant: 67),
            MonthMoney.heightAnchor.constraint(equalToConstant: 17),
            MonthMoney.topAnchor.constraint(equalTo: UnderlineBar3.bottomAnchor, constant: 23),
            MonthMoney.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25)
        ])
        NSLayoutConstraint.activate([
            MonthMoneyLabel.heightAnchor.constraint(equalToConstant: 17),
            MonthMoneyLabel.topAnchor.constraint(equalTo: UnderlineBar3.bottomAnchor, constant: 19),
            MonthMoneyLabel.leadingAnchor.constraint(equalTo: IDLabel.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            arrowBtn2.widthAnchor.constraint(equalToConstant: 11.3),
            arrowBtn2.heightAnchor.constraint(equalToConstant: 11.3),
            arrowBtn2.topAnchor.constraint(equalTo: UnderlineBar3.bottomAnchor, constant: 25.3),
            arrowBtn2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -27)
        ])

        NSLayoutConstraint.activate([
            UnderlineBar4.heightAnchor.constraint(equalToConstant: 1),
            UnderlineBar4.topAnchor.constraint(equalTo: MonthMoney.bottomAnchor, constant: 19),
            UnderlineBar4.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            UnderlineBar4.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -19),
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
    @objc func navigateToEmailEditViewController(_ sender: Any) {
        let emaileditVC = EmailEditViewController()

        self.navigationController?.pushViewController(emaileditVC, animated: true)
        print("EMAILEDIT click")
    }
    @objc func navigateToMonthMoneyEditViewController(_ sender: Any) {
        let monthmoneyVC = MonthMoneyEditViewController()

        self.navigationController?.pushViewController(monthmoneyVC, animated: true)
        print("MONTHEDIT click")
    }

}

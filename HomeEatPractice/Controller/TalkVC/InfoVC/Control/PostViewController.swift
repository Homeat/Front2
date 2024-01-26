//
//  PostViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/12.
//

import UIKit
//게시글 화면
class PostViewController: UIViewController {
    
    // MARK: - 프로퍼티 생성
    //프로필이미지 넣을 원형뷰
    lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 1.3 // 흰 테두리 두께 조절
        view.layer.borderColor = UIColor.white.cgColor // 흰 테두리 색상 설정
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "green")
        return view
    }()
    // 프로필 사진
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "character") // 실제 프로필 이미지의 이름으로 변경
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //프로필 이름
    lazy var profileName : UILabel = {
        let label = UILabel()
        label.text = "우예진"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    } ()
    // 게시 날짜
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.text = "11월 20일 24:08"
        label.textColor = UIColor(named: "font4")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    // 신고하기
    lazy var complainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.text = "신고하기"
        label.textColor = UIColor(named: "font4")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    // 제목
    lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "홈잇마트 할인"
        label.textColor = UIColor(named: "green")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    // 내용
    lazy var postContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "성북구 월곡동 홈잇마트 복숭아 할인 행사 하네요!\n관심있는 분들 구매하시면 좋을 것 같아요"
        label.numberOfLines = 2
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

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
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        navigationcontrol()
        configUI()
        view.backgroundColor = UIColor(named: "gray3")
        
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    // MARK: - ViewSet
    func addSubView() {
        view.addSubview(circleView)
        circleView.addSubview(profileImageView)
        view.addSubview(profileName)
        view.addSubview(dateLabel)
        view.addSubview(complainLabel)
        view.addSubview(postTitleLabel)
        view.addSubview(postContentLabel)
    }
    
    func configUI() {
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            // 서클 뷰의 크기와 위치 설정
            circleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            circleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            circleView.widthAnchor.constraint(equalToConstant: 37.8),
            circleView.heightAnchor.constraint(equalToConstant: 37.8),


            // 이미지뷰가 서클 뷰의 가운데에 위치하도록 설정
            profileImageView.topAnchor.constraint(equalTo: circleView.topAnchor,constant: 6.8),
            profileImageView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor,constant: 6),
            
            profileName.topAnchor.constraint(equalTo: circleView.topAnchor),
            profileName.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 13),
            
            dateLabel.topAnchor.constraint(equalTo: profileName.bottomAnchor,constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            
            complainLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            complainLabel.leadingAnchor.constraint(equalTo:dateLabel.trailingAnchor,constant: 195),
            
            postTitleLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor,constant: 15.2),
            postTitleLabel.leadingAnchor.constraint(equalTo: circleView.leadingAnchor),
            
            postContentLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor,constant: 8),
            postContentLabel.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor)
            
        ])
    }
    //네비게이션 바 설정
    func navigationcontrol() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "정보토크"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    
    // MARK: - @objc 메서드
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    }

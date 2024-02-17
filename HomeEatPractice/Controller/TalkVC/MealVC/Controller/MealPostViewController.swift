//
//  MealPostViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/22.
//

import UIKit

class MealPostViewController: UIViewController, UIScrollViewDelegate {
    // 게시물의 ID
    // 이미지 캐시
    var imageCache = NSCache<NSString, UIImage>()
    var postId: Int = 0
    var selectedTags : [String] = []
    var post: MealSource? // 선택된 게시물 데이터
    // 서버에서 받아온 이미지를 저장할 배열
    var images: [UIImage] = []
    var imageViews = [UIImageView]()
    let talk12Image: UIImage? = UIImage(named: "Talk12")
    
    // MARK: - 일반 프로퍼티 생성
    lazy var profileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 1.3 // 흰 테두리 두께 조절
        view.layer.borderColor = UIColor.white.cgColor // 흰 테두리 색상 설정
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "green")
        return view
    }()
    
    lazy var profileIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "character") // 실제 프로필 이미지의 이름으로 변경
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nickName: UILabel = {
        let label = UILabel()
        label.text = "우예진"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.text = "11월 20일 24:08"
        label.textColor = UIColor(named: "font4")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var declareButton: UIButton = {
        let button = UIButton()
        button.setTitle("신고하기", for: .normal)
        button.setTitleColor(UIColor(r: 165, g: 165, b: 165), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(delcareAction), for: .touchUpInside)
        return button
    }()
    
    // 제목 위 카테고리
    lazy var hashtagCategoty: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 1.18
        button.layer.borderColor = UIColor(named: "green")?.cgColor
        button.setTitle("#아침", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 6)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "연어 샐러드"
        label.textColor = UIColor(named: "green")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "메모 내용이 들 어갈 자리입니다.\n메모 내용이 들어갈 자리입니다."
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - 페이지 사진 생성
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        scrollView.delegate = self
        addViews()
        setConstraints()
        navigationControl()
        addContentScrollView()
        setPageControl()
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
    // MARK: - ViewSet
    private func addViews() {
        self.view.addSubview(self.profileView)
        self.profileView.addSubview(self.profileIcon)
        self.view.addSubview(self.nickName)
        self.view.addSubview(self.date)
        self.view.addSubview(self.declareButton)
        self.view.addSubview(self.hashtagCategoty)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.contentLabel)
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.profileView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            self.profileView.widthAnchor.constraint(equalToConstant: 37.8),
            self.profileView.heightAnchor.constraint(equalToConstant: 37.8),


            // 이미지뷰가 서클 뷰의 가운데에 위치하도록 설정
            self.profileIcon.topAnchor.constraint(equalTo: self.profileView.topAnchor,constant: 6.8),
            self.profileIcon.leadingAnchor.constraint(equalTo: self.profileView.leadingAnchor,constant: 6),
            
            self.nickName.topAnchor.constraint(equalTo: self.profileView.topAnchor),
            self.nickName.leadingAnchor.constraint(equalTo: self.profileView.trailingAnchor, constant: 11.2),
            self.nickName.heightAnchor.constraint(equalToConstant: 22),
            
            self.date.leadingAnchor.constraint(equalTo: self.nickName.leadingAnchor),
            self.date.topAnchor.constraint(equalTo: self.nickName.bottomAnchor, constant: 3),
            
            self.declareButton.topAnchor.constraint(equalTo: self.nickName.bottomAnchor, constant: 3),
            self.declareButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.declareButton.heightAnchor.constraint(equalToConstant: 14),
            
            self.hashtagCategoty.leadingAnchor.constraint(equalTo: self.profileView.leadingAnchor),
            self.hashtagCategoty.topAnchor.constraint(equalTo: self.profileView.bottomAnchor, constant: 20.2),
            self.hashtagCategoty.heightAnchor.constraint(equalToConstant: 20),
            self.hashtagCategoty.widthAnchor.constraint(equalToConstant: 40),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.hashtagCategoty.bottomAnchor, constant: 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.profileView.leadingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 34),
            
            self.contentLabel.leadingAnchor.constraint(equalTo: self.profileView.leadingAnchor),
            self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            
            scrollView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: declareButton.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 257),
            scrollView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 19),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
//MARK: - PageControl 스크롤뷰 메서드
    private func addContentScrollView() {
            
            for i in 0..<images.count {
                let imageView = UIImageView()
                let xPos = scrollView.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                imageView.image = images[i]
                scrollView.addSubview(imageView)
            }
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count), height: scrollView.frame.height)
        }
    private func setPageControl() {
            pageControl.numberOfPages = images.count
            
        }
    
    private func setPageControlSelectedPage(currentPage:Int) {
            pageControl.currentPage = currentPage
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
                pageControl.currentPage = pageIndex
        }
    
//MARK: - 네비게이션바
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(backButton(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "집밥토크"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    
    // MARK: - @objc 메서드
    @objc func delcareAction() {
        let declareVC = DeclareViewController()
        navigationController?.pushViewController(declareVC, animated: true)
    }
    
    
    @objc func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
}

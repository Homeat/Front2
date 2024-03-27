//
//  PostViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/12.
//

import UIKit
import Then
import Alamofire
import SnapKit
//게시글 화면
class PostViewController: UIViewController, UIScrollViewDelegate,UICollectionViewDelegateFlowLayout {
    // 게시물의 ID
    // 이미지 캐시
    var imageCache = NSCache<NSString, UIImage>()
    var postId: Int = 0
    var selectedTags : [String] = []
    var post: MyItem? // 선택된 게시물 데이터
    // 서버에서 받아온 이미지를 저장할 배열
    var images: [UIImage] = []
    var imageViews = [UIImageView]()
    let talk12Image: UIImage? = UIImage(named: "Talk12")
    //스크롤 뷰
    private let mainScrollview = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //태그 컬렉션 뷰
    private lazy var TagcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        //셀 만들어야 함
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCell")
        
        return collectionView
    }()
    //MARK:- 댓글 테이블 뷰
    private let commenttableView =  UITableView().then {
        $0.allowsSelection = true //셀 클릭이 가능하게 하는거
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = UIColor.init(named: "gray3")
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        $0.isScrollEnabled = false
        $0.bounces = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
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
    //MARK: -- 프로필 이름
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
    lazy var complainLabel: UIButton = {
        let button = UIButton()
        button.setTitle("신고하기", for: .normal)
        button.setTitleColor(UIColor(r: 165, g: 165, b: 165), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(delcareAction), for: .touchUpInside)
        return button
    }()
    
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
    //댓글 뷰
    lazy var inputUIView: UIView = {
        let inputview = UIView()
        inputview.backgroundColor = UIColor.init(named: "gray4")
        inputview.layer.cornerRadius = 5
        inputview.clipsToBounds = true
        inputview.translatesAutoresizingMaskIntoConstraints = false
        return inputview
    } ()
    //조그만 하트
    private let SmallheartButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk6"),for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //하트 개수
    lazy var heartCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.text = "0"
        label.textColor = UIColor(named: "green")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    //조그만 채팅
    private let SmallChatButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk10"),for:.normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //채팅 개수
    lazy var chatCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.text = "0"
        label.textColor = UIColor(named: "green")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    // 댓글 개수
    
    //하트 버튼
    private let heartButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk14"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    private let sendButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk15"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //MARK: - 업로드한 사진이 올라가는 스크롤뷰
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
    private let barView = UIView().then {
        $0.backgroundColor = UIColor.init(named: "gray4")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //댓글 입력 textfield
    private let inputTextField = UITextField().then {
        $0.placeholder = "댓글을 남겨보세요."
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor(named: "font5")
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(named: "gray4")
        $0.attributedPlaceholder = NSAttributedString(string: "댓글을 남겨보세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "font5") ?? UIColor.gray])
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.layer.borderColor = UIColor.init(named: "font7")?.cgColor // 테두리 색상 설정
        $0.layer.borderWidth = 1.0 // 테두리 두께 설정
    }
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetchImagesForPost()
        //updateUI() // 뷰가 화면에 나타날 때마다 UI를 업데이트합니다.
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
        images = [] // 이미지 배열 초기화
        navigationcontrol()
        view.backgroundColor = UIColor(named: "gray3")
        scrollView.delegate = self
        commenttableView.delegate = self
        commenttableView.dataSource = self
        // 화면의 다른 곳을 누려면 키보드가 내려가는 메서드.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
       // view에 탭 제스처를 추가.
        self.view.addGestureRecognizer(tapGesture)
        addContentScrollView()
        setPageControl()
        fetchDataFromServer()
        fetchImagesForPost()
        addSubView()
        configUI()
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        
        // 키보드 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // NotificationCenter에 관찰자를 등록하는 행위.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
            
    }
    // 관찰자 분리.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func viewDidTap(gesture: UITapGestureRecognizer) {
        // 뷰를 탭하면 에디팅을 멈추게함.
        // 에디팅이 멈추므로 키보드가 내려감.
        view.endEditing(true)
    }
    // MARK: - ViewSet
    func addSubView() {
        view.addSubview(mainScrollview)
        mainScrollview.addSubview(contentView)
        contentView.addSubview(circleView)
        circleView.addSubview(profileImageView)
        contentView.addSubview(profileName)
        contentView.addSubview(dateLabel)
        contentView.addSubview(complainLabel)
        contentView.addSubview(TagcollectionView)
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(postContentLabel)
        contentView.addSubview(scrollView)
        contentView.addSubview(pageControl)
        
        contentView.addSubview(SmallheartButton)
        contentView.addSubview(heartCountLabel)
        contentView.addSubview(SmallChatButton)
        contentView.addSubview(chatCountLabel)
        contentView.addSubview(barView)
        contentView.addSubview(commenttableView)
        view.addSubview(inputUIView)
        inputUIView.addSubview(heartButton)
        inputUIView.addSubview(inputTextField)
        inputUIView.addSubview(sendButton)
        
        
    }
    
    func configUI() {
        NSLayoutConstraint.activate([
            self.mainScrollview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mainScrollview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mainScrollview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mainScrollview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: mainScrollview.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: mainScrollview.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainScrollview.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: mainScrollview.frameLayoutGuide.widthAnchor),
        ])

        // inputUIView의 레이아웃 설정
        NSLayoutConstraint.activate([
            inputUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // inputUIView의 bottom을 view의 bottom과 같도록 설정하여 고정시킵니다.
            inputUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // inputUIView의 leading을 contentView의 leading과 같도록 설정
            inputUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // inputUIView의 trailing을 contentView의 trailing과 같도록 설정
            inputUIView.heightAnchor.constraint(equalToConstant: 91) // inputUIView의 높이를 91로 고정합니다.
        ])
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            // 서클 뷰의 크기와 위치 설정
            circleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            circleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
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
            complainLabel.widthAnchor.constraint(equalToConstant: 37),
            complainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            postTitleLabel.topAnchor.constraint(equalTo: TagcollectionView.bottomAnchor,constant: 13),
            postTitleLabel.leadingAnchor.constraint(equalTo: circleView.leadingAnchor),
            
            postContentLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor,constant: 8),
            postContentLabel.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: complainLabel.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 245),
            scrollView.topAnchor.constraint(equalTo: postContentLabel.bottomAnchor, constant: 19),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            SmallheartButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 22),
            SmallheartButton.widthAnchor.constraint(equalToConstant: 11.9),
            SmallheartButton.heightAnchor.constraint(equalToConstant: 11),
            SmallheartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            
            heartCountLabel.leadingAnchor.constraint(equalTo: SmallheartButton.trailingAnchor, constant: 2.1),
            heartCountLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: 20),
            heartCountLabel.heightAnchor.constraint(equalToConstant: 14),
            
            SmallChatButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 22),
            SmallChatButton.leadingAnchor.constraint(equalTo: heartCountLabel.trailingAnchor, constant: 12),
            SmallChatButton.widthAnchor.constraint(equalToConstant: 12),
            SmallChatButton.heightAnchor.constraint(equalToConstant: 10.7),
            
            chatCountLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            chatCountLabel.leadingAnchor.constraint(equalTo: SmallChatButton.trailingAnchor, constant: 2.1),
            chatCountLabel.heightAnchor.constraint(equalToConstant: 14),
            
            barView.topAnchor.constraint(equalTo: SmallheartButton.bottomAnchor, constant: 18),
            barView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            barView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            barView.heightAnchor.constraint(equalToConstant: 4),
            
            commenttableView.topAnchor.constraint(equalTo: barView.bottomAnchor),
            commenttableView.heightAnchor.constraint(equalToConstant: commenttableView.contentSize.height),
            commenttableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commenttableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commenttableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            heartButton.topAnchor.constraint(equalTo: inputUIView.topAnchor,constant: 13),
            heartButton.leadingAnchor.constraint(equalTo: inputUIView.leadingAnchor,constant: 21),
            heartButton.bottomAnchor.constraint(equalTo: inputUIView.bottomAnchor,constant: -34),
            heartButton.heightAnchor.constraint(equalToConstant: 26.1),
            heartButton.widthAnchor.constraint(equalToConstant: 25.2),
            
            inputTextField.topAnchor.constraint(equalTo: inputUIView.topAnchor,constant: 13),
            inputTextField.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor,constant: 9),
            inputTextField.trailingAnchor.constraint(equalTo: inputUIView.trailingAnchor,constant: -60),
            inputTextField.bottomAnchor.constraint(equalTo: inputUIView.bottomAnchor,constant: -34),
            
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            sendButton.topAnchor.constraint(equalTo: inputUIView.topAnchor,constant: 18),
            sendButton.leadingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: 5),
            sendButton.trailingAnchor.constraint(equalTo: inputUIView.trailingAnchor, constant: -9),
                
            
        ])
        NSLayoutConstraint.activate([
            TagcollectionView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 20),
            TagcollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            TagcollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            TagcollectionView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    //collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = selectedTags[indexPath.item]
        let tagWidth = tag.width(withConstrainedHeight: 40, font: UIFont.systemFont(ofSize: 15), margin: 50)
        return CGSize(width: tagWidth, height: 40)
    }
    //MARK: - PageControl 스크롤뷰 메서드
    private func addContentScrollView() {
        scrollView.isPagingEnabled = true // 페이지별 스크롤 가능하도록 설정
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
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
        setPageControlSelectedPage(currentPage: pageIndex)
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
    //MARK: = 서버 데이터 받아오기
    func fetchDataFromServer() {
        
        let url = "https://dev.homeat.site/v1/infoTalk/\(postId)"
        print("Fetching data from URL: \(url)") // postid 확인을 위해 URL을 출력합니다.
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            loginToken = token
        } else {
            print("토큰이 없습니다.")
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: MyItem.self) { response in
                switch response.result {
                case .success(let data):
                    self.post = data
                    // 데이터를 받아온 후에 UI를 업데이트합니다.
                    self.updateUI()
                    
                    print("Successfully fetched data from server:")
                    print("ID: \(data.id)")
                    print("Title: \(data.title)")
                    print("CreatedAt: \(data.createdAt)")
                    print("UpdatedAt: \(data.updatedAt)")
                    print("Content: \(data.content)")
                    print("Love: \(data.love)")
                    print("View: \(data.view)")
                    print("CommentNumber: \(data.commentNumber)")
                    print("SetLove: \(data.setLove)")
                    print("Save: \(data.save)")
                    print("InfoPictures: \(data.infoPictures)")
                    print("InfoHashTags: \(data.infoHashTags ?? [])")
                    print("InfoTalkComments: \(data.infoTalkComments ?? [])")
                    print("Member: \(data.member)")
                    
                case .failure(let error):
                    print("Error fetching data from server: \(error)")
                }
            }
    }
    
    // 업데이트된 메서드로 날짜를 포맷하고 UI를 업데이트합니다.
    func formatDateString(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "M월 d일 HH:mm"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    func updateUI() {
        // 게시글의 제목, 내용, 날짜를 업데이트합니다.
        if let title = post?.title {
            postTitleLabel.text = title
        }
        if let content = post?.content {
            postContentLabel.text = content
        }
        if let member = post?.member {
               profileName.text = member.nickname // 닉네임 업데이트
           }
        if let loveCount = post?.love {
                heartCountLabel.text = "\(loveCount)" // 하트 개수 업데이트
            }
        if let dateString = post?.createdAt {
            // ISO8601DateFormatter를 사용하여 문자열 형태의 날짜를 날짜 객체로 변환합니다.
            if let isoDate = ISO8601DateFormatter().date(from: dateString) {
                // DateFormatter를 사용하여 날짜 형식을 변경합니다.
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let formattedDateString = dateFormatter.string(from: isoDate)
                
                dateLabel.text = formattedDateString
            } else {
                print("Error parsing ISO8601 date")
            }
        }
    }
        // MARK: - API 호출하여 이미지 가져오기
    func fetchImagesForPost() {
        // 게시물의 ID를 이용하여 서버에 이미지를 요청하는 API를 호출합니다.
        let urlString = "https://dev.homeat.site/v1/infoTalk/\(postId)"
        guard let url = URL(string: urlString) else { return }
        
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            loginToken = token
        } else {
            print("토큰이 없습니다.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        
        AF.request(url, headers: headers).responseData { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let data):
                // JSON 데이터 파싱하여 이미지 URL을 가져옵니다.
                do {
                    let postData = try JSONDecoder().decode(MyItem.self, from: data)
                    let imageUrls = postData.infoPictures.map { $0.url }
                   
                    print("Image URLs: \(imageUrls)") // 이미지 URL 출력
                    // 이미지 URL을 이용하여 이미지 데이터를 비동기적으로 가져옵니다.
                    self.fetchImages(from: imageUrls)
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("Error fetching images: \(error.localizedDescription)")
            }
        }
    }
    // 이미지를 가져오는 메서드
       func fetchImages(from urls: [String]) {
           for imageUrl in urls {
               guard let url = URL(string: imageUrl) else { continue }
               
               // 이미지가 캐시에 있는지 확인합니다.
               if let cachedImage = imageCache.object(forKey: imageUrl as NSString) {
                   // 캐시에 이미지가 있으면 이미지를 바로 사용합니다.
                   self.images.append(cachedImage)
                   // UI를 업데이트합니다.
                   DispatchQueue.main.async {
                       self.updateUIWithImages()
                   }
               } else {
                   // 캐시에 이미지가 없으면 네트워크 요청을 보냅니다.
                   URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                       guard let self = self else { return }
                       if let error = error {
                           print("Error fetching image: \(error.localizedDescription)")
                           return
                       }
                       
                       guard let data = data, let image = UIImage(data: data) else {
                           print("No image data received")
                           return
                       }
                       
                       // 이미지를 캐시에 저장합니다.
                       self.imageCache.setObject(image, forKey: imageUrl as NSString)
                       
                       // 이미지를 배열에 추가합니다.
                       self.images.append(image)
                       
                       // UI를 업데이트합니다.
                       DispatchQueue.main.async {
                           self.updateUIWithImages()
                       }
                   }.resume()
               }
           }
       }
        
    // 이미지를 화면에 표시하는 메서드
        func updateUIWithImages() {
            // 이미지를 받아올 때마다 UIScrollView를 초기화합니다.
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            
            // 서버에서 받아온 이미지를 UIScrollView에 추가하여 화면에 표시합니다.
            for (index, image) in images.enumerated() {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFill
                let xPos = CGFloat(index) * scrollView.bounds.width
                imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                scrollView.addSubview(imageView)
            }
            scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(images.count), height: scrollView.bounds.height)
            
            // 페이지 컨트롤을 업데이트합니다.
            pageControl.numberOfPages = images.count
        }
        
        // MARK: - @objc 메서드
        @objc func back(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
            print("back click")
            
        }
        // MARK: - @objc 메서드
        @objc func delcareAction() {
            let declareVC = DeclareViewController()
            navigationController?.pushViewController(declareVC, animated: true)
        }
    @objc internal override func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        //키보드의 높이
        let keyboardHeight = keyboardFrame.size.height
        let finalHeight = keyboardHeight - self.view.safeAreaInsets.bottom

        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval

        // Calculate the new frame for inputUIView
        let newYPosition = self.view.frame.height - finalHeight - self.inputUIView.frame.height

        // Animate the frame change
        UIView.animate(withDuration: animationDuration) {
            self.inputUIView.frame.origin.y = newYPosition
        }
    }
    
    @objc private func keyboardWillHideNotification(_ notification: NSNotification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        // Calculate the original y position for inputUIView
        let originalYPosition = self.view.frame.height - self.inputUIView.frame.height - self.view.safeAreaInsets.bottom
        
        // Animate the frame change to original position
        UIView.animate(withDuration: animationDuration) {
            self.inputUIView.frame.origin.y = originalYPosition
        }
    }
    @objc func heartButtonTapped() {
        // 버튼을 눌렀을 때의 동작 구현
        heartButton.setImage(UIImage(named: "Talk16"), for: .normal) // talk16 이미지로 변경
        
        // Love 값을 증가시킴
        updateUI()
    }
    }
extension PostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //셀 개수 카운팅 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        let tag = selectedTags[indexPath.item]
        cell.configure(with: tag, image: talk12Image)
        return cell
    }
}
extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 3 // 서버에서 받아온 데이터의 개수만큼 셀을 표시합니다.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }


}
extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("cell click")
            //셀을 선택된 후에 셀의 선택상태를 즉시해제 !
            tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
    


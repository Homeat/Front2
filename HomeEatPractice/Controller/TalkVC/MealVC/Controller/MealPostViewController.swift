//
//  MealPostViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/22.
//

import UIKit
import Alamofire

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
    
    private let mainScrollview = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //프로필 이미지를 넣을 원형뷰
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
    
    //프로필 사진
    lazy var profileIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "character") // 실제 프로필 이미지의 이름으로 변경
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //프로필 이름
    lazy var nickName: UILabel = {
        let label = UILabel()
        label.text = "우예진"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //게시 날짜
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
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 10)
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
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 4)
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.text = "연어 샐러드"
        label.textColor = UIColor(named: "green")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 15)
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
    
    private let barView = UIView().then {
        $0.backgroundColor = UIColor.init(named: "gray4")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
//MARK: - 공감, 채팅 개수 확인
    //조그만 하트
    private let SmallheartButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk6"),for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //하트 개수
    lazy var heartCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 10)
        label.text = "0"
        label.textColor = UIColor(named: "green")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //조그만 채팅
    private let SmallChatButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk10"),for:.normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //채팅 개수
    lazy var chatCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 10)
        label.text = "0"
        label.textColor = UIColor(named: "green")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//MARK: - 댓글작성창
    //댓글 뷰
    lazy var inputUIView: UIView = {
        let inputview = UIView()
        inputview.backgroundColor = UIColor.init(named: "gray4")
        inputview.layer.cornerRadius = 5
        inputview.clipsToBounds = true
        inputview.translatesAutoresizingMaskIntoConstraints = false
        return inputview
    } ()
    
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

    //하트 버튼
    private let heartButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk14"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //댓글을 남기는 버튼
    private let sendButton = UIButton().then {
        $0.setImage(UIImage(named: "Talk15"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        images = [] // 이미지 배열 초기화
        scrollView.delegate = self
        addSubView()
        configUI()
        navigationControl()
        addContentScrollView()
        setPageControl()
        fetchDataFromServer()
        fetchImagesForPost()
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
    private func addSubView() {
        self.view.addSubview(mainScrollview)
        mainScrollview.addSubview(contentView)
        contentView.addSubview(profileView)
        profileView.addSubview(profileIcon)
        contentView.addSubview(nickName)
        contentView.addSubview(date)
        contentView.addSubview(declareButton)
        contentView.addSubview(hashtagCategoty)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(scrollView)
        contentView.addSubview(pageControl)
        
        contentView.addSubview(SmallheartButton)
        contentView.addSubview(heartCountLabel)
        contentView.addSubview(SmallChatButton)
        contentView.addSubview(chatCountLabel)
        
        contentView.addSubview(barView)
        view.addSubview(inputUIView)
        
        inputUIView.addSubview(heartButton)
        inputUIView.addSubview(inputTextField)
        inputUIView.addSubview(sendButton)
    }
    
    private func configUI() {
        
        NSLayoutConstraint.activate([
            mainScrollview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainScrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -91), // scrollView의 bottom을 inputUIView의 top에 맞춥니다.
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: mainScrollview.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: mainScrollview.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainScrollview.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: inputUIView.topAnchor, constant: -20), // inputUIView의 top에서 20만큼 위로 설정
            contentView.widthAnchor.constraint(equalTo: mainScrollview.frameLayoutGuide.widthAnchor) // contentView의 너비를 scrollView의 frameLayoutGuide의 너비와 같도록 설정
        ])

        // inputUIView의 레이아웃 설정
        NSLayoutConstraint.activate([
            inputUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // inputUIView의 bottom을 view의 bottom과 같도록 설정하여 고정시킵니다.
            inputUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // inputUIView의 leading을 contentView의 leading과 같도록 설정
            inputUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), // inputUIView의 trailing을 contentView의 trailing과 같도록 설정
            inputUIView.heightAnchor.constraint(equalToConstant: 91) // inputUIView의 높이를 91로 고정합니다.
        ])
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            profileView.widthAnchor.constraint(equalToConstant: 37.8),
            profileView.heightAnchor.constraint(equalToConstant: 37.8),


            // 이미지뷰가 서클 뷰의 가운데에 위치하도록 설정
            profileIcon.topAnchor.constraint(equalTo: profileView.topAnchor,constant: 6.8),
            profileIcon.leadingAnchor.constraint(equalTo: profileView.leadingAnchor,constant: 6),
            
            nickName.topAnchor.constraint(equalTo: profileView.topAnchor),
            nickName.leadingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: 13),
            
            date.topAnchor.constraint(equalTo: nickName.bottomAnchor,constant: 3),
            date.leadingAnchor.constraint(equalTo: nickName.leadingAnchor),
            
            declareButton.topAnchor.constraint(equalTo: date.topAnchor),
            declareButton.widthAnchor.constraint(equalToConstant: 37),
            declareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            hashtagCategoty.topAnchor.constraint(equalTo: profileIcon.bottomAnchor,constant: 20),
            hashtagCategoty.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            hashtagCategoty.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            hashtagCategoty.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: hashtagCategoty.bottomAnchor,constant: 13),
            titleLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: declareButton.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 245),
            scrollView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 19),
            
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
            
            // 댓글작성
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
    
//MARK: - 서버 데이터 받아오기
    func fetchDataFromServer() {
        
        let url = "https://dev.homeat.site/v1/foodTalk/\(postId)"
        // Alamofire를 사용하여 서버에서 데이터를 가져옵니다
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: MealSource.self) { response in
                switch response.result {
                case .success(let data):
                    self.post = data
                    // 데이터를 받아온 후에 UI를 업데이트합니다.
                    self.updateUI()
                    
                    print("Successfully fetched data from server:")
                    print("name: \(data.name)")
                    print("memo: \(data.memo)")
                    print("Date: \(data.createdAt)")
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
        if let name = post?.name {
            titleLabel.text = name
        }
        if let memo = post?.memo {
            contentLabel.text = memo
        }
        if let dateString = post?.createdAt {
            // ISO8601DateFormatter를 사용하여 문자열 형태의 날짜를 날짜 객체로 변환합니다.
            if let isoDate = ISO8601DateFormatter().date(from: dateString) {
                // DateFormatter를 사용하여 날짜 형식을 변경합니다.
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let formattedDateString = dateFormatter.string(from: isoDate)
                
                date.text = formattedDateString
            } else {
                print("Error parsing ISO8601 date")
            }
        }
    }
    
    // MARK: - API 호출하여 이미지 가져오기
    func fetchImagesForPost() {
        // 게시물의 ID를 이용하여 서버에 이미지를 요청하는 API를 호출합니다.
        let urlString = "https://dev.homeat.site/v1/foodTalk/\(postId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching images: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // JSON 데이터 파싱하여 이미지 URL을 가져옵니다.
            do {
                let postData = try JSONDecoder().decode(MealSource.self, from: data)
                let imageUrls = postData.foodPictures.map { $0.url }
                print("Image URLs: \(imageUrls)") // 이미지 URL 출력
                // 이미지 URL을 이용하여 이미지 데이터를 비동기적으로 가져옵니다.
                self.fetchImages(from: imageUrls)
                
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
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
    @objc func delcareAction() {
        let declareVC = DeclareViewController()
        navigationController?.pushViewController(declareVC, animated: true)
    }
    
    
    @objc func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
}

extension MealPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
extension MealPostViewController: UITableViewDataSource {
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
extension MealPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("cell click")
            //셀을 선택된 후에 셀의 선택상태를 즉시해제 !
            tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

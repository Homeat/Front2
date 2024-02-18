//
//  WriteViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/10.
//

import UIKit
import Then
import SnapKit
import Alamofire

class WriteViewController: UIViewController, UITextFieldDelegate {
    var foodPosts:[MealSource] = []
    var currentPage = 1 // 현재 페이지 번호
    let pageSize = 6 // 한 번에 가져올 아이템 수
    var talkNavigationBarHiddenState: Bool = false
    var lastFoodTalkId: Int = 0
    //MARK: - 게시글 검색
    //검색 뷰
    lazy var searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "searchtf")
        if let borderColor = UIColor(named: "font3")?.cgColor {
            view.layer.borderColor = borderColor
        }
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        
        return view
    } ()
    
    // 텍스트 필드
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "관심있는 집밥을 검색해보세요"
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.textColor = UIColor(named: "searchfont")
        textField.attributedPlaceholder = NSAttributedString(string: "관심있는 집밥을 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? UIColor.gray])

        return textField
    }()
    
    // 검색 이미지
    lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Group 5064"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 순서버튼
    lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("최신순", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage(named: "Talk5"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(listAction), for: .touchUpInside)
        return button
    }()
    //MARK: - 해시태그 선택
    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = false
        view.isDirectionalLockEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var widthBaseView: UIView = {
            var view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var widthStackView: UIStackView = {
            var view = UIStackView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.distribution = .fill
            view.alignment = .fill
        view.spacing = 8
            return view
        }()
    
    lazy var contentbutton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor(r: 204, g: 204, b: 204).cgColor
        button.setTitle("#전체글", for: .normal)
        button.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.isSelected = true
        button.addTarget(self, action: #selector(tagClicked(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy var contentbutton2: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor(r: 204, g: 204, b: 204).cgColor
        button.setTitle("#주간_BEST", for: .normal)
        button.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: #selector(tagClicked(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy var contentbutton3: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor(r: 204, g: 204, b: 204).cgColor
        button.setTitle("#아침", for: .normal)
        button.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: #selector(tagClicked(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy var contentbutton4: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor(r: 204, g: 204, b: 204).cgColor
        button.setTitle("#점심", for: .normal)
        button.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: #selector(tagClicked(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy var contentbutton5: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor(r: 204, g: 204, b: 204).cgColor
        button.setTitle("#저녁", for: .normal)
        button.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: #selector(tagClicked(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.keyboardDismissMode = .onDrag
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let writingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Talk3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(writingButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - ViewSet
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromServer()
        addViews()
        setConstraints()
        searchTextField.delegate = self
        initialize();self.navigationController?.navigationBar.shadowImage = UIImage()
        collectionView.reloadData()
    }
    
    func initialize() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.register(MealViewCell.self, forCellWithReuseIdentifier: "MealViewCell")
    }
    
    private func addViews() {
        self.view.addSubview(searchView)
        self.searchView.addSubview(searchTextField)
        self.searchView.addSubview(searchImageView)
        self.view.addSubview(self.listButton)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.widthBaseView)
        self.widthBaseView.addSubview(self.widthStackView)
        self.widthStackView.addArrangedSubview(contentbutton)
        self.widthStackView.addArrangedSubview(contentbutton2)
        self.widthStackView.addArrangedSubview(contentbutton3)
        self.widthStackView.addArrangedSubview(contentbutton4)
        self.widthStackView.addArrangedSubview(contentbutton5)
        
        self.view.addSubview(self.collectionView)
        
        self.view.addSubview(self.writingButton)
        self.view.bringSubviewToFront(writingButton)
        self.writingButton.isHidden = false
    }
    
    private func setConstraints() {
        self.searchView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.searchView.widthAnchor.constraint(equalToConstant: 351).isActive = true
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 21),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -21),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10),
            searchTextField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: -10),

            searchImageView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
            searchImageView.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 14.95), // Adjust the width as needed
            searchImageView.heightAnchor.constraint(equalToConstant: 14.95), // Adjust the height as needed
            
            self.listButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 16),
            self.listButton.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: listButton.bottomAnchor, constant: 12),
            scrollView.heightAnchor.constraint(equalToConstant: 31),
            
            widthBaseView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            widthBaseView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            widthBaseView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            widthBaseView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            widthStackView.leadingAnchor.constraint(equalTo: widthBaseView.leadingAnchor),
            widthStackView.trailingAnchor.constraint(equalTo: widthBaseView.trailingAnchor),
            widthStackView.topAnchor.constraint(equalTo: widthBaseView.topAnchor),
            widthStackView.bottomAnchor.constraint(equalTo: widthBaseView.bottomAnchor),
            
            contentbutton.leadingAnchor.constraint(equalTo: widthBaseView.leadingAnchor, constant: 20),
            contentbutton.widthAnchor.constraint(equalToConstant: 68),
            contentbutton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton2.widthAnchor.constraint(equalToConstant: 95),
            contentbutton2.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton3.widthAnchor.constraint(equalToConstant: 56),
            contentbutton3.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton4.widthAnchor.constraint(equalToConstant: 56),
            contentbutton4.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton4.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton5.widthAnchor.constraint(equalToConstant: 56),
            contentbutton5.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton5.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            writingButton.widthAnchor.constraint(equalToConstant: 51),
            writingButton.heightAnchor.constraint(equalToConstant: 51),
            writingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            writingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -12)
        
        ])
    }
    //MARK: - 키보드 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // 키보드 내리면서 동작
        textField.resignFirstResponder()
        return true
    }
    
//MARK: - 서버 연결
    // 스크롤이 발생할 때 호출되는 메서드
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            // 스크롤이 테이블 뷰의 아래 끝에 도달하면 새로운 데이터를 가져옵니다.
            if offsetY > contentHeight - scrollView.frame.height {
                fetchDataFromServer()
            }
        }
//MARK: - 기본 게시글 정렬
    func fetchDataFromServer() {
        let url = "https://dev.homeat.site/v1/foodTalk/posts/latest"
        var parameters: [String: Any] = [:] // 파라미터 변수를 var로 변경
        // 처음 호출일 경우에만 Int.max로 설정
        if self.foodPosts.isEmpty {
            parameters["lastFoodTalkId"] = Int.max //99999999
        } else {
            parameters["lastFoodTalkId"] = self.lastFoodTalkId
            print(lastFoodTalkId)
        }
        parameters["size"] = pageSize // 한 번에 가져올 아이템 수 설정
        parameters["object"] = ["search": ""]
        parameters["object2"] = ["tag": ""]
        print(parameters) // parameters 값 출력
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonDict = value as? [String: Any] {
                        if let jsonArray = jsonDict["content"] as? [[String: Any]] {
                            print(jsonArray) // 서버 응답 확인을 위한 출력
                            print("성공")
                            if !jsonArray.isEmpty {
                                // 마지막 정보 대화 ID 설정
                                if let lastItem = jsonArray.last, let id = lastItem["foodTalkId"] as? Int {
                                    print(id)
                                    self.lastFoodTalkId = id
                                    print("Last Food Talk ID: \(id)")
                                    print("id성공")
                                }
                        
                                // 새로운 데이터를 담을 임시 배열
                                var newPosts: [MealSource] = []
                                for json in jsonArray {
                                    if let mealSource = self.parseMyItemFromJSON(json) {
                                        if !self.foodPosts.contains(where: { $0.id == mealSource.id }) {
                                            newPosts.append(mealSource)
                                        }
                                        print("MyItem created successfully with infoTalkId: \(mealSource.id)")
                                        
                                    }else {
                                        
                                    }
                                }
                                // 새로운 데이터를 기존 데이터에 추가
                                self.foodPosts.append(contentsOf: newPosts)
                                self.collectionView.reloadData()
                                print("Fetched \(jsonArray.count) items")
                            } else {
                                print("No data available")
                            }
                }
            }
                case .failure(let error):
                    print("Error fetching data from server: \(error)") // 에러 처리 확인을 위한 출력
                }
        }
    }
    // InfoViewController.swift 파일에 parseMyItemFromJSON 함수 추가
    func parseMyItemFromJSON(_ json: [String: Any]) -> MealSource? {
        guard let foodTalkId = json["foodTalkId"] as? Int,
              let url = json["url"] as? String, // 이미지 URL 추가
                let foodName = json["foodName"] as? String,
                let view = json["view"] as? Int,
                let love = json["love"] as? Int
            else {
                    return nil
                }
        let foodPictures: [FoodPicture] = [FoodPicture(createdAt: "", updatedAt: "", id: foodTalkId, url: url)]
        
        return MealSource(createdAt: "",
                          updatedAt: "",
                          id: foodTalkId,
                          name: foodName,
                          memo: "",
                          tag: "",
                          love: love,
                          view: view,
                          commentNumber: 0,
                          setLove: false,
                          save: "",
                          foodPictures: foodPictures,
                          foodRecipes: [],
                          foodTalkComments: [])
    }
    
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

    func displayDataOnCollectionView(_ mealSource: MealSource) {
        self.foodPosts.append(mealSource)
    }
    


//MARK: - objc 메서드
    // 해시태그 버튼을 클릭했을 때 발생하는 이벤트
    @objc func tagClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        // 모든 버튼에 대해서 선택된 상태를 업데이트합니다.
        for button in [contentbutton, contentbutton2, contentbutton3, contentbutton4, contentbutton5] {
            if button == sender {
                // 선택된 버튼인 경우, 선택된 색상으로 변경합니다.
                button.layer.borderWidth = 1.56
                button.layer.borderColor = UIColor(named: "green")?.cgColor
                button.setTitleColor(UIColor(named: "green"), for: .normal)
            } else {
                // 선택되지 않은 버튼인 경우, 선택되지 않은 색상으로 변경합니다.
                button.layer.borderWidth = 1.56
                button.layer.borderColor = UIColor(r: 204, g: 204, b: 204).cgColor
                button.setTitleColor(UIColor(r: 204, g: 204, b: 204), for: .normal)
            }
            button.isHidden = false // 모든 버튼을 보이도록 설정합니다.
        
        }
    }
    
    // 셀을 터치했을 때 발생하는 이벤트
    @objc func navigateToPostViewController() {
        let MealPostVC = MealPostViewController()
        navigationController?.pushViewController(MealPostVC, animated: true)
        print("present click")
    }
    
    // 글쓰기 버튼을 눌렀을 때 발생하는 이벤트
    @objc func writingButtonAction() {
        let nextVC = MealWritingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func listAction() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

       
        let newestAction = UIAlertAction(title: "최신순", style: .default) { _ in
            print("최신순 selected")
        }
        let likesAction = UIAlertAction(title: "공감순", style: .default) { _ in
            print("공감순 selected")
        }
        let viewsAction = UIAlertAction(title: "조회순", style: .default) { _ in
            print("조회순 selected")
           
        }
        let oldestAction = UIAlertAction(title: "오래된 순", style: .default) { _ in
            print("오래된 순 selected")
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        actionSheet.addAction(newestAction)
        actionSheet.addAction(likesAction)
        actionSheet.addAction(viewsAction)
        actionSheet.addAction(oldestAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
    
    //셀 각 인덱스 클릭시 게시물 화면으로 넘어가짐
    //InfoViewController - > PostViewController
    @objc func navigateToPostViewController(with postId: Int) {
        
        let postVC = MealPostViewController()
        postVC.postId = postId
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환
        navigationController?.pushViewController(postVC, animated: true)
        
        print("present click")
    }
}


//MARK: - 프로토콜
extension WriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealViewCell.id, for: indexPath) as? MealViewCell else {
            return UICollectionViewCell()
        }
        
        let post = foodPosts[indexPath.item]
        cell.mealLabel.text = post.name
        if let imageUrl = post.foodPictures.first?.url {
            AF.request(imageUrl).responseData { response in
                if let data = response.data {
                    let image = UIImage(data: data)
                    // PostImageView 설정
                    cell.mealImage.image = image
                }
            }
        }

        return cell
    }
}

extension WriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell click")
        let selectedPost = foodPosts[indexPath.item]
        //셀을 선택된 후에 셀의 선택상태를 즉시해제 !
        collectionView.deselectItem(at: indexPath, animated: true)
        navigateToPostViewController(with: selectedPost.id)
        print(selectedPost.id)
    }
}

// 여기서 cell의 크기를 결정
extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 2 - 18
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
        }
        
        // CollectionView Cell의 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 30.0
        }
}

    
    


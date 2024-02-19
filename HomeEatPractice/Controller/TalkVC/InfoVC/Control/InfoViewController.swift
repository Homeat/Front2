//
//  InfoViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/10.
//

import UIKit
import Then
import SnapKit
import Alamofire

class InfoViewController: UIViewController {
    var posts:[MyItem] = []
    var currentPage = 1 // 현재 페이지 번호
    let pageSize = 6 // 한 번에 가져올 아이템 수
    var talkNavigationBarHiddenState: Bool = false
    var lastInfoTalkId: Int = 0
    //검색 뷰
    private let SearchView =  UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "searchtf")
        if let borderColor = UIColor(named: "font3")?.cgColor {
            $0.layer.borderColor = borderColor
        }
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.masksToBounds = true
    }
    // 텍스트 필드
    private let searchTextField =  UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "관심있는 집밥을 검색해보세요"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor(named: "searchfont")
        $0.attributedPlaceholder = NSAttributedString(string: "관심있는 집밥을 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? UIColor.gray])
    }
    // 검색 이미지
    private let searchImageView = UIImageView().then {
        $0.image = UIImage(named: "Talk7")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
       
    }
    // 순서버튼
    private let procedureButton =  UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("최신순", for: .normal)
        $0.setTitleColor(UIColor(named: "green"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.setImage(UIImage(named: "Talk5"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .leading
    }
    //위치 버튼
    private let locationButton =  UIButton().then {
        $0.setTitle("성북구 월복동", for: .normal)
        $0.setTitleColor(UIColor(named: "green"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.setImage(UIImage(named: "Talk8"), for: .normal)
        let spacing: CGFloat = 3.6
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //테이블 뷰
    private let tableView =  UITableView().then {
        $0.allowsSelection = true //셀 클릭이 가능하게 하는거
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.register(TableViewCellOne.self, forCellReuseIdentifier: TableViewCellOne.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //플로팅버튼
    private let floatingButton = UIButton().then {
        
        $0.setImage(UIImage(named: "Talk3"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(floatingButtonAction(_:)), for: .touchUpInside)
    }
    //컬렉션 뷰
    private let actionSheetCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            // collectionView 설정
            return collectionView
    }()
 //정보토크
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromServer()
        configure()
        updateLocation()
        addSubView()
        configUI()
        tableView.reloadData()
        

        
    }
    // 스크롤이 발생할 때 호출되는 메서드
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            // 스크롤이 테이블 뷰의 아래 끝에 도달하면 새로운 데이터를 가져옵니다.
            if offsetY > contentHeight - scrollView.frame.height {
                fetchDataFromServer()
            }
        }
    func fetchDataFromServer() {
        let url = "https://dev.homeat.site/v1/infoTalk/posts/latest"
        var parameters: [String: Any] = [:] // 파라미터 변수를 var로 변경
        // 처음 호출일 경우에만 Int.max로 설정
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            loginToken = token
        } else {
            print("토큰이 없습니다.")
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        if self.posts.isEmpty {
            parameters["lastInfoTalkId"] = Int.max //99999999
        } else {
            parameters["lastInfoTalkId"] = self.lastInfoTalkId
        }
        parameters["size"] = pageSize // 한 번에 가져올 아이템 수 설정
        parameters["object"] = ["search": ""]
        print(parameters) // parameters 값 출력
        AF.request(url, method: .get, parameters: parameters,headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonDict = value as? [String: Any] {
                        if let jsonArray = jsonDict["content"] as? [[String: Any]] {
                            // 서버 응답 확인을 위한 출력
                            print(jsonArray)
                            // 데이터를 가져온 후에 tableView를 리로드합니다.
                            
                            if !jsonArray.isEmpty {
                                
                                if let lastItem = jsonArray.last, let id = lastItem["infoTalkId"] as? Int {
                                    self.lastInfoTalkId = id
                                    print("Last Info Talk ID: \(id)")
                                }
                                
                                // 새로운 데이터를 담을 임시 배열
                                var newPosts: [MyItem] = []
                                for json in jsonArray {
                                    if let myItem = self.parseMyItemFromJSON(json) {
                                        if !self.posts.contains(where: { $0.id == myItem.id }) {
                                            newPosts.append(myItem)
                                        }
                                        print("MyItem created successfully with infoTalkId: \(myItem.id)")

                                    }else {
                                        
                                    }
                                    
                                }
                                // 새로운 데이터를 기존 데이터에 추가
                                self.posts.append(contentsOf: newPosts)
                                self.tableView.reloadData()
                                print("Fetched \(jsonArray.count) items")
                                print("Total number of items in posts array: \(self.posts.count)")

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

    func parseMyItemFromJSON(_ json: [String: Any]) -> MyItem? {
        guard let infoTalkId = json["infoTalkId"] as? Int,
             let title = json["title"] as? String,
             let createdAt = json["createdAt"] as? String,
             let updatedAt = json["updatedAt"] as? String,
             let content = json["content"] as? String,
            let url = json["url"] as? String, // 이미지 URL 추가
              let love = json["love"] as? Int,
              let view = json["view"] as? Int,
             let commentNumber = json["commentNumber"] as? Int
       else {
           return nil
       }

        let infoPictures: [InfoPicture] = [InfoPicture(createdAt: "", updatedAt: "", id: infoTalkId, url: url)]
        let member = Member(createdAt: "", updatedAt: "", id: infoTalkId, email: "", password: "", nickname: "", profileImgUrl: "", loginType: "", status: "")

        let formattedCreatedAt = formatDateString(createdAt)
        let formattedUpdatedAt = formatDateString(updatedAt)
        
        return MyItem(id: infoTalkId,
                          title: title,
                          createdAt: formattedCreatedAt,
                          updatedAt: formattedUpdatedAt,
                          content: content,
                          love: love, // JSON 데이터에는 love 필드가 없으므로 기본값으로 설정
                          view: view, // 조회수 필드가 없으므로 기본값으로 설정
                          commentNumber: commentNumber,
                          setLove: false, // setLove 필드가 없으므로 기본값으로 설정
                          save: "", // save 필드가 없으므로 빈 문자열로 설정
                          infoPictures: infoPictures,
                          infoHashTags: [], // infoHashTags 필드가 없으므로 빈 배열로 설정
                          infoTalkComments: [],
                            member: member

                            ) // infoTalkComments 필드가 없으므로 빈 배열로 설정
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



//    func displayDataOnCollectionView(_ myItem: MyItem) {
//        self.posts.append(myItem)
//    }

    func updateLocation() {
        let userLocation = UserDefaults.standard.string(forKey: "userAddress")
        locationButton.setTitle(userLocation, for: .normal)

    }
    
    func addSubView() {
        view.addSubview(SearchView)
        SearchView.addSubview(searchTextField)
        SearchView.addSubview(searchImageView)
        view.addSubview(locationButton)
        view.addSubview(procedureButton)
        view.addSubview(tableView)
        view.addSubview(floatingButton)
        view.bringSubviewToFront(floatingButton)
        floatingButton.isHidden = false
    }
    func configUI() {
        tableView.backgroundColor = UIColor.init(named: "gray2")
        SearchView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        SearchView.widthAnchor.constraint(equalToConstant: 351).isActive = true
        
        NSLayoutConstraint.activate([
            SearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            SearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 21),
            SearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -21),
            
            searchTextField.leadingAnchor.constraint(equalTo: SearchView.leadingAnchor, constant: 10),
            searchTextField.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: -10),

            searchImageView.trailingAnchor.constraint(equalTo: SearchView.trailingAnchor, constant: -10),
            searchImageView.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 14.95), // Adjust the width as needed
            searchImageView.heightAnchor.constraint(equalToConstant: 14.95) // Adjust the height as needed
            ])
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: SearchView.bottomAnchor, constant: 16),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            procedureButton.topAnchor.constraint(equalTo: SearchView.bottomAnchor, constant: 16),
            procedureButton.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant: 21),
            //procedureButton.trailingAnchor.constraint(equalTo: locationButton.leadingAnchor, constant: -210),
            
            tableView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            floatingButton.widthAnchor.constraint(equalToConstant: 51),
            floatingButton.heightAnchor.constraint(equalToConstant: 51),
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -12)
            
            
            ])
        
        
        
    }
    func configure() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // 예상되는 높이를 설정합니다.
        
        procedureButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        }
    //'최신순'버튼 눌렀을 때 액션 리스너
    @objc func showActionSheet() {
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
        newestAction.setValue(UIColor.white, forKey: "titleTextColor")
        
        likesAction.setValue(UIColor.white, forKey: "titleTextColor")
        viewsAction.setValue(UIColor.white, forKey: "titleTextColor")
        oldestAction.setValue(UIColor.white, forKey: "titleTextColor")
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        // 액션시트가 나타나기 전에 배경색 설정
        if let actionSheetView = actionSheet.view.subviews.first,
            let subview = actionSheetView.subviews.first {
            subview.backgroundColor = UIColor.black
        }
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
        
        let postVC = PostViewController()
        postVC.postId = postId
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환
        navigationController?.pushViewController(postVC, animated: true)
        
        print("present click")
    }

}

extension InfoViewController {
    //글쓰기 버튼
    @objc private func floatingButtonAction(_ sender: UIButton) {
        let nextVC = InfoWritingViewController()
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
// InfoViewController.swift 파일에 UITableViewDataSource extension 수정
extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count // 서버에서 받아온 데이터의 개수만큼 셀을 표시합니다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellOne.identifier, for: indexPath) as? TableViewCellOne else {
            return UITableViewCell()
        }

        let post = posts[indexPath.row]
        cell.titleLabel.text = post.title
        cell.dateLabel.text = post.createdAt
        cell.contentLabel.text = post.content
        cell.heartLabel.text = "\(post.love)"
        cell.chatLabel.text = "\(post.commentNumber)"
        cell.selectionStyle = .none
        // 이미지를 비동기적으로 가져오는 방법에 따라 구현
        if let imageUrl = post.infoPictures.first?.url {
            AF.request(imageUrl).responseData { response in
                if let data = response.data {
                    let image = UIImage(data: data)
                    // PostImageView 설정
                    cell.PostImageView.image = image
                    // heartImage 설정
                    cell.heartImage.image = UIImage(named: "Talk6")
                    // chatImage 설정
                    cell.chatImage.image = UIImage(named: "Talk10")
                }
            }
        }

        return cell
    }


}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("cell click")
            let selectedPost = posts[indexPath.row]
            //셀을 선택된 후에 셀의 선택상태를 즉시해제 !
            tableView.deselectRow(at: indexPath, animated: true)
        navigateToPostViewController(with: selectedPost.id)
        print(selectedPost.id)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

    



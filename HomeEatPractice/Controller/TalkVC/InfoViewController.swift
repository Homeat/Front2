//
//  InfoViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/10.
//

import UIKit

class InfoViewController: UIViewController {
    //검색 뷰
    lazy var SearchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "searchtf")
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
    lazy var procedureButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("최신순", for: .normal)
        button.setTitleColor(UIColor(named: "locationfont"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage(named: "Rectangle 2993"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading

        return button
    }()
    //위치 버튼
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("성북구 월복동", for: .normal)
        button.setTitleColor(UIColor(named: "locationfont"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage(named: "Group 5049"), for: .normal)
        let spacing: CGFloat = 3.6
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)

        return button
    }()
    //테이블 뷰
    private let tableView: UITableView = {
        let view = UITableView()
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = true
        view.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        view.register(TableViewCellOne.self, forCellReuseIdentifier: TableViewCellOne.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    var items: [MyItem] = [
        MyItem(title: "게시글 제목", date: "11월 20일 24:08",content: "게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다.  게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. ",postImage: UIImage(named: "example1"),heartImage: UIImage(named: "heart"),heartLabel: "8",chatImage: UIImage(named: "chat"),chatLabel: "15"),
        MyItem(title: "게시글 제목", date: "11월 20일 24:08",content: "게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다.  게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. ",postImage: UIImage(named: "example1"),heartImage: UIImage(named: "heart"),heartLabel: "8",chatImage: UIImage(named: "chat"),chatLabel: "15"),
        MyItem(title: "게시글 제목", date: "11월 20일 24:08",content: "게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다.  게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. ",postImage: UIImage(named: "example1"),heartImage: UIImage(named: "heart"),heartLabel: "8",chatImage: UIImage(named: "chat"),chatLabel: "15"),
        MyItem(title: "게시글 제목", date: "11월 20일 24:08",content: "게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다.  게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. ",postImage: UIImage(named: "example1"),heartImage: UIImage(named: "heart"),heartLabel: "8",chatImage: UIImage(named: "chat"),chatLabel: "15"),
        MyItem(title: "게시글 제목", date: "11월 20일 24:08",content: "게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다.  게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. 게시글 내용이 들어갈 자리입니다. ",postImage: UIImage(named: "example1"),heartImage: UIImage(named: "heart"),heartLabel: "8",chatImage: UIImage(named: "chat"),chatLabel: "15"),

        ]
 //정보토크
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubView()
        configUI()
        
        
    }
    func addSubView() {
        view.addSubview(SearchView)
        
        SearchView.addSubview(searchTextField)
        SearchView.addSubview(searchImageView)
        view.addSubview(locationButton)
        view.addSubview(procedureButton)
        view.addSubview(tableView)
    }
    func configUI() {
        SearchView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        SearchView.widthAnchor.constraint(equalToConstant: 351).isActive = true
        NSLayoutConstraint.activate([
            SearchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            SearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
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
            procedureButton.trailingAnchor.constraint(equalTo: locationButton.leadingAnchor, constant: -210),
            
            tableView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        
        
    }
    func configure() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }

}
extension InfoViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                  numberOfRowsInSection section: Int) -> Int {
      return items.count
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
  func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellOne.identifier, for: indexPath) as? TableViewCellOne else {
                  return UITableViewCell()
              }
      let item = items[indexPath.row]
          cell.titleLabel.text = item.title
          cell.dateLabel.text = item.date
          cell.contentLabel.text = item.content
          cell.PostImageView.image = item.postImage
          cell.heartImage.image = item.heartImage
          cell.heartLabel.text = item.heartLabel
          cell.chatImage.image = item.chatImage
          cell.chatLabel.text = item.chatLabel
          return cell
  }
}
extension InfoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
    

    



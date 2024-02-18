//
//  BadgeCheckViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/19.
//

import UIKit
import Then
import Alamofire

class WeekCashViewController: UIViewController {
    
    var reuseIdentifier = "WeekCollectionViewCell"
    // 보여줄셀의 개수
    var numberOfCell = 9
    
    var responseData: UserResponseData?
//MARK: - 일반프로퍼티
    private lazy var cashIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Cash1")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let cashLabel: UILabel = {
        let label = UILabel()
        label.text = "홈잇러버"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let nickNamelabel: UILabel = {
        let label = UILabel()
        label.text = "OO님"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var badgeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        collectionView.isScrollEnabled = false
        collectionView.layer.cornerRadius = 35
        collectionView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        badgeCollectionView.delegate = self
        badgeCollectionView.dataSource = self
        setConstraints()
        fetchDataFromServer() // 서버에서 데이터를 가져옴
        if let name = UserDefaults.standard.string(forKey: "userNickname") {
            nickNamelabel.text = "\(name) 님"
        } else {
            // UserDefaults에서 값이 없는 경우에 대한 처리
            nickNamelabel.text = "닉네임이 설정되지 않았습니다."
        }
    }
    
    func setConstraints() {
        self.view.addSubview(self.cashIcon)
        self.view.addSubview(self.cashLabel)
        self.view.addSubview(self.nickNamelabel)
        self.view.addSubview(self.badgeCollectionView)
        
        NSLayoutConstraint.activate([
            
            self.cashIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            self.cashIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            self.cashIcon.heightAnchor.constraint(equalToConstant: 15),
            self.cashIcon.widthAnchor.constraint(equalToConstant: 15),
            
            self.cashLabel.leadingAnchor.constraint(equalTo: cashIcon.trailingAnchor, constant: 6),
            self.cashLabel.topAnchor.constraint(equalTo: cashIcon.topAnchor),
            self.cashLabel.bottomAnchor.constraint(equalTo: cashIcon.bottomAnchor),
            
            nickNamelabel.leadingAnchor.constraint(equalTo: cashLabel.trailingAnchor, constant: 6),
            nickNamelabel.topAnchor.constraint(equalTo: cashIcon.topAnchor),
            nickNamelabel.bottomAnchor.constraint(equalTo: cashIcon.bottomAnchor),
            
            self.badgeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.badgeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.badgeCollectionView.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: 21),
            self.badgeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    func fetchDataFromServer() {
        let url = "https://dev.homeat.site/v1/badgeReport/TierNickname"
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            // 옵셔널이 nil이 아닌 경우에만 이 코드 블록이 실행됩니다.
            // token을 안전하게 사용할 수 있습니다.
            loginToken = token
        } else {
            // 옵셔널이 nil인 경우에는 이 코드 블록이 실행됩니다.
            print("토큰이 없습니다.")
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        print("\(loginToken)")
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: ResponseData.self) { response in
                switch response.result {
                case .success(let responseData):
                    // 데이터 사용 가능
                    print("isSuccess: \(responseData.isSuccess)")
                    print("code: \(responseData.code)")
                    print("message: \(responseData.message)")
                    print("tierStatus: \(responseData.data.tierStatus)")
                    print("nickname: \(responseData.data.nickname)")
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
    }
        // JSON 데이터를 읽어와서 ResponseData 객체로 파싱하는 함수
    func parseResponseData(from jsonData: Data) -> ResponseData? {
        do {
            let decoder = JSONDecoder()
            let responseData = try decoder.decode(ResponseData.self, from: jsonData)
            return responseData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    
    }

//MARK: - CollectionView 프로토콜
extension WeekCashViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCell
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.id, for: indexPath) as? WeekCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        return cell
    }
}

extension WeekCashViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 131)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}

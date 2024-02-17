//
//  CommentTableViewCell.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/16.
//

import UIKit
import Then

class CommentTableViewCell: UITableViewCell {
    static let identifier = "CommentTableViewCell"
    //프로필이미지 넣을 원형뷰
    private let circleView = UIView().then {
        $0.layer.cornerRadius = 43
        $0.layer.borderWidth = 3.0 // 흰 테두리 두께 조절
        $0.layer.borderColor = UIColor.white.cgColor // 흰 테두리 색상 설정
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "green")
    }
    //프로필 이미지
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "Mypage4") // 실제 프로필 이미지의 이름으로 변경
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let profileName = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = UIColor.init(named: "green")
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //신고하기 버튼
    // 신고하기
    lazy var complainLabel: UIButton = {
        let button = UIButton()
        button.setTitle("신고하기", for: .normal)
        button.setTitleColor(UIColor(r: 165, g: 165, b: 165), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //댓글 내용
    private let commentContent =  UILabel().then {
        $0.text = "댓글 내용 들어갈 자리입니다."
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let dateLabel = UILabel().then {
        $0.text = "11월 20일 24:22"
        $0.textColor = UIColor(r: 165, g: 165, b: 165)
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(circleView)
        circleView.addSubview(profileImageView)
        contentView.addSubview(profileName)
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            circleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            circleView.widthAnchor.constraint(equalToConstant: 37.8), // 원형 뷰의 크기 설정
            circleView.heightAnchor.constraint(equalToConstant: 37.8), // 원형 뷰의 크기 설정
            
            profileImageView.topAnchor.constraint(equalTo: circleView.topAnchor,constant: 16.5),
            profileImageView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor,constant: 7),
            profileImageView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor,constant: -7),
            profileImageView.heightAnchor.constraint(equalToConstant: 23.1),
            
            profileName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileName.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 11.2),
            
            commentContent.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 2),
            commentContent.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            
            complainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            complainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            complainLabel.widthAnchor.constraint(equalToConstant: 37),
            
            dateLabel.topAnchor.constraint(equalTo: commentContent.bottomAnchor,constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: commentContent.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 72),
            
        ])
        
    }
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

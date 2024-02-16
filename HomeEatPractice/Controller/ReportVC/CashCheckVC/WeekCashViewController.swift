//
//  BadgeCheckViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/19.
//

import UIKit
import Then
class WeekCashViewController: UIViewController {
    
    var reuseIdentifier = "WeekCollectionViewCell"
    // 보여줄셀의 개수
    var numberOfCell = 9
    
//MARK: - 일반프로퍼티
    private lazy var cashIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Cash1")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let cashLabel: UILabel = {
        let label = UILabel()
        label.text = "홈잇러버 OO님"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "NotoSansKR-Medium", size: 15)
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
        
    }
    
    func setConstraints() {
        self.view.addSubview(self.cashIcon)
        self.view.addSubview(self.cashLabel)
        self.view.addSubview(self.badgeCollectionView)
        
        NSLayoutConstraint.activate([
            
            self.cashIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            self.cashIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            self.cashIcon.heightAnchor.constraint(equalToConstant: 15),
            self.cashIcon.widthAnchor.constraint(equalToConstant: 15),
            
            self.cashLabel.leadingAnchor.constraint(equalTo: cashIcon.trailingAnchor, constant: 6),
            self.cashLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            self.cashLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.badgeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.badgeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.badgeCollectionView.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: 21),
            self.badgeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
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

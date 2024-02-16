//
//  reportCell.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/15/24.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
    static let id = "WeekCollectionViewCell"
    
    lazy var cellView: UIView = {
        let view = UIView()
            view.backgroundColor = UIColor(r: 21, g: 221, b: 148)
            view.clipsToBounds = true
            view.layer.cornerRadius = 50
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 1, height: 1)
            view.layer.shadowRadius = 4
            view.layer.masksToBounds = true // inner shadow를 위해 수정
            
            // bounds 업데이트
            view.layoutIfNeeded()
            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
           
        return view
    }()
    
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 54, g: 56, b: 57)
        label.text = "1W"
        label.font = UIFont(name: "NotoSansKR-Black", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Cash5")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var successMoney: UILabel = {
        let label = UILabel()
        label.text = "70,000원"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "green")
        return label
    }()
    
    lazy var failMoney: UILabel = {
        let label = UILabel()
        label.text = "4,500원"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(r: 255, g: 91, b: 91)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(cellView)
        cellView.addSubview(imageView)
        cellView.addSubview(weekLabel)
        contentView.addSubview(successMoney)
        contentView.addSubview(failMoney)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 100),

            weekLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            weekLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 38),
            weekLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -38),
            weekLabel.heightAnchor.constraint(equalToConstant: 22),
            
            imageView.topAnchor.constraint(equalTo: weekLabel.bottomAnchor, constant: 6),
            imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -30),
            imageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -14.5),
            
            successMoney.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 5),
            successMoney.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            successMoney.heightAnchor.constraint(equalToConstant: 20),
            
            failMoney.topAnchor.constraint(equalTo: successMoney.bottomAnchor),
            failMoney.trailingAnchor.constraint(equalTo: successMoney.trailingAnchor),
            failMoney.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

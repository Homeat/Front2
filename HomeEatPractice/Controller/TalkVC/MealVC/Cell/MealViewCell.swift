//
//  MealViewCell.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/19.
//

import UIKit

class MealViewCell: UICollectionViewCell {
    static let id = "MealViewCell"
    
    var mealLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mealImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 10.99
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(r: 42, g: 42, b: 44)
        setView()
        setConstraints()
    }
    
    func setView() {
        self.contentView.addSubview(self.mealImage)
        self.contentView.addSubview(self.mealLabel)
        self.layer.cornerRadius = 17
        self.clipsToBounds = true

    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            self.mealImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            self.mealImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            self.mealImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            self.mealImage.bottomAnchor.constraint(equalTo: mealLabel.topAnchor, constant: -8),
        
            self.mealLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            self.mealLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.mealLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

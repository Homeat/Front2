//
//  CalendarCollectionViewCell.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/14.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    lazy var dayLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    override func prepareForReuse() {
        self.dayLabel.text = nil
    }
    
    func update(day: String) {
        self.dayLabel.text = day
    }
    
    private func configure() {
        self.addSubview(self.dayLabel)
        self.dayLabel.textColor = UIColor.white
        self.dayLabel.font = .boldSystemFont(ofSize: 18)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        // contentView에 원형의 코너 라디우스 적용
        self.applyCornerRadius()
    }
    
    func applyCornerRadius() {
        self.contentView.layer.cornerRadius = self.bounds.width / 2
        self.contentView.clipsToBounds = true
    }
    
    func removeCornerRadius() {
        self.contentView.layer.cornerRadius = 0
        self.contentView.clipsToBounds = false
    }
    
}

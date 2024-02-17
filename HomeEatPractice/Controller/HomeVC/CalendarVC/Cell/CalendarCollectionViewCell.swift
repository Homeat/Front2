//
//  CalendarCollectionViewCell.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/14.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCollectionViewCell"
    private lazy var dayLabel = UILabel()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func configureLabel(text: String, isCustomColor: Bool) {
        self.addSubview(dayLabel)
        self.dayLabel.text = text
        self.dayLabel.font = .systemFont(ofSize: 18,weight: .bold)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        self.dayLabel.textColor = isCustomColor ? .black : .white
    }
    func configureCellBackground(for text: String) {
        // 원하는 조건에 따라 셀의 배경을 설정
        if text == "1" || text == "3" {
            let halfHeight = bounds.height / 2 // 셀의 세로 길이의 절반
            
            // 위쪽 반을 칠할 사각형을 만듭니다.
            let topRect = CGRect(x: 0, y: 0, width: bounds.width, height: halfHeight)
            let topLayer = CALayer()
            topLayer.frame = topRect
            
            // 아래쪽 반을 칠할 사각형을 만듭니다.
            let bottomRect = CGRect(x: 0, y: halfHeight, width: bounds.width, height: halfHeight)
            let bottomLayer = CALayer()
            bottomLayer.frame = bottomRect
            
            if text == "1" {
                topLayer.backgroundColor = UIColor(named: "green")?.cgColor
                bottomLayer.backgroundColor =  UIColor(named: "font6")?.cgColor
            } else {
                backgroundColor = UIColor(named: "green")
            }
            
            // 위쪽 반과 아래쪽 반의 색상을 셀에 추가합니다.
            layer.addSublayer(topLayer)
            layer.addSublayer(bottomLayer)
            
            // 둥근 모서리 설정
            layer.cornerRadius = 10
            layer.masksToBounds = true
        } else {
            backgroundColor = .clear
        }
        self.dayLabel.textColor = (text == "1" || text == "3") ? .black : .black
    }

}

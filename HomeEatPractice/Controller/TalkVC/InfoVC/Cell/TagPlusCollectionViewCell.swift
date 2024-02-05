//
//  TagPlusCollectionViewCell.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/04.
//

import UIKit

class TagPlusCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TagPlusCell"
    let talk12Image = UIImage(named: "Talk12")
    private let tagButton =  UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("#할인", for: .normal)
        $0.layer.cornerRadius = 22.5
        $0.clipsToBounds = true
        // 버튼의 원래 border 색상 및 title 색상
        let normalBorderColor = UIColor(named: "font5")?.cgColor ?? UIColor.gray.cgColor
        let normalTitleColor = UIColor(named: "font5") ?? UIColor.gray
        $0.setTitleColor(normalTitleColor, for: .normal)
        //버튼이 선택되었을 때의 border 색상 및 title 색상
        let selectedBorderColor = UIColor(named: "green")?.cgColor ?? UIColor.red.cgColor
        let selectedTitleColor = UIColor(named: "green") ?? UIColor.red
        $0.setTitleColor(selectedTitleColor, for: .selected)
        $0.backgroundColor = UIColor(named: "gray4")
        $0.layer.borderColor = normalBorderColor
        $0.layer.borderWidth = 2
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tagButton)

        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with tag: String, image: UIImage? = nil) {
            tagButton.setTitle("\(tag)", for: .normal)
            
            // 동적으로 셀 크기를 조정하기 위해 태그 문자열 길이에 따라 버튼의 크기를 조정합니다.
            let titleSize = NSString(string: tag).size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
            ])
            let buttonWidth = titleSize.width + 20 // 여유 공간을 더해 원하는 여백을 확보합니다.

            tagButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        }
}

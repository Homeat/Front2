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
    var onSelectStatusChange: ((Bool) -> Void)?
    // 클로저 프로퍼티 추가
    var onSelectionChange: (() -> Void)?
    var selectedTags: [String] = []
    let tagButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("#할인", for: .normal)
        $0.layer.cornerRadius = 22.5
        $0.clipsToBounds = true
        // 버튼의 원래 border 색상 및 title 색상
        let normalBorderColor = UIColor(named: "font5")?.cgColor ?? UIColor.gray.cgColor
        let normalTitleColor = UIColor(named: "font5") ?? UIColor.gray
        $0.setTitleColor(normalTitleColor, for: .normal)
        $0.backgroundColor = UIColor(named: "gray4")
        $0.layer.borderColor = normalBorderColor
        $0.layer.borderWidth = 2
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tagButton)
        NSLayoutConstraint.activate([
            // contentView에 대한 제약 조건
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        setupTapGestureRecognizers()


    }
    func updateTagButtonAppearance(selected: Bool) {
            if selected {
                tagButton.layer.borderColor = UIColor(named: "green")?.cgColor ?? UIColor.red.cgColor
                tagButton.setTitleColor(UIColor(named: "green") ?? UIColor.red, for: .selected)
            } else {
                tagButton.layer.borderColor = UIColor(named: "font5")?.cgColor ?? UIColor.gray.cgColor
                tagButton.setTitleColor(UIColor(named: "font5") ?? UIColor.gray, for: .normal)
            }
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with tag: String, image: UIImage? = nil, selectedTags: [String]) {
            self.selectedTags = selectedTags

            tagButton.setTitle("\(tag)", for: .normal)
            
            // 동적으로 셀 크기를 조정하기 위해 태그 문자열 길이에 따라 버튼의 크기를 조정합니다.
            let titleSize = NSString(string: tag).size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
            ])
            let buttonWidth = titleSize.width + 40 // 여유 공간을 더해 원하는 여백을 확보합니다.

            tagButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        }
    func setupTapGestureRecognizers() {
        let tagButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tagButtonTapped))
        tagButton.addGestureRecognizer(tagButtonTapGestureRecognizer)
    }
    @objc func tagButtonTapped() {
        // 버튼의 선택 상태를 토글합니다.
        tagButton.isSelected = !tagButton.isSelected
        
        // 버튼의 선택 상태에 따라 border color를 변경합니다.
        updateTagButtonAppearance(selected: tagButton.isSelected)
        
        // 선택 상태 변경 콜백 클로저를 호출합니다.
        onSelectStatusChange?(tagButton.isSelected)
        onSelectionChange?()
        
        // 버튼이 선택되었을 때만 해당 버튼의 문자열 값을 추가합니다.
        if tagButton.isSelected {
            if let title = tagButton.currentTitle {
                // 이미 선택된 태그가 아닌 경우에만 배열에 추가합니다.
                if !selectedTags.contains(title) {
                    selectedTags.append(title)
                    print(selectedTags)
                }
            }
        } else {
            // 선택이 해제된 경우 selectedTags 배열에서 해당 문자열을 제거합니다.
            if let title = tagButton.currentTitle, let index = selectedTags.firstIndex(of: title) {
                selectedTags.remove(at: index)
            }
        }
       
    }
}

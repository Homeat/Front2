//
//  PhotoCollectionViewCell.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/29.
//

import UIKit
//MARK: - 앨범 사진 셀
class MealPhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCell"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let deleteImage = UIImage(named: "Talk13")
        button.setImage(deleteImage, for: .normal)
        // 이미지 크기 조정
        button.imageView?.contentMode = .scaleAspectFit
      //  button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 9),
            deleteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10.8),
            deleteButton.heightAnchor.constraint(equalToConstant: 33.2),
            deleteButton.widthAnchor.constraint(equalToConstant: 33.2),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


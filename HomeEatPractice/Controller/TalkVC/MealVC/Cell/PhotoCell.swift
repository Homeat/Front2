//
//  PhotoCell.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/13/24.
//

import UIKit
import Then
import AVFoundation
import Photos
import PhotosUI

class PhotoCell: UICollectionViewCell {
    static let photoIdentifier = "PhotoCell"
    
    lazy var plusImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 9
        view.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        view.image = UIImage(named: "addIcon")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(plusImageView)
        NSLayoutConstraint.activate([
            plusImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            plusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            plusImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            plusImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}

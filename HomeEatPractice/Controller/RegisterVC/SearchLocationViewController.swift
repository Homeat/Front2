//
//  SearchLocationViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/23/24.
//

import Foundation
import UIKit
import SnapKit

class SearchLocationViewController : UIViewController {
    
    private let SearchView =  UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "gray4")
        if let borderColor = UIColor(named: "gray2")?.cgColor {
            $0.layer.borderColor = borderColor
        }
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    // 텍스트 필드
    private let searchTextField : UITextField = {
        let TextField = makeTextField()
        TextField.attributedPlaceholder = NSAttributedString(string: "동명 (읍, 면)으로 검색 (ex.서초동)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? UIColor(named: "searhfont") ?? .white])
        return TextField
        
    }()
    // 검색 이미지
    private let searchImageView = UIImageView().then {
        $0.image = UIImage(named: "Login1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
       
    }
    
    private lazy var currentLocationButton : UIButton = {
        let currentLocationButton = makeCustomButton(viewController: self, nextVC: MapViewController())
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.setTitle("현재 위치로 찾기", for: .normal)
        currentLocationButton.configuration?.image = UIImage(named: "gpsIcon")
        currentLocationButton.configuration?.imagePadding = 9
        currentLocationButton.configuration?.baseForegroundColor = UIColor(named: "green")
        currentLocationButton.configuration?.background.backgroundColor = UIColor(named: "gray2")
        currentLocationButton.configuration?.background.strokeColor = UIColor(named: "green")
        currentLocationButton.configuration?.background.strokeWidth = 2
        
        return currentLocationButton
    }()
    
    private let mainContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        
        self.view.addSubview(SearchView)
        self.view.addSubview(currentLocationButton)
        
        self.SearchView.addSubview(searchTextField)
        self.SearchView.addSubview(searchImageView)
        
        
        NSLayoutConstraint.activate([
            
            self.SearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.SearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 21),
            self.SearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -21),
            self.SearchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -677),
            
            searchTextField.leadingAnchor.constraint(equalTo: SearchView.leadingAnchor, constant: 0),
            searchTextField.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: 0),

            searchImageView.trailingAnchor.constraint(equalTo: SearchView.trailingAnchor, constant: -23),
            searchImageView.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 21), // Adjust the width as needed
            searchImageView.heightAnchor.constraint(equalToConstant: 21) // Adjust the height as needed
        ])
        
        NSLayoutConstraint.activate([
            
            self.currentLocationButton.topAnchor.constraint(equalTo: self.SearchView.bottomAnchor,constant: 27),
            self.currentLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.currentLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.currentLocationButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -601)
            
        ])
    }
    
    
}



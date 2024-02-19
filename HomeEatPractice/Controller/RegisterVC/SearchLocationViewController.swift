//
//  SearchLocationViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/23/24.
//

import Foundation
import UIKit
import SnapKit

class SearchLocationViewController : UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    var searchData : String = ""

    let scrollView : UIScrollView = UIScrollView()
    let contentView : UIView! = UIView()
    
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
    private lazy var searchImageView : UIButton = {
//        $0.image = UIImage(named: "Login1")
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.contentMode = .scaleAspectFit
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Login1")
        config.background.backgroundColor = UIColor(named: "gray4")
        config.cornerStyle = .small
    

        let buttonAction = UIAction{ _ in
            print("버튼 클릭")
            let latitude = UserDefaults.standard.double(forKey: "latitude")
            let logitude = UserDefaults.standard.double(forKey: "logitude")
            let keyword = self.searchData
            RegisterAPI.locationNearRequest(latitude: latitude, logitude: logitude, page: 0, keyword: self.searchData){result in
                switch result{
                case .success:
                    print(keyword)
                    print("검색 위치 설정 성공")
                    self.updateLocation()
                case .failure(_):
                    print(keyword)
                    print("검색 위치 설정 실패")
                }
            }
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
       
    }()
    
    private lazy var currentLocationButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("현재 위치로 찾기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.image = UIImage(named: "gpsIcon")
        config.imagePadding = 9
        config.background.backgroundColor = UIColor(named: "gray2")
        config.baseForegroundColor = UIColor(named: "green")
        config.cornerStyle = .medium
        config.background.strokeColor = UIColor(named: "green")
        config.background.strokeWidth = 2
    

        let buttonAction = UIAction{ _ in
            let latitude = UserDefaults.standard.double(forKey: "latitude")
            let logitude = UserDefaults.standard.double(forKey: "logitude")
            let keyword = self.searchData
            RegisterAPI.locationRequest(latitude: latitude, logitude: logitude, page: 0){result in
                switch result{
                case .success:
                    print("현재 위치 설정 성공")
                    self.updateLocation()
                case .failure(_):
                    print(keyword)
                    print("현재 위치 설정 실패")
                }
            }
            self.updateLocation()
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    private lazy var registerButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("등록하기")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = UIColor(named: "green")
        config.baseForegroundColor = .black
        config.cornerStyle = .small
        

        let buttonAction = UIAction{ _ in
            self.navigationController?.pushViewController(AddIncomeViewController(), animated: true)
            
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
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
    
    private let townContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
             }
    
    //done버튼 클릭해서 키패드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchData = searchTextField.text ?? ""
        print(searchTextField.text)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchData = searchTextField.text ?? ""
        print(searchTextField.text)
        return true
    }
    
    
    func updateLocation(){
        
        for subview in townContainer.arrangedSubviews {
            townContainer.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        if let jsonData = UserDefaults.standard.data(forKey: "locationData") {
            do {
                let decodedData = try JSONDecoder().decode(LocationResponse.self, from: jsonData)
                // 디코딩된 데이터를 사용하여 필요한 작업 수행
                let label1 = makeLabel(text: "근처 동네")
                townContainer.addArrangedSubview(label1)
                print(CGFloat(decodedData.data.totalColumnCount/decodedData.data.totlaPageNum))
                let townContainerHeight = CGFloat(decodedData.data.totalColumnCount/decodedData.data.totlaPageNum) * 70
                contentView.heightAnchor.constraint(equalToConstant: townContainerHeight).isActive = true
                for neighborhood in decodedData.data.neighborhoods{
                    var config = UIButton.Configuration.plain()
                    var attributedTitle = AttributedString(neighborhood.fullNm)
                    attributedTitle.font = .systemFont(ofSize: 13, weight: .bold)
                    config.attributedTitle = attributedTitle
                    config.background.backgroundColor = UIColor(named: "gray2")
                    config.baseForegroundColor = UIColor(named: "searchfont")
                    
                    let buttonAction = UIAction{ _ in
                        UserDefaults.standard.setValue(neighborhood.emdNm, forKey: "selectedLocation")
                        UserDefaults.standard.setValue(neighborhood.addressId, forKey: "regiaddressId")
                        
                        print(UserDefaults.standard.value(forKey: "selectedLocation"))
                        self.navigationController?.pushViewController(MapViewController(), animated: true)
                    }
                    let customButton = UIButton(configuration: config, primaryAction: buttonAction)
                    customButton.contentHorizontalAlignment = .left
                    townContainer.addArrangedSubview(customButton)
                    
                }
                
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        let _ = registerButton
        let _ = searchImageView
        searchTextField.delegate = self
        scrollView.delegate = self
        // UserDefaults에서 데이터를 가져와서 디코딩하여 객체로 변환
        updateLocation()
       

        
        
        //스크롤뷰 관련 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "동네 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.view.addSubview(SearchView)
        self.view.addSubview(currentLocationButton)
        self.view.addSubview(registerButton)
        
        self.SearchView.addSubview(searchTextField)
        self.SearchView.addSubview(searchImageView)
        
        self.contentView.addSubview(townContainer)
        
        
        NSLayoutConstraint.activate([
            
            self.SearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.SearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 21),
            self.SearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -21),
//            self.SearchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -677),
            self.SearchView.heightAnchor.constraint(equalToConstant: 57),
            
            searchTextField.leadingAnchor.constraint(equalTo: SearchView.leadingAnchor, constant: 0),
            searchTextField.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: 0),

            searchImageView.trailingAnchor.constraint(equalTo: SearchView.trailingAnchor, constant: -23),
            searchImageView.centerYAnchor.constraint(equalTo: SearchView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 21), // Adjust the width as needed
            searchImageView.heightAnchor.constraint(equalToConstant: 21) // Adjust the height as needed
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.currentLocationButton.bottomAnchor, constant: 33),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -141),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            
            self.currentLocationButton.topAnchor.constraint(equalTo: self.SearchView.bottomAnchor,constant: 27),
            self.currentLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.currentLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            self.currentLocationButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -601),
            currentLocationButton.heightAnchor.constraint(equalToConstant: 49),
            
            registerButton.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 13),
            registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            registerButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -71)
            
            
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤뷰의 현재 위치를 확인하여 바운드 여부를 판단
//        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= (scrollView.contentSize.height - scrollView.frame.size.height) {
//            print("bound")
//        }
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            print("bound")
        }
    }
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "searchfont")
        return label
    }
}


 

//
//  AddLocationInfromViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/14/24.
///


//돋보기부터
//전체가 버튼인지 질문
import Foundation
import UIKit
import CoreLocation

class AddLocationInfromViewController : CustomProgressViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    var latitude : Double?
    var longtitude : Double?
    
    
    var locationManager = CLLocationManager()
    
    private let registerContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "거주하고 있는 동네는\n어디인가요?"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let label2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "게시판 사용에 필요해요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "searchfont")
        label.textAlignment = .left
        return label
    }()
    
    private let label3 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주소"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private let searchButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "Login1")
        image?.withTintColor(UIColor(named: "searchfont") ?? .white)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var currentLocationButton : UIButton = {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("도로명, 지번, 건물명 검색")
        attributedTitle.font = .systemFont(ofSize: 16, weight: .medium)
        config.attributedTitle = attributedTitle
        config.image = UIImage(named: "Login1")
        config.imagePlacement = .trailing
        config.titleAlignment = .leading
        config.imagePadding = 140
        config.background.backgroundColor = UIColor(named: "gray4")
        config.cornerStyle = .medium
        config.baseForegroundColor = UIColor(named: "searchfont")

        let buttonAction = UIAction{ _ in
            print(self.longtitude)
            print(self.latitude)
            self.locationManager.stopUpdatingLocation()
            self.navigationController?.pushViewController(SearchLocationViewController(), animated: true)
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
             }
    
    //done버튼 클릭해서 키패드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    fileprivate func setLocationManager() {
        // 델리게이트를 설정하고,
        locationManager.delegate = self
        // 거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
        // 위치 사용을 허용하면 현재 위치 정보를 가져옴
        if CLLocationManager.locationServicesEnabled() {
           locationManager.startUpdatingLocation()
        }
        else {
            print("위치 서비스 허용 off")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
            latitude = location.coordinate.latitude
            longtitude = location.coordinate.longitude
        }
    }
        
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLocationManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        let _ = currentLocationButton
        self.view.backgroundColor = UIColor(named: "gray2")
        updateProgressBar(progress: 3/6)

        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "정보 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    

        
        self.view.addSubview(registerContainer)
        self.registerContainer.addArrangedSubview(label1)
        self.registerContainer.addArrangedSubview(label2)
        self.registerContainer.addArrangedSubview(label3)
//        locationTextField.inputAccessoryView = searchButton
        
        
        
        let continueButton = makeCustomButton(viewController: self, nextVC: AddIncomeViewController())
        
        
        self.registerContainer.addArrangedSubview(currentLocationButton)
        self.registerContainer.addArrangedSubview(continueButton)

        registerContainer.setCustomSpacing(41, after: label2)
        registerContainer.setCustomSpacing(5, after: label3)
        registerContainer.setCustomSpacing(293, after: currentLocationButton)
//        locationTextField.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            self.registerContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 91),
            self.registerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            self.registerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -76),
            
        
        ])
    }
    
    
}

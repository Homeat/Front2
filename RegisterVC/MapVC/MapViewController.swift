//
//  MapViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/26/24.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate{ //LocationManager를 사용하기 위한 Delegate
    
    let mapView = MapView()
    
    var currentLocation = CLLocationCoordinate2D() //새싹 영등포 캠퍼스의 위치입니다. 여기서 시작하면 재밌을 것 같죠? 하하
    
    let locationManager = CLLocationManager() //위치를 조종하게(?) 도와주는 로케이션 매니저를 하나 고용합시다.
    
    
    private let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "내 동네"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = UIColor(named: "green")
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addTownButton1 : UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "addIcon")
        config.background.backgroundColor = UIColor(named: "gray4")
        config.cornerStyle = .small
    

        let buttonAction = UIAction{ _ in
            self.navigationController?.pushViewController(MapViewController(), animated: true)
        }
        let customButton = UIButton(configuration: config, primaryAction: buttonAction)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    private lazy var addTownButton2 : UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "addIcon")
        config.background.backgroundColor = UIColor(named: "gray4")
        config.cornerStyle = .small
    

        let buttonAction = UIAction{ _ in
            self.navigationController?.pushViewController(MapViewController(), animated: true)
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
    
    override func loadView() {
//        view = mapView
        
        view = UIView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -359).isActive = true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        
        //navigationBar 바꾸는 부분
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.title = "동네 입력"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        locationManager.requestWhenInUseAuthorization() //권한요청도 알아서 척척!
        
        mapView.map.setRegion(MKCoordinateRegion(center: currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        
        mapView.map.delegate = self
        
        locationManager.delegate = self
        //현재 위치 업데이트
        locationManager.startUpdatingLocation()
        
        
        view.addSubview(addTownButton1)
        view.addSubview(addTownButton2)
        view.addSubview(label1)
        view.addSubview(registerButton)
        
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: 23),
            label1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21),
            label1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -302),
            
            addTownButton1.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 5),
            addTownButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTownButton1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -207),
            addTownButton1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
            
            addTownButton2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 5),
            addTownButton2.leadingAnchor.constraint(equalTo: addTownButton1.trailingAnchor, constant: 21),
            addTownButton2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addTownButton2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
            
            registerButton.topAnchor.constraint(equalTo: addTownButton1.bottomAnchor, constant: 115),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            
        ])
    }

    private func addPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = currentLocation
        mapView.map.addAnnotation(pin)
    }
    

    
    //권한 설정을 위한 코드들
    
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted:
            print("restricted")
            goSetting()
        case .denied:
            print("denided")
            goSetting()
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wheninuse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("unknown")
        }
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func goSetting() {
        
        let alert = UIAlertController(title: "위치권한 요청", message: "러닝 거리 기록을 위해 항상 위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            // 열 수 있는 url 이라면, 이동
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
            
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        }
    }
    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        print(#function)
//        checkUserLocationServicesAuthorization()
//    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last?.coordinate else{
            return
        }
        
        currentLocation = userLocation
        
        // 지도의 중심을 사용자의 현재 위치로 설정합니다.
        mapView.map.setCenter(userLocation, animated: true)
        
        // 위치 업데이트를 중지합니다.
        locationManager.stopUpdatingLocation()
        
        addPin()
        

    }


    
    //동별로 끊기
    func getAddress() {
            print("CLLocationManagerDelegate >> getAddress() ")
            locationManager.delegate = self
                locationManager.distanceFilter = kCLDistanceFilterNone
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            
                let geocoder = CLGeocoder.init()
                
                let location = self.locationManager.location
                
                if location != nil {
                    geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                        if error != nil {
                            return
                        }
                        if let placemark = placemarks?.first {
                            var address = ""
                            
                            if let administrativeArea = placemark.administrativeArea {
                                print("== [시/도] administrativeArea : \(administrativeArea)")  //서울특별시, 경기도
                                address = "\(address) \(administrativeArea) "
                            }
                            
                            if let locality = placemark.locality {
                                print("== [도시] locality : \(locality)") //서울시, 성남시, 수원시
                                address = "\(address) \(locality) "
                            }
                            
                            if let subLocality = placemark.subLocality {
                                print("== [추가 도시] subLocality : \(subLocality)") //강남구
                                address = "\(address) \(subLocality) "
                            }
                            
                            if let thoroughfare = placemark.thoroughfare {
                                print("== [상세주소] thoroughfare : \(thoroughfare)") //강남대로106길, 봉은사로2길
                                address = "\(address) \(thoroughfare) "
                            }
                            
                            if let subThoroughfare = placemark.subThoroughfare {
                                print("== [추가 거리 정보] subThoroughfare : \(subThoroughfare)") //272-13
                                address = "\(address) \(subThoroughfare)"
                            }
                            
                            print("CLLocationManagerDelegate >> getAddress() - address : \(address)")  // 서울특별시 광진구 중곡동 272-13
                            
                    
                        }
                 
                    }
                }
            }
    

}



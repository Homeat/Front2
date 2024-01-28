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
    
    let sesacCoordinate = CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976) //새싹 영등포 캠퍼스의 위치입니다. 여기서 시작하면 재밌을 것 같죠? 하하
    
    let locationManager = CLLocationManager() //위치를 조종하게(?) 도와주는 로케이션 매니저를 하나 고용합시다.
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization() //권한요청도 알아서 척척!
        
        mapView.map.setRegion(MKCoordinateRegion(center: sesacCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        
        mapView.map.delegate = self
        
        locationManager.delegate = self
        
        addCustomPin()
        
        buttonActions()
        
//        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 106),
//            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 359)
        ])
    }
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        //포인트 어노테이션은 뭔가요?
        pin.coordinate = sesacCoordinate
        pin.title = "새싹 영등포캠퍼스"
        pin.subtitle = "전체 3층짜리 건물"
        mapView.map.addAnnotation(pin)
    }
    
    
    //재사용 할 수 있는 어노테이션 만들기! 마치 테이블뷰의 재사용 Cell을 넣어주는 것과 같아요!
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // 유저 위치를 나타낼때는 기본 파란 그 점 아시죠? 그거 쓰고싶으니까~ 요렇게 해주시고 만약에 쓰고싶은 어노테이션이 있다면 그녀석을 리턴해 주시면 되긋죠? 하하!
            return nil
        }
        //우리가 만들고 싶은 커스텀 어노테이션을 만들어 줍시다. 그냥 뿅 생길 수 없겠죠? 보여주고 싶은 모양을 뷰로 짜준다고 생각하시면 됩니다.
        //즉시 인스턴스로 만들어 줘 보겠습니다요. 어떻게 생겼을지는 아직 안정했지만 일단 커스텀이라는 식별자?를 가진 뷰로 만들어 줬습니다.
        //마커 어노테이션뷰 라는 어노테이션뷰를 상속받는 뷰가 따로있습니다. 풍선모양이라고 하는데 한번 만들어 보시는것도 좋겠네요! 테두리가 있고 안에 내용물을 바꾸는 식으로 설정이 되는듯 해요.
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: "Custom")
        
        if annotationView == nil {
            //없으면 하나 만들어 주시고
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
            annotationView?.canShowCallout = true
            
            
            //callOutView를 통해서 추가적인 액션을 더해줄수도 있겠죠! 와 무지 간편합니다!
            let miniButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            miniButton.setImage(UIImage(systemName: "person"), for: .normal)
            miniButton.tintColor = .blue
            annotationView?.rightCalloutAccessoryView = miniButton
            
        } else {
            //있으면 등록된 걸 쓰시면 됩니다.
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "Circle")
        
        //상황에 따라 다른 annotationView를 리턴하게 하면 여러가지 모양을 쓸 수도 있겠죠?
        
        return annotationView
    }
    
    
    @objc func findSesacLocation() {
        
        mapView.map.showsUserLocation = false
        
        mapView.map.userTrackingMode = .none
        
        mapView.map.setRegion(MKCoordinateRegion(center: sesacCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.11)), animated: true)
    }
    
    @objc func findMyLocation() {
        
        guard let currentLocation = locationManager.location else {
            checkUserLocationServicesAuthorization()
            return
        }
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        print("Current Latitude: \(latitude)")
        print("Current Longitude: \(longitude)")
        getAddress()
        
        mapView.map.showsUserLocation = true
        
        mapView.map.setUserTrackingMode(.follow, animated: true)
        
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
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations[locations.count - 1]
//        let longtitude: CLLocationDegrees = location.coordinate.longitude
//        let latitude:CLLocationDegrees = location.coordinate.latitude
//        
//        print(longtitude)
//        print(latitude)
//
//    }

    func buttonActions() {
        mapView.myLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
        mapView.sesacLocationButton.addTarget(self, action: #selector(findSesacLocation), for: .touchUpInside)
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



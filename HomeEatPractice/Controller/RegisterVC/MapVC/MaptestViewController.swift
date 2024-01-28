//
//  LocationVC.swift

import UIKit
import CoreLocation

class MaptestViewController: UIViewController {
    
    // 주소
    @IBOutlet weak var txtAddress: UILabel!
    // 위도
    @IBOutlet weak var txtLatitude: UILabel!
    // 경도
    @IBOutlet weak var txtLongitude: UILabel!
    
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LocationVC >> viewDidLoad() ")
        
        locationManager.delegate = self  // 델리게이트 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 거리 정확도 설정
        
        checkAuthorizationStatus()
    }
    
    
    /**
     * checkAuthorizationStatus()
     * - 권한 상태 확인하기
     **/
    func checkAuthorizationStatus() {
        
        if #available(iOS 14.0, *) {
            
            if locationManager.authorizationStatus == .authorizedAlways
                || locationManager.authorizationStatus == .authorizedWhenInUse {
                print("==> 위치 서비스 On 상태")
                locationManager.startUpdatingLocation() //위치 정보 받아오기 시작 - 사용자의 현재 위치를 보고하는 업데이트 생성을 시작
            } else if locationManager.authorizationStatus == .notDetermined {
                print("==> 위치 서비스 Off 상태")
                locationManager.requestWhenInUseAuthorization()
            } else if locationManager.authorizationStatus == .denied {
                print("==> 위치 서비스 Deny 상태")
            }
            
        } else {
            
            // Fallback on earlier versions
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                locationManager.startUpdatingLocation() //위치 정보 받아오기 시작 - 사용자의 현재 위치를 보고하는 업데이트 생성을 시작
                print("LocationViewController >> checkPermission() - \(locationManager.location?.coordinate)")
            } else {
                print("위치 서비스 Off 상태")
                locationManager.requestWhenInUseAuthorization()
            }
            
        }
    }
    
    
    /**
     * getAddress()
     * - 현재 위치 주소 가져오기
     **/
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
                        
                        self.txtAddress.text = address
                
                    }
             
                }
            }
        }
}


extension MaptestViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager >> didUpdateLocations 🐥 ")
        
        var longitude = CLLocationDegrees()
        var latitude = CLLocationDegrees()
         
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
            longitude = location.coordinate.latitude
            latitude = location.coordinate.longitude
            
            self.txtLongitude.text = String(longitude)
            self.txtLatitude.text = String(latitude)
        }
        
        getAddress()
        locationManager.stopUpdatingLocation()
       
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("locationManager >> didChangeAuthorization 🐥 ")
        locationManager.startUpdatingLocation()  //위치 정보 받아오기 start
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager >> didFailWithError 🐥 ")
    }
    
}

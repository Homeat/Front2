//
//  MapView.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 1/26/24.
//

import Foundation
import UIKit
import SnapKit
import MapKit

class MapView: UIView{


    let sesacLocationButton = UIButton()
    let myLocationButton = UIButton()
    let map = MKMapView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(map)
        self.addSubview(myLocationButton)
        self.addSubview(sesacLocationButton)
        makeConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func makeConstraints() {
        map.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            
        }
        
    }
    
    
}

//
//  CustomProgressViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/3/24.
//

import Foundation
import UIKit

class CustomProgressViewController: UIViewController {

    var progressBar: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // UIProgressView 초기화 및 설정
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = UIColor(named: "green")
        view.addSubview(progressBar)

        // 프로그레스 바의 레이아웃 설정 (원하는 위치와 크기로 조절)
        progressBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        // (Optional) 초기에 프로그레스 바를 0%로 설정
        progressBar.progress = 0.0
    }

    func updateProgressBar(progress: Float) {
        progressBar.progress = progress
    }

    // 다른 메서드나 프로퍼티 등을 추가할 수 있음

}

//
//  Home.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/02.
//

import Foundation
import UIKit
import Charts
import Then

class HomeViewController: UIViewController {
    private let pieChartView = PieChartView().then {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "Home2")
        return logo
    }()
    
    // 지출추가 버튼
    private let payAddButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 7, g: 231, b: 149)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.setTitle("지출 추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let spacing: CGFloat = 8.0 // 원하는 간격 값으로 조절
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        

        return button
    }()
    
    // 지출확인 버튼
    private let payCheckButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 7, g: 231, b: 149)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .black
        button.setTitle("지출 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let spacing: CGFloat = 8.0 // 원하는 간격 값으로 조절
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)

        
        return button
    }()
    
    // 지출분석 버튼
    private let payAnalyzeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 7, g: 231, b: 149)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setImage(UIImage(systemName: "chart.bar.fill"), for: .normal)
        button.tintColor = .black
        button.setTitle("지출 분석", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let spacing: CGFloat = 8.0 // 원하는 간격 값으로 조절
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        return button
    }()
    
    // 버튼을 포함하는 스택뷰
    private let buttonContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 15
        container.alignment = .center
        container.distribution = .fillEqually
        return container
    }()
    
    // 진행상황 이미지뷰
    private let progressView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let infoLabel1: UILabel = {
        let label = UILabel()
        label.text = "OO 님 훌륭해요!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let infoLabel2: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "저번주보다 8% 절약하고 있어요")
        let stringLength = attributedString.length
        attributedString.addAttributes([.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 18, weight: .bold)], range: NSRange(location: 0, length: 7))
        attributedString.addAttributes([.foregroundColor : UIColor(r: 7, g: 231, b: 149), .font : UIFont.systemFont(ofSize: 18, weight: .bold)], range: NSRange(location: 6, length: 3))
        attributedString.addAttributes([.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 18, weight: .bold)], range: NSRange(location: 9, length: stringLength - 9))
        label.attributedText = attributedString
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gray2")
        setView()
        setConstraints()
        setupPieChart() 
        self.payAddButton.addTarget(self, action: #selector(tabAddButton), for: .touchUpInside)
        self.payCheckButton.addTarget(self, action: #selector(tabCheckButton), for: .touchUpInside)
        self.payAnalyzeButton.addTarget(self, action: #selector(tabAnalyzeButton), for: .touchUpInside)
    }
    
    
    //HomeView가 나타날 때 tabBar 다시 띄우기 및 저장버튼 삭제
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
        
        self.navigationItem.setRightBarButton(nil, animated: false)
    }
    
    func setView() {
        self.view.addSubview(self.buttonContainer)
        self.buttonContainer.addArrangedSubview(self.payAddButton)
        self.buttonContainer.addArrangedSubview(self.payCheckButton)
        self.buttonContainer.addArrangedSubview(self.payAnalyzeButton)
        self.view.addSubview(self.progressView)
        progressView.addSubview(pieChartView)
        self.view.addSubview(self.infoLabel1)
        self.view.addSubview(self.infoLabel2)
        self.view.addSubview(self.logo)
        
        self.buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        self.payAddButton.translatesAutoresizingMaskIntoConstraints = false
        self.payCheckButton.translatesAutoresizingMaskIntoConstraints = false
        self.payAnalyzeButton.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel1.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.logo.translatesAutoresizingMaskIntoConstraints = false
        
    }
    //차트 엔트리 값 설정
    func setupPieChart() {
        
        var entries = [ChartDataEntry]()
        entries.append(PieChartDataEntry(value: 45))
        entries.append(PieChartDataEntry(value: 50))

        let dataSet = PieChartDataSet(entries: entries)
        
        if let customGreenColor = UIColor(named: "green") {
                let otherColor = UIColor.black
                dataSet.colors = [customGreenColor, otherColor]
        }
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false

        let data = PieChartData(dataSet: dataSet)
        pieChartView.holeRadiusPercent = 0.75 // 0%로 설정하면 외곽선이 없어집니다.
        pieChartView.holeColor = UIColor.gray // hole 색을 그레이로 설정

        pieChartView.data = data
        pieChartView.legend.enabled = false

    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            pieChartView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            pieChartView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            pieChartView.heightAnchor.constraint(equalToConstant: 206),
            pieChartView.widthAnchor.constraint(equalToConstant: 206),
                    
        ])
        NSLayoutConstraint.activate([
            self.buttonContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.buttonContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.buttonContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24),
            self.buttonContainer.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 27),
            
            self.payAddButton.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.payAddButton.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            
            self.payCheckButton.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.payCheckButton.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            
            self.payAnalyzeButton.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.payAnalyzeButton.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            
            self.progressView.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: self.buttonContainer.trailingAnchor),
            self.progressView.topAnchor.constraint(equalTo: self.infoLabel2.bottomAnchor, constant: 20),
            self.progressView.heightAnchor.constraint(equalToConstant: 333),
            
            self.infoLabel1.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            self.infoLabel1.heightAnchor.constraint(equalToConstant: 28),
            self.infoLabel1.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 27.1),
            
            self.infoLabel2.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            self.infoLabel2.heightAnchor.constraint(equalToConstant: 21),
            self.infoLabel2.topAnchor.constraint(equalTo: infoLabel1.bottomAnchor, constant: 10),
            
            self.logo.leadingAnchor.constraint(equalTo: self.buttonContainer.leadingAnchor),
            self.logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 72),
            self.logo.heightAnchor.constraint(equalToConstant: 15.9),
            self.logo.widthAnchor.constraint(equalToConstant: 93.5),
            
            
            
        ])
    }
    
    // 지출추가 버튼을 클릭했을 때
    @objc func tabAddButton(_ sender: Any) {
        let nextVC = PayAddViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
            backBarButtonItem.tintColor = .white
            self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    // 지출추가 뷰에서 back 버튼을 눌렀을 때
    @objc func backAddButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // 지출확인 버튼을 클릭했을 때
    @objc func tabCheckButton(_ sender: Any) {
        let nextVC = PayCheckViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
            backBarButtonItem.tintColor = .white
            self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    // 지출확인 뷰에서 back 버튼을 눌렀을 때
    @objc func backCheckButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 지출분석 버튼을 클릭했을 때
    @objc func tabAnalyzeButton(_ sender: Any) {
        let nextVC = self
        self.navigationController?.pushViewController(nextVC, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
            backBarButtonItem.tintColor = .white
            self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // 지출분석 뷰에서 back 버튼을 눌렀을 때
    @objc func backAnalyzeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

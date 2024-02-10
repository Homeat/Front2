//
//  AnalysisViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/01.
//

import UIKit
import Then
import Charts
import SnapKit

class AnalysisViewController: UIViewController {
    internal let barCornerRadius = CGFloat(5.0)
    //스크롤 뷰
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //원 차트
    private let pieChartView = PieChartView().then {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //바 차트
    private let barChartView = BarChartView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
            
    }
    
    //원형 뷰
    private let percentageCircleView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    //원형 뷰
    private let percentageCircleView2 = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    //외식/배달 icon
    private let deliveryIcon = UIImageView().then {
        $0.image = UIImage(named: "Statistics5")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //외식/배달 label
    private let deliveryLabel = UILabel().then {
        $0.text = "외식/배달"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true
        $0.font = UIFont.boldSystemFont(ofSize: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "font6") // 보라색으로 설정
    }
    //집밥 icon
    private let mealIcon = UIImageView().then {
        $0.image = UIImage(named: "Statistics4")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let mealLabel = UILabel().then {
        $0.text = "집밥"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true
        $0.font = UIFont.boldSystemFont(ofSize: 10)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.init(named: "green")
    }
    // 월 분석 뷰
    private let MonthView = UIView().then {
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "searchtf")
    }
    //전 년/ 월
    private let BackIcon = UIImageView().then {
        $0.image = UIImage(named: "Statistics7")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let YearMonthLabel = UILabel().then {
        $0.text = "2023년 11월"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //그 다음 년 /월
    private let NextIcon = UIImageView().then {
        $0.image = UIImage(named: "Statistics6")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "저번달 보다 8% 절약 했어요"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let weakView = UIView().then {
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "searchtf")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "gray2")
        let fullText = label.text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "8%")
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(named: "green"), range: range )
        label.attributedText = attributedString
        addSubviews()
        configUI()
        setupPieChart()
        setupBarChart()
        
    }
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(deliveryIcon)
        contentView.addSubview(deliveryLabel)
        contentView.addSubview(mealIcon)
        contentView.addSubview(mealLabel)
        contentView.addSubview(MonthView)
        MonthView.addSubview(BackIcon)
        MonthView.addSubview(YearMonthLabel)
        MonthView.addSubview(NextIcon)
        MonthView.addSubview(label)
        MonthView.addSubview(pieChartView)
        MonthView.addSubview(barChartView)
        //weakview
        
//        MonthView.addSubview(mealIcon)
//        MonthView.addSubview(deliveryIcon)
        MonthView.addSubview(percentageCircleView)
        MonthView.addSubview(percentageCircleView2)
        contentView.addSubview(weakView)
    }
    func configUI() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 48),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(950)
        }
        NSLayoutConstraint.activate([
            deliveryIcon.widthAnchor.constraint(equalToConstant: 14),
            deliveryIcon.heightAnchor.constraint(equalToConstant: 11),
            deliveryIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            deliveryIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 302),
            
        ])
        NSLayoutConstraint.activate([
            deliveryLabel.widthAnchor.constraint(equalToConstant: 50),
            deliveryLabel.heightAnchor.constraint(equalToConstant: 15),
            deliveryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            deliveryLabel.leadingAnchor.constraint(equalTo: deliveryIcon.trailingAnchor,constant: 6),
            deliveryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -21)
        ])
        NSLayoutConstraint.activate([
            mealIcon.widthAnchor.constraint(equalToConstant: 14),
            mealIcon.heightAnchor.constraint(equalToConstant: 11),
            mealIcon.topAnchor.constraint(equalTo:deliveryIcon.bottomAnchor , constant: 9),
            mealIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 302),
        ])
        NSLayoutConstraint.activate([
            mealLabel.widthAnchor.constraint(equalToConstant: 50),
            mealLabel.heightAnchor.constraint(equalToConstant: 15),
            mealLabel.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor, constant: 4),
            mealLabel.leadingAnchor.constraint(equalTo: deliveryLabel.leadingAnchor),
            mealLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -21),

        ])
        NSLayoutConstraint.activate([
            MonthView.heightAnchor.constraint(equalToConstant: 345),
            MonthView.topAnchor.constraint(equalTo: mealIcon.bottomAnchor, constant: 20),
            MonthView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 19),
            MonthView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -18),
        ])
        NSLayoutConstraint.activate([
            BackIcon.heightAnchor.constraint(equalToConstant: 14.6),
            BackIcon.topAnchor.constraint(equalTo: MonthView.topAnchor, constant: 19),
            BackIcon.trailingAnchor.constraint(equalTo: YearMonthLabel.leadingAnchor,constant: -11)
        ])
        NSLayoutConstraint.activate([
            YearMonthLabel.heightAnchor.constraint(equalToConstant: 26),
            YearMonthLabel.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor),
            YearMonthLabel.topAnchor.constraint(equalTo: MonthView.topAnchor, constant: 12),
            
        ])
        NSLayoutConstraint.activate([
            NextIcon.heightAnchor.constraint(equalToConstant: 14.6),
            NextIcon.topAnchor.constraint(equalTo: MonthView.topAnchor, constant: 19),
            NextIcon.leadingAnchor.constraint(equalTo: YearMonthLabel.trailingAnchor,constant: 11),
            
        ])
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.topAnchor.constraint(equalTo: YearMonthLabel.bottomAnchor, constant: 54),
            label.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            percentageCircleView.heightAnchor.constraint(equalToConstant: 22),
            percentageCircleView.widthAnchor.constraint(equalToConstant: 22),
            percentageCircleView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 73),
            percentageCircleView.leadingAnchor.constraint(equalTo: MonthView.leadingAnchor,constant: 62)
        ])
        NSLayoutConstraint.activate([
            percentageCircleView2.heightAnchor.constraint(equalToConstant: 24),
            percentageCircleView2.widthAnchor.constraint(equalToConstant: 24),
            percentageCircleView2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 85),
            percentageCircleView2.leadingAnchor.constraint(equalTo: MonthView.leadingAnchor,constant: 123)
        ])
        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 24),
            pieChartView.leadingAnchor.constraint(equalTo: MonthView.leadingAnchor,constant: 30),
            pieChartView.heightAnchor.constraint(equalToConstant: 145.5),
            pieChartView.widthAnchor.constraint(equalToConstant: 147.6),
                    
            barChartView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            barChartView.leadingAnchor.constraint(equalTo: pieChartView.trailingAnchor, constant: 20),
            barChartView.trailingAnchor.constraint(equalTo: MonthView.trailingAnchor, constant: -45.7),
            barChartView.bottomAnchor.constraint(equalTo: MonthView.bottomAnchor,constant: -62) // 적절
        ])
//        NSLayoutConstraint.activate([
//            mealIcon.heightAnchor.constraint(equalToConstant: 17.6),
//            mealIcon.widthAnchor.constraint(equalToConstant: 19.1),
//            mealIcon.topAnchor.constraint(equalTo: label.bottomAnchor),
//            mealIcon.leadingAnchor.constraint(equalTo: pieChartView.trailingAnchor,constant: 46.4),
//
//        ])
//        NSLayoutConstraint.activate([
//            deliveryIcon.heightAnchor.constraint(equalToConstant: 17.6),
//            deliveryIcon.widthAnchor.constraint(equalToConstant: 19.1),
//            deliveryIcon.topAnchor.constraint(equalTo: label.bottomAnchor),
//            deliveryIcon.leadingAnchor.constraint(equalTo: pieChartView.trailingAnchor,constant: 91.7),
//        ])
        NSLayoutConstraint.activate([
            weakView.heightAnchor.constraint(equalToConstant: 345),
            weakView.topAnchor.constraint(equalTo: MonthView.bottomAnchor, constant: 95),
            weakView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 19),
            weakView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -18),
        ])
        
        
    }
    func setupPieChart() {
        
        var entries = [ChartDataEntry]()
        entries.append(PieChartDataEntry(value: 75))
        entries.append(PieChartDataEntry(value: 35))

        let dataSet = PieChartDataSet(entries: entries)
        

        if let customGreenColor = UIColor(named: "font6"),
           let otherColor = UIColor(named: "green") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            dataSet.colors = [nsCustomGreenColor, nsOtherColor]
        }
        dataSet.valueTextColor = .white // 레이블 텍스트 색상 설정
        dataSet.valueFont = UIFont.systemFont(ofSize: 12.0) // 레이블 텍스트 폰트 설정
        dataSet.valueLineColor = .black // 레이블 텍스트의 라인 색상 설정
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false

        let data = PieChartData(dataSet: dataSet)
        pieChartView.holeRadiusPercent = 0.66 // 0%로 설정하면 외곽선이 없어집니다.
        pieChartView.holeColor = UIColor.init(named: "searchtf") // hole 색을 그레이로 설정

        pieChartView.data = data
        pieChartView.legend.enabled = false

    }
    func setupBarChart() {
        
        var names = ["집밥", "배달/외식"]
        var barEntries = [BarChartDataEntry]()
        barEntries.append(BarChartDataEntry(x: 0, y: 50))
        barEntries.append(BarChartDataEntry(x: 1, y: 75))

        let barDataSet = BarChartDataSet(entries: barEntries)
        if let customGreenColor = UIColor(named: "green"),
           let otherColor = UIColor(named: "font6") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
        }

        barChartView.drawGridBackgroundEnabled = false
        let barData = BarChartData(dataSet: barDataSet)

        // 바 차트 아래에 레이블 추가
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = .white
        let xAxis = barChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true // 레이블 표시를 가능하게 설정
        xAxis.drawAxisLineEnabled = false
        
        barChartView.leftAxis.gridColor = UIColor.clear
        barChartView.rightAxis.gridColor = UIColor.clear

        let leftYAxis = barChartView.leftYAxisRenderer
        let rightYAxis = barChartView.rightAxis
        rightYAxis.drawGridLinesEnabled = false

        barDataSet.drawValuesEnabled = false
        barDataSet.drawIconsEnabled = false

        barChartView.data = barData
        barChartView.notifyDataSetChanged()
        barChartView.legend.enabled = false
        // 바 차트의 모서리를 둥글게 만듭니다.
        barChartView.layer.cornerRadius = barCornerRadius // 적절한 값을 선택하여 적용합니다.
        barChartView.layer.masksToBounds = true
    }

    
}
extension NSMutableAttributedString {
    func highlightString(_ targetString: String, withColor color: UIColor) {
        // 범위를 찾아서 색상을 변경
        if let range = self.string.range(of: targetString) {
            let nsRange = NSRange(range, in: self.string)
            self.addAttribute(.foregroundColor, value: color, range: nsRange)
        }
    }
}

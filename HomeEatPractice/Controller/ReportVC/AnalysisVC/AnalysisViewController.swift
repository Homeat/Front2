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
import Alamofire

class AnalysisViewController: UIViewController {
    private var currentDate = Date() // 현재 날짜를 가져옴
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
    
    //MARK: -- 월 바 차트
    private let barChartView = BarChartView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
            
    }
    //MARK: -- 집밥 주 바 차트
    private let MealWeekBarChartView = BarChartView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
            
    }
    //MARK: -- 외식/배달 주 바 차트
    private let DeliveryWeekBarChartView = BarChartView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
            
    }
    //원형 뷰
    private let percentageCircleView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 11
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
       
    }
    //퍼센트 레이블
    private let percentageLabel = UILabel().then {
        $0.text = "35%"
        $0.textColor = UIColor.init(named: "searchtf")
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 9)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //원형 뷰
    private let percentageCircleView2 = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
       
    }
    private let percentageLabel2 = UILabel().then {
        $0.text = "75%"
        $0.textColor = UIColor.init(named: "searchtf")
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 10)
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
    private let BackIcon = UIButton().then {
        $0.setImage(UIImage(named: "Statistics7"), for: .normal) // BackIcon 이미지를 버튼 이미지로 설정
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(backIconTapped), for: .touchUpInside) // 버튼이 탭되었을 때 backIconTapped 메서드 호출
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let BackIcon2 = UIButton().then {
        $0.setImage(UIImage(named: "Statistics7"), for: .normal) // BackIcon 이미지를 버튼 이미지로 설정
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(backIcon2Tapped), for: .touchUpInside) // 버튼이 탭되었을 때 backIconTapped 메서드 호출
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let YearMonthLabel = UILabel().then {
        $0.text = "2023년 11월"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let WeakMonthLabel = UILabel().then {
        $0.text = "2023년 11월 둘째 주"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //그 다음 년 /월
    private let NextIcon = UIButton().then {
        $0.setImage(UIImage(named: "Statistics6"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(nextIconTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let NextIcon2 = UIButton().then {
        $0.setImage(UIImage(named: "Statistics6"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(nextIcon2Tapped), for: .touchUpInside)
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
    private let ageButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("20대 초반", for: .normal)
        $0.layer.cornerRadius = 16.3
        $0.clipsToBounds = true
        // 버튼의 원래 border 색상 및 title 색상
        let normalBorderColor = UIColor(named: "green")?.cgColor ?? UIColor.gray.cgColor
        let normalTitleColor = UIColor(named: "green") ?? UIColor.gray
        $0.setTitleColor(normalTitleColor, for: .normal)
        $0.backgroundColor = UIColor(named: "gray4")
        $0.layer.borderColor = normalBorderColor
        $0.layer.borderWidth = 1.6
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
    }
    private let IncomeMoneyButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("소득 100만원 이하", for: .normal)
        $0.layer.cornerRadius = 16.6
        $0.clipsToBounds = true
        // 버튼의 원래 border 색상 및 title 색상
        let normalBorderColor = UIColor(named: "green")?.cgColor ?? UIColor.gray.cgColor
        let normalTitleColor = UIColor(named: "green") ?? UIColor.gray
        $0.setTitleColor(normalTitleColor, for: .normal)
        $0.backgroundColor = UIColor(named: "gray4")
        $0.layer.borderColor = normalBorderColor
        $0.layer.borderWidth = 1.6
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
    }
    private let WeakView = UIView().then {
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "searchtf")
    }
    lazy var genderLabel : UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "소득이 비슷한 또래 여성 대비"
        genderLabel.textColor = .white
        genderLabel.textAlignment = .center
        genderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.numberOfLines = 0
        return genderLabel
    } ()
    lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "집밥은 50,000원을 덜 쓰고,"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // 여러 줄 텍스트 허용
        
        return label
    }()
    lazy var label3: UILabel = {
        let label3 = UILabel()
        label3.text = "외식과 배달은 120,000원을 더 썼어요"
        label3.textColor = .white
        label3.textAlignment = .center
        label3.font = UIFont.boldSystemFont(ofSize: 18)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.numberOfLines = 0
        // "외식과 배달"을 purple로 변경
        let attributedString3 = NSMutableAttributedString(string: label3.text ?? "")
        let range3 = (label3.text as NSString?)?.range(of: "외식과 배달")
        attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "font6"), range: range3 ?? NSRange())
        
        let range4 = (label3.text as NSString?)?.range(of: "120,000원을 더")
        attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "font6"), range: range4 ?? NSRange())
        label3.attributedText = attributedString3
        return label3
    } ()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gray2")
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = String(format: "%02d", calendar.component(.month, from: currentDate))
        let day = calendar.component(.day,from: currentDate)
        
        addSubviews()
        configUI()
        updateYearMonthLabel()
        updateWeakMonthLabel()
        fetchDataFromServer(year: String(year), month: String(month))
        fetchAverageDataFromServer(year: String(year), month: String(month),day: String(day))
        print(String(year))
        print(String(month))
        
    }
    func fetchDataFromServer(year: String, month: String) {
        let url = "https://dev.homeat.site/v1/homeatReport/ofMonth"
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            loginToken = token
        } else {
            print("토큰이 없습니다.")
            return // 토큰이 없으면 요청을 보낼 수 없으므로 함수 종료
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        let parameters: [String: String] = [
            "input_year": year,
            "input_month": month
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { [weak self]
            response in
            switch response.result {
            case .success(let value):
                // 서버로부터 데이터 성공적으로 받음
                if let json = value as? [String: Any], let data = json["data"] as? [String: Any] {
                    // 응답 데이터에서 필요한 정보를 추출하여 처리
                    if let jipbapPrice = data["month_jipbap_price"] as? Int,
                       let outPrice = data["month_out_price"] as? Int,
                       let jipbapRatio = data["jipbap_ratio"] as? Double,
                       let outRatio = data["out_ratio"] as? Double,
                       let savePercent = data["save_percent"] as? String {
                        // 데이터 처리 로직 추가
                        print("집밥 가격: \(jipbapPrice)")
                        print("외식/배달 가격: \(outPrice)")
                        print("집밥 비율: \(jipbapRatio)")
                        print("외식/배달 비율: \(outRatio)")
                        print("절약 비율: \(savePercent)")
                        self?.percentageLabel.text = "\(jipbapRatio) %"
                        self?.percentageLabel2.text = "\(outRatio) %"
                        self?.setupPieChart(jipbapRatio: jipbapRatio, outRatio: outRatio)
                        self?.setupBarChart(jipbapPrice: jipbapPrice, outPrice: outPrice)
                        
                        if let savePercentage = Double(savePercent) {
                            var text = ""
                            if savePercentage >= 0 {
                                text = String(format: "저번달 보다 %.0f%% 절약했어요", savePercentage)
                            } else {
                                text = String(format: "저번달 보다 %.0f%%  추가지출 했어요", abs(savePercentage))
                            }
                            
                            // NSMutableAttributedString으로 문자열을 생성
                            let attributedText = NSMutableAttributedString(string: text)
                            
                            // 텍스트에서 %.0f%%를 찾아서 색상을 변경
                            let range = (text as NSString).range(of: String(format: "%.0f%%", abs(savePercentage)))
                            attributedText.addAttribute(.foregroundColor, value: UIColor(named: "green"), range: range)
                            
                            // Label에 적용
                            self?.label.attributedText = attributedText
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
                // 요청이 실패한 경우에 대한 처리
            }
        }
    }
    
    //하단 뷰 서버에서 데이터 받아오기
    func fetchAverageDataFromServer(year: String,month: String,day: String) {
        let url = "https://dev.homeat.site/v1/homeatReport/ofWeek"
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            loginToken = token
        } else {
            print("토큰이 없습니다.")
            return // 토큰이 없으면 요청을 보낼 수 없으므로 함수 종료
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        let parameters: [String: String] = [
            "input_year": year,
            "input_month": month,
            "input_day": day,
        ]
        // Alamofire를 사용하여 서버에 요청을 보냄
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            // 요청에 대한 응답 처리
            switch response.result {
            case .success(let value):
                // 성공적으로 데이터를 받아온 경우
                print("Success: \(value)")
                
                // 데이터 처리
                if let json = value as? [String: Any], let data = json["data"] as? [String: Any] {
                    // 데이터 파싱
                    if let ageRange = data["age_range"] as? String, //나이 범위
                       let income = data["income"] as? String,
                       let gender = data["gender"] as? String,
                       let nickname = data["nickname"] as? String,
                       let jipbapSave = data["jipbap_save"] as? Int,
                       let outSave = data["out_save"] as? Int,
                       let jipbapAverage = data["jipbap_average"] as? Int,
                       let weekJipbapPrice = data["week_jipbap_price"] as? Int,
                       let outAverage = data["out_average"] as? Int,
                       let weekOutPrice = data["week_out_price"] as? Int {
                        // 데이터 사용 예시
                        print("Age Range: \(ageRange)")
                        print("Income: \(income)")
                        print("Gender: \(gender)")
                        print("Nickname: \(nickname)")
                        print("Jipbap Save: \(jipbapSave)")
                        print("Out Save: \(outSave)")
                        print("Jipbap Average: \(jipbapAverage)")
                        print("Week Jipbap Price: \(weekJipbapPrice)")
                        print("Out Average: \(outAverage)")
                        print("Week Out Price: \(weekOutPrice)")
                       // ageButton의 title 업데이트
                        DispatchQueue.main.async {
                            self.ageButton.setTitle(ageRange, for: .normal)
                            self.IncomeMoneyButton.setTitle(income, for: .normal)
                            self.genderLabel.text = "소득이 비슷한 또래 \(gender) 대비"
                            
                            if jipbapSave < 0 {
                                // 음수인 경우 "더" 사용
                                self.label2.text = "집밥은 \(abs(jipbapSave))원을 더 쓰고,"
                            } else {
                                // 양수인 경우 "덜" 사용
                                self.label2.text = "집밥은 \(jipbapSave)원을 덜 쓰고,"
                            }
                            
                            let attributedString2 = NSMutableAttributedString(string: self.label2.text ?? "")
                            // "집밥"을 green으로 변경
                            let range1 = (self.label2.text as NSString?)?.range(of: "집밥")
                            attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "green"), range: range1 ?? NSRange())
                            
                            let range2 = (self.label2.text as NSString?)?.range(of: "\(jipbapSave)원을 덜")
                            attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "green"), range: range2 ?? NSRange())
                            self.label2.attributedText = attributedString2
                            
                            // outSave를 이용하여 label3 업데이트
                            if outSave < 0 {
                                // 음수인 경우 "덜" 사용
                                self.label3.text = "외식과 배달은 \(abs(outSave))원을 덜 썼어요"
                            } else {
                                // 양수인 경우 "더" 사용
                                self.label3.text = "외식과 배달은 \(outSave)원을 더 썼어요"
                            }
                            
                            // "외식과 배달"을 purple로 변경
                            let attributedString3 = NSMutableAttributedString(string: self.label3.text ?? "")
                            let range3 = (self.label3.text as NSString?)?.range(of: "외식과 배달")
                            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "font6"), range: range3 ?? NSRange())
                            
                            let range4 = (self.label3.text as NSString?)?.range(of: "\(outSave)원을 더")
                            attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "font6"), range: range4 ?? NSRange())
                            self.label3.attributedText = attributedString3
                            
                            self.setupMealWeekBarChart(jipbapAverage: jipbapAverage, weekJipbapPrice: weekJipbapPrice) //집밥 평균과 현재 나의 주 소비 바 차트 불러오기
                            self.setupDeliveryWeekBarChart(outAverage: outAverage, weekOutPrice: weekOutPrice)
                        }
                    }
                }
            case .failure(let error):
                // 요청이 실패한 경우
                print("Error: \(error)")
                // 에러 처리 로직 추가
            }
        }
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
//        MonthView.addSubview(percentageCircleView)
//        percentageCircleView.addSubview(percentageLabel)
//        MonthView.addSubview(percentageCircleView2)
//        percentageCircleView2.addSubview(percentageLabel2)
        contentView.addSubview(ageButton)
        contentView.addSubview(IncomeMoneyButton)
        contentView.addSubview(WeakView)
        WeakView.addSubview(BackIcon2)
        WeakView.addSubview(WeakMonthLabel)
        WeakView.addSubview(MealWeekBarChartView)
        WeakView.addSubview(DeliveryWeekBarChartView)
        WeakView.addSubview(genderLabel)
        WeakView.addSubview(label2)
        WeakView.addSubview(label3)
        WeakView.addSubview(NextIcon2)
        
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
            make.height.equalTo(1130)
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
            label.topAnchor.constraint(equalTo: YearMonthLabel.bottomAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor),
            label3.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor)
        ])
//        NSLayoutConstraint.activate([
//            percentageCircleView.heightAnchor.constraint(equalToConstant: 23),
//            percentageCircleView.widthAnchor.constraint(equalToConstant: 23),
//            percentageCircleView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 77),
//            percentageCircleView.leadingAnchor.constraint(equalTo: MonthView.leadingAnchor,constant: 62)
//        ])
//        NSLayoutConstraint.activate([
//            percentageLabel.heightAnchor.constraint(equalToConstant: 14),
//            percentageLabel.centerYAnchor.constraint(equalTo: percentageCircleView.centerYAnchor),
//            percentageLabel.centerXAnchor.constraint(equalTo: percentageCircleView.centerXAnchor)
//        ])
//        NSLayoutConstraint.activate([
//            percentageCircleView2.heightAnchor.constraint(equalToConstant: 28),
//            percentageCircleView2.widthAnchor.constraint(equalToConstant: 28),
//            percentageCircleView2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 87),
//            percentageCircleView2.leadingAnchor.constraint(equalTo: MonthView.leadingAnchor,constant: 116)
//        ])
//        NSLayoutConstraint.activate([
//            percentageLabel2.centerYAnchor.constraint(equalTo: percentageCircleView2.centerYAnchor),
//            percentageLabel2.centerXAnchor.constraint(equalTo: percentageCircleView2.centerXAnchor)
//        ])

        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 28),
            pieChartView.leadingAnchor.constraint(equalTo: MonthView.leadingAnchor,constant: 30),
            pieChartView.heightAnchor.constraint(equalToConstant: 145.5),
            pieChartView.widthAnchor.constraint(equalToConstant: 147.6),
                    
            barChartView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            barChartView.leadingAnchor.constraint(equalTo: pieChartView.trailingAnchor, constant: 20),
            barChartView.trailingAnchor.constraint(equalTo: MonthView.trailingAnchor, constant: -45.7),
            barChartView.bottomAnchor.constraint(equalTo: MonthView.bottomAnchor,constant: -30) // 적절
        ])
        NSLayoutConstraint.activate([
            ageButton.topAnchor.constraint(equalTo: MonthView.bottomAnchor,constant: 46),
            ageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 21),
            ageButton.widthAnchor.constraint(equalToConstant: 81.7),
            ageButton.heightAnchor.constraint(equalToConstant: 31.1)
            ])
        NSLayoutConstraint.activate([
            IncomeMoneyButton.topAnchor.constraint(equalTo: MonthView.bottomAnchor,constant: 46),
            IncomeMoneyButton.leadingAnchor.constraint(equalTo: ageButton.trailingAnchor,constant: 11.7),
            IncomeMoneyButton.widthAnchor.constraint(equalToConstant: 120.6),
            IncomeMoneyButton.heightAnchor.constraint(equalToConstant: 31.1)
        ])
        NSLayoutConstraint.activate([
            WeakView.heightAnchor.constraint(equalToConstant: 570),
            WeakView.topAnchor.constraint(equalTo: ageButton.bottomAnchor, constant: 18.9),
            WeakView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 19),
            WeakView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -18),
            
            MealWeekBarChartView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 40),
            MealWeekBarChartView.heightAnchor.constraint(equalToConstant: 125),
            MealWeekBarChartView.leadingAnchor.constraint(equalTo: WeakView.leadingAnchor,constant: 100),
            MealWeekBarChartView.trailingAnchor.constraint(equalTo: WeakView.trailingAnchor,constant: -100),
            
            DeliveryWeekBarChartView.topAnchor.constraint(equalTo: MealWeekBarChartView.bottomAnchor,constant: 40),
            DeliveryWeekBarChartView.leadingAnchor.constraint(equalTo: WeakView.leadingAnchor,constant: 100),
            DeliveryWeekBarChartView.trailingAnchor.constraint(equalTo: WeakView.trailingAnchor,constant: -100),
            DeliveryWeekBarChartView.heightAnchor.constraint(equalToConstant: 125),
            
        ])
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: WeakMonthLabel.bottomAnchor, constant:30),
            genderLabel.centerXAnchor.constraint(equalTo: WeakView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: genderLabel.bottomAnchor),
            label2.centerXAnchor.constraint(equalTo: WeakView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            BackIcon2.heightAnchor.constraint(equalToConstant: 14.6),
            BackIcon2.topAnchor.constraint(equalTo: WeakView.topAnchor, constant: 19),
            BackIcon2.trailingAnchor.constraint(equalTo: WeakMonthLabel.leadingAnchor,constant: -11)
        ])
        NSLayoutConstraint.activate([
            WeakMonthLabel.heightAnchor.constraint(equalToConstant: 26),
            WeakMonthLabel.centerXAnchor.constraint(equalTo: WeakView.centerXAnchor),
            WeakMonthLabel.topAnchor.constraint(equalTo: WeakView.topAnchor, constant: 12),
            
        ])
        NSLayoutConstraint.activate([
            NextIcon2.heightAnchor.constraint(equalToConstant: 14.6),
            NextIcon2.topAnchor.constraint(equalTo: WeakView.topAnchor, constant: 19),
            NextIcon2.leadingAnchor.constraint(equalTo: WeakMonthLabel.trailingAnchor,constant: 11),
            
        ])
        
        
    }
    //MARK: - 파이차트 셋업
    func setupPieChart(jipbapRatio: Double, outRatio: Double) {
        var entries = [ChartDataEntry]()
        
        // 배달/외식
        entries.append(PieChartDataEntry(value: outRatio))
        // 집밥
        entries.append(PieChartDataEntry(value: jipbapRatio))

        let dataSet = PieChartDataSet(entries: entries)
        
        if let customGreenColor = UIColor(named: "font6"),
           let otherColor = UIColor(named: "green") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsWhiteColor = NSUIColor.black
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            dataSet.colors = [nsCustomGreenColor, nsOtherColor]
            dataSet.valueColors = [nsWhiteColor, nsWhiteColor] // 텍스트 색상 설정
        }
        dataSet.valueTextColor = .black // 레이블 텍스트 색상 설정
        dataSet.valueFont = UIFont.systemFont(ofSize: 11.0) // 레이블 텍스트 폰트 설정
        dataSet.valueLineColor = .black // 레이블 텍스트의 라인 색상 설정
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.drawValuesEnabled = true // 레이블 표시 설정
        dataSet.drawIconsEnabled = false

        let data = PieChartData(dataSet: dataSet)
        pieChartView.holeRadiusPercent = 0.6 // 0%로 설정하면 외곽선이 없어집니다.
        pieChartView.holeColor = UIColor.init(named: "searchtf") // hole 색을 그레이로 설정

        pieChartView.data = data
        pieChartView.legend.enabled = false
        
        // Label의 배경색 설정
    }

    func updateWeakMonthLabel() {
        let calendar = Calendar.current
        let weekOfMonth = calendar.component(.weekOfMonth, from: currentDate)
        var weekLabel = ""
        
        switch weekOfMonth {
        case 1:
            weekLabel = "첫째 주"
        case 2:
            weekLabel = "둘째 주"
        case 3:
            weekLabel = "셋째 주"
        case 4:
            weekLabel = "넷째 주"
        case 5:
            weekLabel = "다섯째 주"
        default:
            weekLabel = ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        let formattedDate = formatter.string(from: currentDate)
        
        WeakMonthLabel.text = "\(formattedDate) \(weekLabel)"
    }
    func setupBarChart(jipbapPrice: Int, outPrice: Int) {
        var names = ["집밥", "배달/외식"]
        
        var barEntries = [BarChartDataEntry]()
        
        barEntries.append(BarChartDataEntry(x: 0, y: Double(jipbapPrice), icon: UIImage(named: "Statistics3")))
           barEntries.append(BarChartDataEntry(x: 1, y: Double(outPrice), icon: UIImage(named: "Statistics1")))
        let barDataSet = BarChartDataSet(entries: barEntries)
        if let customGreenColor = UIColor(named: "green"),
           let otherColor = UIColor(named: "font6") {
            let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
            let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
            barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
        }
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // 레이블 폰트 크기를 축소
        barChartView.drawGridBackgroundEnabled = false
        let barData = BarChartData(dataSet: barDataSet)
        barChartView.xAxis.labelCount = names.count // 레이블 갯수 설정
        barChartView.xAxis.spaceMin = 0.5 // 최소 간격 설정
        barChartView.xAxis.spaceMax = 0.5 // 최대 간격 설정

        // 바 차트 아래에 레이블 추가
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = .white
        let xAxis = barChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true // 레이블 표시를 가능하게 설정
        xAxis.drawAxisLineEnabled = false

        barChartView.leftAxis.drawLabelsEnabled = false // leftYAxis 레이블 숨김
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false // rightYAxis 숨김

        barChartView.leftAxis.gridColor = UIColor.clear
        barChartView.rightAxis.gridColor = UIColor.clear

        barDataSet.drawValuesEnabled = false
        barDataSet.drawIconsEnabled = true // 아이콘 표시 활성화
        barData.barWidth = 0.55 // 막대의 너비를 0.5로 설정하여 줄임
        barChartView.data = barData
        barChartView.notifyDataSetChanged()
        barChartView.legend.enabled = false
        }
    func setupMealWeekBarChart(jipbapAverage: Int,weekJipbapPrice: Int) {
        if let name = UserDefaults.standard.string(forKey: "userNickname") {
            let nameWithSuffix = "\(name) 님" // 닉네임 뒤에 "님"을 붙임
            
            var names = ["집밥 평균", nameWithSuffix]
            
            var barEntries = [BarChartDataEntry]()
            
            barEntries.append(BarChartDataEntry(x: 0, y: Double(jipbapAverage)))
            barEntries.append(BarChartDataEntry(x: 1, y: Double(weekJipbapPrice)))
            let barDataSet = BarChartDataSet(entries: barEntries)
            if let customGreenColor = UIColor(named: "font5"),
               let otherColor = UIColor(named: "green") {
                let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
                let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
                barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
            }
            MealWeekBarChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // 레이블 폰트 크기를 축소
            MealWeekBarChartView.drawGridBackgroundEnabled = false
            let barData = BarChartData(dataSet: barDataSet)
            MealWeekBarChartView.xAxis.labelCount = names.count // 레이블 갯수 설정
            MealWeekBarChartView.xAxis.spaceMin = 0.5 // 최소 간격 설정
            MealWeekBarChartView.xAxis.spaceMax = 0.5 // 최대 간격 설정

            // 바 차트 아래에 레이블 추가
            MealWeekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
            MealWeekBarChartView.xAxis.labelPosition = .bottom
            MealWeekBarChartView.xAxis.labelTextColor = .white
            let xAxis = MealWeekBarChartView.xAxis
            xAxis.drawGridLinesEnabled = false
            xAxis.drawLabelsEnabled = true // 레이블 표시를 가능하게 설정
            xAxis.drawAxisLineEnabled = false

            MealWeekBarChartView.leftAxis.drawLabelsEnabled = false // leftYAxis 레이블 숨김
            MealWeekBarChartView.leftAxis.enabled = false
            MealWeekBarChartView.rightAxis.enabled = false // rightYAxis 숨김

            MealWeekBarChartView.leftAxis.gridColor = UIColor.clear
            MealWeekBarChartView.rightAxis.gridColor = UIColor.clear

            barDataSet.drawValuesEnabled = false
            barDataSet.drawIconsEnabled = true // 아이콘 표시 활성화
            barData.barWidth = 0.7 // 막대의 너비를 0.5로 설정하여 줄임
            MealWeekBarChartView.data = barData
            MealWeekBarChartView.notifyDataSetChanged()
            MealWeekBarChartView.legend.enabled = false
        } else {
            print("사용자 닉네임이 없습니다.")
        }
    }

    
    func setupDeliveryWeekBarChart(outAverage: Int,weekOutPrice: Int) {
        if let name = UserDefaults.standard.string(forKey: "userNickname") {
            let nameWithSuffix = "\(name) 님" // 닉네임 뒤에 "님"을 붙임
            var names = ["외식/배달 평균", nameWithSuffix]
            
            var barEntries = [BarChartDataEntry]()
            
            barEntries.append(BarChartDataEntry(x: 0, y: Double(35)))
            barEntries.append(BarChartDataEntry(x: 1, y: Double(75)))
            let barDataSet = BarChartDataSet(entries: barEntries)
            if let customGreenColor = UIColor(named: "font5"),
               let otherColor = UIColor(named: "font6") {
                let nsCustomGreenColor = NSUIColor(cgColor: customGreenColor.cgColor)
                let nsOtherColor = NSUIColor(cgColor: otherColor.cgColor)
                barDataSet.colors = [nsCustomGreenColor, nsOtherColor]
            }
            DeliveryWeekBarChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // 레이블 폰트 크기를 축소
            DeliveryWeekBarChartView.drawGridBackgroundEnabled = false
            let barData = BarChartData(dataSet: barDataSet)
            DeliveryWeekBarChartView.xAxis.labelCount = names.count // 레이블 갯수 설정
            DeliveryWeekBarChartView.xAxis.spaceMin = 0.5 // 최소 간격 설정
            DeliveryWeekBarChartView.xAxis.spaceMax = 0.5 // 최대 간격 설정
            
            // 바 차트 아래에 레이블 추가
            DeliveryWeekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
            DeliveryWeekBarChartView.xAxis.labelPosition = .bottom
            DeliveryWeekBarChartView.xAxis.labelTextColor = .white
            let xAxis = DeliveryWeekBarChartView.xAxis
            xAxis.drawGridLinesEnabled = false
            xAxis.drawLabelsEnabled = true // 레이블 표시를 가능하게 설정
            xAxis.drawAxisLineEnabled = false
            
            DeliveryWeekBarChartView.leftAxis.drawLabelsEnabled = false // leftYAxis 레이블 숨김
            DeliveryWeekBarChartView.leftAxis.enabled = false
            DeliveryWeekBarChartView.rightAxis.enabled = false // rightYAxis 숨김
            
            DeliveryWeekBarChartView.leftAxis.gridColor = UIColor.clear
            DeliveryWeekBarChartView.rightAxis.gridColor = UIColor.clear
            
            barDataSet.drawValuesEnabled = false
            barDataSet.drawIconsEnabled = true // 아이콘 표시 활성화
            barData.barWidth = 0.7 // 막대의 너비를 0.5로 설정하여 줄임
            DeliveryWeekBarChartView.data = barData
            DeliveryWeekBarChartView.notifyDataSetChanged()
            DeliveryWeekBarChartView.legend.enabled = false
        }else {
            print("사용자 닉네임이 없습니다.")
        }
        }
    // BackIcon을 눌렀을 때 호출되는 함수
    @objc private func backIconTapped() {
        // 현재 월을 1 감소시킴
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? Date()
        // YearMonthLabel 업데이트
        updateYearMonthLabel()
    }
    @objc private func backIcon2Tapped() {
        // 현재 날짜를 한 주(7일) 이전으로 설정
        currentDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) ?? Date()
        
        // YearMonthLabel 및 WeakMonthLabel 업데이트
        //updateYearMonthLabel()
        updateWeakMonthLabel()
    }
    @objc private func nextIconTapped() {
        currentDate = Calendar.current.date(byAdding: .month, value: +1, to: currentDate) ?? Date()
        updateYearMonthLabel()
    }
    @objc private func nextIcon2Tapped() {
        currentDate = Calendar.current.date(byAdding: .day, value: +7, to: currentDate) ?? Date()
        //updateYearMonthLabel()
        updateWeakMonthLabel()
    }

    // YearMonthLabel을 업데이트하는 함수
    private func updateYearMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        let formattedDate = formatter.string(from: currentDate)
        YearMonthLabel.text = formattedDate
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

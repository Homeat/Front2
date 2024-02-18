//
//  CalendarCheckViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/20.
//

import UIKit
import Alamofire
final class CalendarCheckViewController: UIViewController {
    private var selectedIndexPath: IndexPath?
    private var currentDate = Date() // 현재 날짜를 가져옴
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var previousButton = UIButton()
    private lazy var nextButton = UIButton()
    private lazy var todayButton = UIButton()
    private lazy var weekStackView = UIStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    private let guideImage1: UIImageView = {
           let image = UIImageView()
           image.image = UIImage(named: "Calender1")
           image.translatesAutoresizingMaskIntoConstraints = false
           return image
       }()
       
    private let guideImage2: UIImageView = {
           let image = UIImageView()
           image.image = UIImage(named: "Calender3")
           image.translatesAutoresizingMaskIntoConstraints = false
           return image
       }()
    private let guidelabel1: UILabel = {
           let label = UILabel()
           label.text = "외식/배달"
           label.font = .systemFont(ofSize: 10, weight: .bold)
           label.textColor = UIColor(r: 30, g: 32, b: 33)
           label.textAlignment = .center
           label.layer.cornerRadius = 2
           label.clipsToBounds = true
           label.backgroundColor = UIColor(r: 157, g: 110, b: 255)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    private let circleView = UIImageView().then {
           let circleSize: CGFloat = 16
           $0.frame.size = CGSize(width: circleSize, height: circleSize)
           $0.backgroundColor = UIColor(named: "gray2")
           $0.layer.cornerRadius = circleSize / 2
           $0.clipsToBounds = true
           $0.translatesAutoresizingMaskIntoConstraints = false
       }
       private let circleView2 = UIImageView().then {
           let circleSize: CGFloat = 16
           $0.frame.size = CGSize(width: circleSize, height: circleSize)
           $0.backgroundColor = UIColor(named: "gray2")
           $0.layer.cornerRadius = circleSize / 2
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
    private let DayLabel = UILabel().then {
            $0.text = "11월 1일 수요일"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = UIFont.boldSystemFont(ofSize: 15)
        }
    //집밥 icon
    private let mealIcon = UIImageView().then {
        $0.image = UIImage(named: "Calendar5")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //배달/외식 icon
    private let deliveryIcon = UIImageView().then {
        $0.image = UIImage(named: "Calendar6")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private lazy var mealVerticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "green")
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var mealLabel2 = UILabel().then {
        $0.text = "집밥"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private lazy var deliveryLabel2 = UILabel().then {
        $0.text = "배달/외식"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var deliveryVerticalView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "font6")
            view.layer.cornerRadius = 3
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    private lazy var mealCoin = UILabel().then {
        $0.text = "23,800 원"
        $0.textColor = UIColor.init(named: "green")
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private lazy var deliveryCoin = UILabel().then {
        $0.text = "79,800 원"
        $0.textColor = UIColor.init(named: "font6")
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private lazy var remainMoneyCoin = UILabel().then {
            $0.text = "350,000 원"
            $0.textColor = UIColor.white
            $0.textAlignment = .center
            $0.font = UIFont.boldSystemFont(ofSize: 15)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    private let remainMoneyIcon = UIImageView().then {
        $0.image = UIImage(named: "Calendar4")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var remainVerticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "searchfont")
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var remainMoneyLabel = UILabel().then {
           $0.text = "남은 금액"
           $0.textColor = .white
           $0.textAlignment = .center
           $0.font = UIFont.boldSystemFont(ofSize: 15)
           $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        fetchData()
        self.view.backgroundColor =  UIColor(named: "gray3")
        self.contentView.addSubview(self.guideImage1)
        self.contentView.addSubview(self.guideImage2)
        self.contentView.addSubview(self.guidelabel1)
        self.contentView.addSubview(self.mealLabel)
        self.contentView.addSubview(deliveryLabel2)
        self.contentView.addSubview(DayLabel)
        self.contentView.addSubview(mealIcon)
        self.contentView.addSubview(mealVerticalView)
        self.contentView.addSubview(mealLabel2)
        self.contentView.addSubview(mealCoin)
        self.contentView.addSubview(deliveryIcon)
        self.contentView.addSubview(deliveryVerticalView)
        self.contentView.addSubview(deliveryLabel2)
        self.contentView.addSubview(deliveryCoin)
        self.contentView.addSubview(remainMoneyIcon)
        self.contentView.addSubview(remainVerticalView)
        self.contentView.addSubview(remainMoneyLabel)
        self.contentView.addSubview(remainMoneyCoin)
        updateDayLabel()
        navigationcontrol()
        self.configure()
        configUI()
    }
    // 데이터를 가져오는 함수
    func fetchData(year: String, month: String, day: String) {
        let urlString = "https://dev.homeat.site/v1/home/calendar/daily"
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            loginToken = token
        } else {
            print("토큰이 없습니다.")
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        
        let parameters: Parameters = [
            "year": year,
            "month": month,
            "day": day
        ]

        AF.request(urlString, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let data = json["data"] as? [String: Any] {
                    if let todayJipbapPrice = data["todayJipbapPrice"] as? Int,
                       let todayOutPrice = data["todayOutPrice"] as? Int,
                       let remainingGoal = data["remainingGoal"] as? Int {
                        // 데이터를 사용하여 UI 업데이트 등의 작업 수행
                        print("Today Jipbap Price: \(todayJipbapPrice)")
                        print("Today Out Price: \(todayOutPrice)")
                        print("Remaining Goal: \(remainingGoal)")
                        // mealCoin, deliveryCoin, remainMoneyCoin 레이블 업데이트
                        self.mealCoin.text = "\(todayJipbapPrice) 원"
                        self.deliveryCoin.text = "\(todayOutPrice) 원"
                        self.remainMoneyCoin.text = "\(remainingGoal) 원"
                    }
                }
            case .failure(let error):
                // 데이터 요청 실패 시 에러 처리
                print("Error: \(error)")
            }
        }
    }
    private func updateDayLabel() {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM월 dd일 EEEE" // 월/일/요일 형식으로 포맷 지정
            let formattedDate = formatter.string(from: currentDate)
            DayLabel.text = formattedDate
            DayLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    //네비게이션 바 설정
    func navigationcontrol() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "지출확인"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    func configUI() {
        NSLayoutConstraint.activate([
           self.guidelabel1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
           self.guidelabel1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
           self.guidelabel1.heightAnchor.constraint(equalToConstant: 15),
           
           self.guideImage1.topAnchor.constraint(equalTo: self.guidelabel1.topAnchor),
           self.guideImage1.heightAnchor.constraint(equalToConstant: 12),
           self.guideImage1.widthAnchor.constraint(equalToConstant: 14),
           self.guideImage1.trailingAnchor.constraint(equalTo: self.guidelabel1.leadingAnchor, constant: -6)
       ])
       NSLayoutConstraint.activate([
           mealLabel.widthAnchor.constraint(equalToConstant: 50),
           mealLabel.heightAnchor.constraint(equalToConstant: 15),
           mealLabel.topAnchor.constraint(equalTo: guidelabel1.bottomAnchor, constant: 4),
           mealLabel.leadingAnchor.constraint(equalTo: guidelabel1.leadingAnchor),
           mealLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -21),

       ])
       NSLayoutConstraint.activate([
           
           self.guideImage2.topAnchor.constraint(equalTo: self.mealLabel.topAnchor),
           self.guideImage2.heightAnchor.constraint(equalToConstant: 13),
           self.guideImage2.widthAnchor.constraint(equalToConstant: 12),
           self.guideImage2.trailingAnchor.constraint(equalTo: self.guideImage1.trailingAnchor)
       ])
        NSLayoutConstraint.activate([
            DayLabel.heightAnchor.constraint(equalToConstant: 22),
            DayLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            DayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 19),
        ])
        NSLayoutConstraint.activate([
            mealIcon.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            mealIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            mealIcon.heightAnchor.constraint(equalToConstant: 12),
            mealIcon.widthAnchor.constraint(equalToConstant: 13),
        ])
        NSLayoutConstraint.activate([
            mealVerticalView.leadingAnchor.constraint(equalTo: mealIcon.trailingAnchor,constant: 7),
            mealVerticalView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            mealVerticalView.widthAnchor.constraint(equalToConstant: 4),
            mealVerticalView.heightAnchor.constraint(equalToConstant: 18),
        ])
        NSLayoutConstraint.activate([
            mealLabel2.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            mealLabel2.bottomAnchor.constraint(equalTo: mealVerticalView.bottomAnchor),
            mealLabel2.leadingAnchor.constraint(equalTo: mealVerticalView.trailingAnchor,constant: 7),
        ])
        NSLayoutConstraint.activate([
            mealCoin.topAnchor.constraint(equalTo: mealLabel2.topAnchor),
            mealCoin.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -22),
            mealCoin.heightAnchor.constraint(equalToConstant: 13),
            mealCoin.widthAnchor.constraint(equalToConstant: 73),
        ])
        NSLayoutConstraint.activate([
            deliveryIcon.bottomAnchor.constraint(equalTo: deliveryVerticalView.bottomAnchor),
            deliveryIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            deliveryIcon.heightAnchor.constraint(equalToConstant: 15),
            deliveryIcon.widthAnchor.constraint(equalToConstant: 14),
        ])
        NSLayoutConstraint.activate([
            deliveryVerticalView.leadingAnchor.constraint(equalTo: deliveryIcon.trailingAnchor,constant: 7),
            deliveryVerticalView.topAnchor.constraint(equalTo: self.mealVerticalView.bottomAnchor, constant: 10),
            deliveryVerticalView.widthAnchor.constraint(equalToConstant: 4),
            deliveryVerticalView.heightAnchor.constraint(equalToConstant: 18),
        ])
        NSLayoutConstraint.activate([
            deliveryLabel2.heightAnchor.constraint(equalToConstant: 20),
            deliveryLabel2.bottomAnchor.constraint(equalTo: deliveryVerticalView.bottomAnchor),
            deliveryLabel2.leadingAnchor.constraint(equalTo: mealLabel2.leadingAnchor),
        ])
        NSLayoutConstraint.activate([
            deliveryCoin.bottomAnchor.constraint(equalTo: deliveryLabel2.bottomAnchor,constant: -3),
            deliveryCoin.trailingAnchor.constraint(equalTo: mealCoin.trailingAnchor),
            deliveryCoin.heightAnchor.constraint(equalToConstant: 13),
        ])
        NSLayoutConstraint.activate([
            //remainMoneyIcon.topAnchor.constraint(equalTo: deliveryIcon.bottomAnchor, constant: 10),
            remainMoneyIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            remainMoneyIcon.bottomAnchor.constraint(equalTo: remainVerticalView.bottomAnchor),
            remainMoneyIcon.widthAnchor.constraint(equalToConstant: 14.5),
        ])
        NSLayoutConstraint.activate([
            remainVerticalView.topAnchor.constraint(equalTo: deliveryVerticalView.bottomAnchor, constant: 10),
            remainVerticalView.leadingAnchor.constraint(equalTo: remainMoneyIcon.trailingAnchor,constant: 7),
            remainVerticalView.heightAnchor.constraint(equalToConstant: 18),
            remainVerticalView.widthAnchor.constraint(equalToConstant: 4),
        ])
        NSLayoutConstraint.activate([
            remainMoneyLabel.bottomAnchor.constraint(equalTo: remainVerticalView.bottomAnchor),
            remainMoneyLabel.leadingAnchor.constraint(equalTo: remainVerticalView.trailingAnchor, constant: 7),
            remainMoneyLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        NSLayoutConstraint.activate([
            remainMoneyCoin.bottomAnchor.constraint(equalTo: remainMoneyLabel.bottomAnchor),
            remainMoneyCoin.trailingAnchor.constraint(equalTo: deliveryCoin.trailingAnchor),
            remainMoneyCoin.heightAnchor.constraint(equalToConstant: 13),
        ])
    }
    private func configure() {
        self.configureScrollView()
        self.configureContentView()
        self.configureTitleLabel()
        self.configurePreviousButton()
        self.configureNextButton()
        self.configureWeekStackView()
        self.configureWeekLabel()
        self.configureCollectionView()
        self.configureCalendar()
    }
    
    private func configureScrollView() {
        self.view.addSubview(self.scrollView)
        scrollView.backgroundColor = UIColor(named: "gray3")
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureContentView() {
        self.scrollView.addSubview(self.contentView)
        contentView.backgroundColor = UIColor(named: "gray3")
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.text = "2000년 01월"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 92),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    private func configurePreviousButton() {
        self.contentView.addSubview(self.previousButton)
        self.previousButton.tintColor = .label
        self.previousButton.setImage(UIImage.init(named: "Statistics7"), for: .normal)
        self.previousButton.addTarget(self, action: #selector(self.didPreviousButtonTouched), for: .touchUpInside)
        self.previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.previousButton.widthAnchor.constraint(equalToConstant: 44),
            self.previousButton.heightAnchor.constraint(equalToConstant: 44),
            self.previousButton.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -5),
            self.previousButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    private func configureNextButton() {
        self.contentView.addSubview(self.nextButton)
        self.nextButton.tintColor = .label
        self.nextButton.setImage(UIImage.init(named: "Statistics6"), for: .normal)
        self.nextButton.addTarget(self, action: #selector(self.didNextButtonTouched), for: .touchUpInside)
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nextButton.widthAnchor.constraint(equalToConstant: 44),
            self.nextButton.heightAnchor.constraint(equalToConstant: 44),
            self.nextButton.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5),
            self.nextButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    
    private func configureWeekStackView() {
        self.contentView.addSubview(self.weekStackView)
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = UILabel()
            label.text = dayOfTheWeek[i]
            label.textColor = UIColor.white
            label.textAlignment = .center
            self.weekStackView.addArrangedSubview(label)
        }
    }
    
    private func configureCollectionView() {
        self.contentView.addSubview(self.collectionView)
        collectionView.backgroundColor = UIColor(named: "gray3")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isScrollEnabled = false
        self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor, constant: 10),
            self.collectionView.leadingAnchor.constraint(equalTo: self.weekStackView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.weekStackView.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 300),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    // MARK: - @objc 메서드
    @objc func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print("back click")
        
    }
    
}

extension CalendarCheckViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택된 날짜 계산
        let selectedDate = calendar.date(byAdding: .day, value: indexPath.item - startDayOfTheWeek(), to: calendar.startOfDay(for: calendarDate))!

        // 현재 월의 날짜가 아닌 경우, 선택된 셀을 무시하고 함수 종료
        if !calendar.isDate(selectedDate, equalTo: calendarDate, toGranularity: .month) {
            return
        }

        // 선택된 셀의 인덱스를 업데이트
        selectedIndexPath = indexPath
        
        // 모든 셀의 배경색을 원래의 색으로 변경
        for visibleCell in collectionView.visibleCells {
            if let cell = visibleCell as? CalendarCollectionViewCell {
                cell.backgroundColor = UIColor(named: "gray3")
                cell.dayLabel.textColor = .white
            }
        }
        
        // 선택된 셀의 배경색과 텍스트 색상을 변경
        if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
            cell.backgroundColor = .white
            cell.dayLabel.textColor = .black
            
            // 선택된 날짜의 요일을 가져와서 날짜 레이블을 업데이트
            let formatter = DateFormatter()
            formatter.dateFormat = "MM월 dd일 EEEE"
            let formattedDate = formatter.string(from: selectedDate)
            DayLabel.text = formattedDate
            
            // 선택된 날짜의 year, month, day 추출
            let year = calendar.component(.year, from: selectedDate)
            let month = calendar.component(.month, from: selectedDate)
            let day = calendar.component(.day, from: selectedDate)
            
            // 해당 날짜의 데이터를 서버에서 가져와 UI 업데이트
            fetchData(year: String(year), month: String(month), day: String(day))
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        cell.update(day: self.days[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.frame.width - 30) / 7
        return CGSize(width: width, height: width * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

extension CalendarCheckViewController {
    
    private func configureCalendar() {
        self.dateFormatter.dateFormat = "yyyy년 MM월"
        self.today()
    }
    
    private func startDayOfTheWeek() -> Int {
        return self.calendar.component(.weekday, from: self.calendarDate) - 1
    }
    
    private func endDate() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.calendarDate)?.count ?? Int()
    }
    
    private func updateCalendar() {
        self.updateTitle()
        self.updateDays()
    }
    
    private func updateTitle() {
        let date = self.dateFormatter.string(from: self.calendarDate)
        self.titleLabel.text = date
    }
    
    private func updateDays() {
        self.days.removeAll()
        let startDayOfTheWeek = self.startDayOfTheWeek()
        let totalDays = startDayOfTheWeek + self.endDate()
        
        for day in Int()..<totalDays {
            if day < startDayOfTheWeek {
                self.days.append(String())
                continue
            }
            self.days.append("\(day - startDayOfTheWeek + 1)")
        }
        
        self.collectionView.reloadData()
    }
    
    private func minusMonth() {
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: -1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
        self.selectedIndexPath = nil // 월 변경 후 선택된 셀의 인덱스 경로 초기화
    }
    
    private func plusMonth() {
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: 1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
        self.selectedIndexPath = nil // 월 변경 후 선택된 셀의 인덱스 경로 초기화
    }
    
    private func today() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
        self.updateCalendar()
    }
    
}

extension CalendarCheckViewController {
    
    @objc private func didPreviousButtonTouched(_ sender: UIButton) {
        self.minusMonth()
    }
    
    @objc private func didNextButtonTouched(_ sender: UIButton) {
        self.plusMonth()
    }
    
    
    @objc private func didTodayButtonTouched(_ sender: UIButton) {
        self.today()
    }
    
}


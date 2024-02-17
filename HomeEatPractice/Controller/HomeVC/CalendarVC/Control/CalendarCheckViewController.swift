//
//  CalendarCheckViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/20.
//

import UIKit
import Then

class CalendarCheckViewController: UIViewController {
    private var currentDate = Date() // 현재 날짜를 가져옴
    private lazy var weekStackView = UIStackView()
    private lazy var calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let calendarManager = CalendarManager()
    //MARK: - 안내 프로퍼티 생성
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
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "searchtf")?.withAlphaComponent(0.5)
        view.layer.cornerRadius = 13.2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    private let BackIcon = UIButton().then {
        $0.setImage(UIImage(named: "Statistics7"), for: .normal) // BackIcon 이미지를 버튼 이미지로 설정
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(backIconTapped), for: .touchUpInside) // 버튼이 탭되었을 때 backIconTapped 메서드 호출
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
    private let NextIcon = UIButton().then {
        $0.setImage(UIImage(named: "Statistics6"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(nextIconTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
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
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "지출 확인"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = UIColor(named: "gray2")
        updateDayLabel() // DayLabel을 업데이트합니다.
        updateYearMonthLabel()
        updateCalendarData()
        setViews()
        setAddViews()
        setConstraints()
        
        

    }
    
    func updateCalendarData() {
        self.calendarManager.setMonthDays()
        
    }
    private func updateDayLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 EEEE" // 월/일/요일 형식으로 포맷 지정
        let formattedDate = formatter.string(from: currentDate)
        DayLabel.text = formattedDate
        DayLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    func setViews() {
        self.configureWeekStackView()
        self.configureCalendarCollectionView()
    }
    func configureWeekStackView() {
        self.progressView.addSubview(weekStackView)
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 61), // progressView의 topAnchor로 수정
            self.weekStackView.heightAnchor.constraint(equalToConstant: 24),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.progressView.leadingAnchor),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.progressView.trailingAnchor)
        ])
        self.configureWeekLabel()
    }
    func configureCalendarCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumInteritemSpacing = 5 // 셀 간의 가로 간격
//        flowLayout.minimumLineSpacing = 10 // 셀 간의 세로 간격
        self.calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.progressView.addSubview(calendarCollectionView)
        self.calendarCollectionView.dataSource = self
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        self.calendarCollectionView.backgroundColor = .clear
        self.calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.calendarCollectionView.leadingAnchor.constraint(equalTo: self.progressView.leadingAnchor),
            self.calendarCollectionView.trailingAnchor.constraint(equalTo: self.progressView.trailingAnchor),
            self.calendarCollectionView.topAnchor.constraint(equalTo: self.progressView.topAnchor, constant: 79),
            self.calendarCollectionView.bottomAnchor.constraint(equalTo: self.progressView.bottomAnchor)
        ])
    }
    private func setAddViews(){
        self.view.addSubview(self.guideImage1)
        self.view.addSubview(self.guideImage2)
        self.view.addSubview(self.guidelabel1)
        self.view.addSubview(self.mealLabel)
        self.view.addSubview(self.progressView)
        progressView.addSubview(circleView)
        progressView.addSubview(circleView2)
        progressView.addSubview(BackIcon)
        progressView.addSubview(YearMonthLabel)
        progressView.addSubview(NextIcon)
        self.view.addSubview(DayLabel)
        self.view.addSubview(mealIcon)
        self.view.addSubview(mealVerticalView)
        self.view.addSubview(mealLabel2)
        self.view.addSubview(mealCoin)
        self.view.addSubview(deliveryIcon)
        self.view.addSubview(deliveryVerticalView)
        //self.view.addSubview()
        self.view.addSubview(deliveryLabel2)
        self.view.addSubview(deliveryCoin)
        self.view.addSubview(remainMoneyIcon)
        self.view.addSubview(remainVerticalView)
        self.view.addSubview(remainMoneyLabel)
        self.view.addSubview(remainMoneyCoin)
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            self.guidelabel1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 116),
            self.guidelabel1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -21),
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
            mealLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -21),

        ])
        NSLayoutConstraint.activate([
            
            self.guideImage2.topAnchor.constraint(equalTo: self.mealLabel.topAnchor),
            self.guideImage2.heightAnchor.constraint(equalToConstant: 13),
            self.guideImage2.widthAnchor.constraint(equalToConstant: 12),
            self.guideImage2.trailingAnchor.constraint(equalTo: self.guideImage1.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 19),
            self.progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -19),
            self.progressView.topAnchor.constraint(equalTo: self.mealLabel.bottomAnchor, constant: 16),
            self.progressView.heightAnchor.constraint(equalToConstant: 360),
        ])
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: progressView.topAnchor,constant: 15),
            circleView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor,constant: 15),
            circleView.heightAnchor.constraint(equalToConstant: 15.1),
            circleView.widthAnchor.constraint(equalToConstant: 15.1),
                    
        ])
        
        NSLayoutConstraint.activate([
            circleView2.topAnchor.constraint(equalTo: progressView.topAnchor,constant: 15),
            circleView2.trailingAnchor.constraint(equalTo: progressView.trailingAnchor,constant: -15),
            circleView2.heightAnchor.constraint(equalToConstant: 15.1),
            circleView2.widthAnchor.constraint(equalToConstant: 15.1),
        ])
        NSLayoutConstraint.activate([
            BackIcon.heightAnchor.constraint(equalToConstant: 14.6),
            BackIcon.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 19),
            BackIcon.trailingAnchor.constraint(equalTo: YearMonthLabel.leadingAnchor,constant: -11)
        ])
        NSLayoutConstraint.activate([
            YearMonthLabel.heightAnchor.constraint(equalToConstant: 26),
            YearMonthLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            YearMonthLabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 12),
        ])
        NSLayoutConstraint.activate([
            NextIcon.heightAnchor.constraint(equalToConstant: 14.6),
            NextIcon.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 19),
            NextIcon.leadingAnchor.constraint(equalTo: YearMonthLabel.trailingAnchor,constant: 11),
            
        ])
        NSLayoutConstraint.activate([
            DayLabel.heightAnchor.constraint(equalToConstant: 22),
            DayLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 33),
            DayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 19),
        ])
        NSLayoutConstraint.activate([
            mealIcon.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 75),
            mealIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            mealIcon.heightAnchor.constraint(equalToConstant: 12),
            mealIcon.widthAnchor.constraint(equalToConstant: 13),
        ])
        NSLayoutConstraint.activate([
            mealVerticalView.leadingAnchor.constraint(equalTo: mealIcon.trailingAnchor,constant: 7),
            mealVerticalView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 72),
            mealVerticalView.widthAnchor.constraint(equalToConstant: 4),
            mealVerticalView.heightAnchor.constraint(equalToConstant: 18),
        ])
        NSLayoutConstraint.activate([
            mealLabel2.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 75),
            mealLabel2.bottomAnchor.constraint(equalTo: mealVerticalView.bottomAnchor),
            mealLabel2.leadingAnchor.constraint(equalTo: mealVerticalView.trailingAnchor,constant: 7),
        ])
        NSLayoutConstraint.activate([
            mealCoin.topAnchor.constraint(equalTo: mealLabel2.topAnchor),
            mealCoin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            mealCoin.heightAnchor.constraint(equalToConstant: 13),
            mealCoin.widthAnchor.constraint(equalToConstant: 73),
        ])
        NSLayoutConstraint.activate([
            deliveryIcon.bottomAnchor.constraint(equalTo: deliveryVerticalView.bottomAnchor),
            deliveryIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
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
            deliveryCoin.bottomAnchor.constraint(equalTo: deliveryLabel2.bottomAnchor),
            deliveryCoin.trailingAnchor.constraint(equalTo: mealCoin.trailingAnchor),
            deliveryCoin.heightAnchor.constraint(equalToConstant: 13),
        ])
        NSLayoutConstraint.activate([
            //remainMoneyIcon.topAnchor.constraint(equalTo: deliveryIcon.bottomAnchor, constant: 10),
            remainMoneyIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
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
    
    func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        dayOfTheWeek.forEach {
            let label = UILabel()
            label.text = $0
            label.textAlignment = .center
            self.weekStackView.addArrangedSubview(label)
            label.textColor = .white
        }
    }
    // BackIcon을 눌렀을 때 호출되는 함수
    @objc private func backIconTapped() {
        // 현재 월을 1 감소시킴
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? Date()
        // YearMonthLabel 업데이트
        updateYearMonthLabel()
    }
    @objc private func nextIconTapped() {
        // 다음 월의 첫 번째 날에 해당하는 IndexPath 생성
        let nextMonthFirstDayIndexPath = IndexPath(item: 0, section: self.calendarManager.yearMonths.firstIndex(of: currentDate) ?? 0)
        
        // 다음 섹션으로 이동하기 전에 현재 섹션과 총 섹션 수를 확인합니다.
        let currentSection = nextMonthFirstDayIndexPath.section
        let totalSections = self.calendarManager.yearMonths.count
        
        // 다음 섹션으로 이동할 때 섹션이 넘어가지 않도록 제한합니다.
        if currentSection < totalSections - 1 {
            // 현재 월을 1 증가시킴
            currentDate = Calendar.current.date(byAdding: .month, value: +1, to: currentDate) ?? Date()
            // YearMonthLabel 업데이트
            updateYearMonthLabel()
            // 해당 IndexPath로 스크롤
            calendarCollectionView.scrollToItem(at: nextMonthFirstDayIndexPath, at: .left, animated: true)
        }
    }
    // YearMonthLabel을 업데이트하는 함수
    private func updateYearMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        let formattedDate = formatter.string(from: currentDate)
        YearMonthLabel.text = formattedDate
    }

}
extension CalendarCheckViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.calendarManager.monthDays[section].count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return self.calendarManager.yearMonths.count
        }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            return false // 셀을 선택할 수 없도록 설정
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
            
            let monthDays = self.calendarManager.monthDays[indexPath.section]
            let day = monthDays[indexPath.item]
            let isCustomColor = (day == "1" || day == "3")
            cell.configureCellBackground(for: day) // 배경 설정
            cell.configureLabel(text: day, isCustomColor: isCustomColor)
            return cell
    }

}
extension CalendarCheckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0 // 셀 간의 가로 간격을 0으로 설정합니다.
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0 // 셀 간의 세로 간격을 0으로 설정합니다.
       }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 30)
        }
}


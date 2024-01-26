//
//  CashViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/02.
//

import UIKit
import Tabman
import Pageboy

class CashViewController: TabmanViewController {
    private var viewcontrollers : Array<UIViewController> = []  //뷰컨트롤러의 뷰를 넣을 배열

    private lazy var tabbar: TMBar.ButtonBar = {
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .clear
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.buttons.customize { (button) in
            button.selectedTintColor = .white
            button.tintColor = .gray
        }
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .white
        return bar
    }()
    
    
    // 탭바를 담을 컨테이너
    private lazy var containerView: UIView = {
            let container = UIView()
            container.backgroundColor = .clear
            container.translatesAutoresizingMaskIntoConstraints = false
            return container
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "홈잇리포트"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.view.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        setViewcontroller()
        setConstraints()
        tabbar.dataSource = self
       
        dataSource = self
    }
    func setViewcontroller() {
        let badgeCheckViewController = BadgeCheckViewController()
        let weekCashViewController = WeekCashViewController()
        viewcontrollers.append(contentsOf: [badgeCheckViewController,weekCashViewController])
    }
    func setConstraints() {
        addBar(tabbar, dataSource: self,  at: .custom(view: containerView, layout: nil))
        self.tabbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40)

        ])

    }
}

extension CashViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewcontrollers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewcontrollers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = index == 0 ? "소비분석" : "주별조회"
        return TMBarItem(title: title)
    }
}

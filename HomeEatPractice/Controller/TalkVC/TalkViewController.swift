//
//  TalkViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/02.
//
import UIKit
import Tabman
import Pageboy

class TalkViewController: TabmanViewController {
   
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
    private lazy var containerView: UIView = {
            let container = UIView()
            container.backgroundColor = UIColor(named: "gray2")
            container.translatesAutoresizingMaskIntoConstraints = false
            return container
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "홈잇토크"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.view.backgroundColor = UIColor(named: "gray2")
        setConstraints()
        setViewcontroller()
        tabbar.dataSource = self
        dataSource = self
    }

    func setViewcontroller() {
        let firstVC = WriteViewController()
        let secondVC = InfoViewController()
        viewcontrollers.append(contentsOf: [firstVC,secondVC])
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tabBarController?.tabBar.isHidden = false
            tabBarController?.tabBar.isTranslucent = false
        }
    func setConstraints() {
        addBar(tabbar, dataSource: self, at: .custom(view: containerView, layout: nil))
    
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40)

        ])

    }
}
extension TalkViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
        let title = index == 0 ? "집밥토크" : "정보토크"
        return TMBarItem(title: title)
    }
    
}

    


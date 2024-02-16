//
//  MainTabBarController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/02.
//

import Foundation
import UIKit
import Tabman

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    private let tabItems: [TabbarInfo] = [
        TabbarInfo(title: "     홈", imageName: "hometab", selectedImageName: "hometab2"),
        TabbarInfo(title: " 홈잇리포트", imageName: "homeatreport", selectedImageName: "homeatreport1"),
        TabbarInfo(title: " 홈잇토크", imageName: "talktab", selectedImageName: "talktab2"),
        TabbarInfo(title: "마이페이지", imageName: "profiletab", selectedImageName: "profiletab2"),
    ]
    private var newTabBarHeight: CGFloat = 89
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupCustomTabBar()
        setupViewControllers()
    }
    private func setupViewControllers() {
        var viewControllers: [UIViewController] = []
        
        for (index, tabItem) in tabItems.enumerated() {
            let viewController: UIViewController
            switch index {
            case 0:
                viewController = HomeViewController()
            case 1:
                viewController = CashViewController()
            case 2:
                viewController = TalkViewController()
            case 3:
                viewController = MyPageViewController()
            default:
                return
            }
            
            let navigationViewController = UINavigationController(rootViewController: viewController)
            let tabBarItem = UITabBarItem(title: tabItem.title, image: UIImage(named: tabItem.imageName), selectedImage: UIImage(named: tabItem.selectedImageName))
            navigationViewController.tabBarItem = tabBarItem
            viewControllers.append(navigationViewController)
        }

        self.viewControllers = viewControllers
    }

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // 선택된 뷰컨트롤러에 따라 이미지 변경
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            updateTabBarItemImage(index)
        }
    }
    
    // 각 탭바 아이템의 이미지를 업데이트하는 메서드
    private func updateTabBarItemImage(_ selectedIndex: Int) {
        for (index, item) in tabBar.items!.enumerated() {
            // 선택된 탭에만 선택된 이미지를 설정하고 나머지는 비선택 이미지를 설정
            let tabItem = tabItems[index]
            let imageName = (index == selectedIndex) ? tabItem.selectedImageName : tabItem.imageName
            item.image = UIImage(named: imageName)
        }
    }
    
    lazy var customTabBar: UIView = {
        let customTabBar = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY - newTabBarHeight, width: self.tabBar.frame.width, height: newTabBarHeight))
        customTabBar.backgroundColor = UIColor(named: "gray4")
        self.tabBar.tintColor = UIColor(named: "searchfont")
        customTabBar.layer.cornerRadius = 10
        return customTabBar
    }()
    
    private func setupCustomTabBar() {

        let buttonWidth = self.tabBar.frame.width / CGFloat(tabItems.count)

        for (index, tabItem) in tabItems.enumerated() {
            let button = UIButton(type: .custom)
            let isSelected = index == 0 // rootViewController에 해당하는 탭 아이템을 선택 상태로 설정
            button.setImage(UIImage(named: tabItem.imageName), for: .normal)
            button.frame = CGRect(x: CGFloat(index) * buttonWidth + buttonWidth / 4, y: -20, width: buttonWidth, height: newTabBarHeight)
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(tabBarItemTapped(_:)), for: .touchUpInside)
            button.setTitle(tabItem.title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 10) // 적절한 크기로 변경
            button.titleEdgeInsets = UIEdgeInsets(top: 25, left: -button.imageView!.frame.size.width - 5, bottom: -button.imageView!.frame.size.height, right: 0)
            button.contentHorizontalAlignment = .leading
           // button.contentVerticalAlignment = .center
            customTabBar.addSubview(button)
            // rootViewController에 해당하는 탭 아이템을 선택 상태로 설정
            if isSelected {
                self.selectedIndex = index
            }
        }
        // 탭바 아이템 타이틀 설정
        
        view.addSubview(customTabBar)
    }

    
    
    @objc private func tabBarItemTapped(_ sender: UIButton) {
        if let index = sender.superview?.subviews.firstIndex(of: sender) {
            self.selectedIndex = index
            updateTabBarItemImage(index)
            
            for (buttonIndex, button) in sender.superview!.subviews.enumerated() {
                if let button = button as? UIButton {
                    let isSelected = (buttonIndex == index)
                    let tabItem = tabItems[buttonIndex]
                    let imageName = isSelected ? tabItem.selectedImageName : tabItem.imageName
                    button.setImage(UIImage(named: imageName), for: .normal)
                    button.setTitleColor(isSelected ? UIColor(named: "green") : UIColor(named: "searchfont"), for: .normal)
                }
            }
        }
    }
}



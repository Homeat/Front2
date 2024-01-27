//
//  MealWritingViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/22.
//

import UIKit

class MealWritingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gray2")
        navigationcontrol()
    }
    
    private func navigationcontrol() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "집밥토크 글쓰기"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    
    // MARK: - @objc 메서드
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
}

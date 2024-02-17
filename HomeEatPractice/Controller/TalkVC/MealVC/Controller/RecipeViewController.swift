
// cell사용
//  RecipeViewController.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/6/24.
//
import UIKit
import Then
import AVFoundation
import Photos
import PhotosUI



class RecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 레시피 단계들을 저장
    var recipeSteps:[RecipeStep] = []
    
    lazy var recipeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "gray2")
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var recipeHeaderView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: recipeTableView.frame.width, height: 85.5))
        headerView.backgroundColor = UIColor(named: "gray2") // 적절한 색상으로 설정합니다.
        return headerView
    }()
    
    lazy var buttonFooterView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: recipeTableView.frame.width, height: 265))
        footerView.backgroundColor = UIColor(named: "gray2") // 적절한 색상으로 설정합니다.
        return footerView
    }()
    
    // 레시피 라벨
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textColor = UIColor(named: "green")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 위쪽 경계선
    lazy var overBorderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 102, g: 102, b: 102)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 스텝 추가 버튼
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(r: 150, g: 150, b: 150).cgColor
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 레시피 추가하기 버튼
    lazy var recipePlusButton: UIButton = {
        let button = UIButton()
        button.setTitle("레시피 추가하기", for: .normal)
        button.backgroundColor = UIColor(named: "green")
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(recipePlusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray2")
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeTableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        self.view.addGestureRecognizer(tapGesture)
        navigationControl()
        setUI()
        setConstraints()
    }
    
    func setUI() {
        recipeHeaderView.addSubview(recipeLabel)
        recipeHeaderView.addSubview(overBorderLine)
        buttonFooterView.addSubview(plusButton)
        buttonFooterView.addSubview(recipePlusButton)
        recipeTableView.tableHeaderView = recipeHeaderView
        recipeTableView.tableFooterView = buttonFooterView
        self.view.addSubview(recipeTableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            recipeTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            recipeTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            recipeTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            recipeTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            //HeaderView
            recipeLabel.leadingAnchor.constraint(equalTo: recipeHeaderView.leadingAnchor),
            recipeLabel.trailingAnchor.constraint(equalTo: recipeHeaderView.trailingAnchor),
            recipeLabel.topAnchor.constraint(equalTo: recipeHeaderView.topAnchor, constant: 40),
            recipeLabel.heightAnchor.constraint(equalToConstant: 26),
            
            overBorderLine.leadingAnchor.constraint(equalTo: recipeHeaderView.leadingAnchor),
            overBorderLine.trailingAnchor.constraint(equalTo: recipeHeaderView.trailingAnchor),
            overBorderLine.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 14),
            overBorderLine.heightAnchor.constraint(equalToConstant: 1),
            
            //FooterView
            plusButton.leadingAnchor.constraint(equalTo: buttonFooterView.leadingAnchor),
            plusButton.trailingAnchor.constraint(equalTo: buttonFooterView.trailingAnchor),
            plusButton.topAnchor.constraint(equalTo: buttonFooterView.topAnchor, constant: 25), // 원하는 너비
            plusButton.heightAnchor.constraint(equalToConstant: 50), // 원하는 높이
            
            recipePlusButton.leadingAnchor.constraint(equalTo: buttonFooterView.leadingAnchor),
            recipePlusButton.trailingAnchor.constraint(equalTo: buttonFooterView.trailingAnchor),
            recipePlusButton.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 43), // 원하는 너비
            recipePlusButton.heightAnchor.constraint(equalToConstant: 57) // 원하는 높이
        ])
    }
    
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "집밥토크 글쓰기"
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "gray2")
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "gray2")
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    // MARK: - 탭바처리
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 커스텀 탭바를 숨깁니다.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 넘어갈 때 커스텀 탭바를 다시 보이게 합니다.
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.customTabBar.isHidden = false
        }
    }
    
    //MARK: - 키보드 처리
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // NotificationCenter에 관찰자를 등록하는 행위.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 관찰자 분리.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func viewDidTap(gesture: UITapGestureRecognizer) {
        // 뷰를 탭하면 키보드가 내려감.
        view.endEditing(true)
    }
    
    @objc override func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.recipeTableView.contentInset.bottom = keyboardFrame.height
                // 키보드가 recipeTextView를 가리지 않도록 선택된 셀이 가리키도록 스크롤
                if let selectedIndexPath = self.recipeTableView.indexPathForSelectedRow {
                    self.recipeTableView.scrollToRow(at: selectedIndexPath, at: .none, animated: true)
                }
            }
    }
    
    @objc override func keyboardWillHide(_ sender: Notification) {
        // 키보드가 사라질 때 뷰를 원래 위치로 되돌리는 코드로 수정
        self.view.frame.origin.y = 0
    }
    
    
    
    //MARK: - @objc 메서드
    @objc func plusButtonTapped() {
        print("버튼클릭")
    }
    func addRecipeStep(_ step: RecipeStep) {
            recipeSteps.append(step)
        }
    
    //레시피를 추가
    @objc func recipePlusButtonTapped() {
        print("레시피추가 버튼클릭")
        let nextVC = WriteViewController()
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //뒤로가기
    @objc func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print("back click")
    }
    
}

//MARK: - 레시피 스텝 추가,삭제 Extension
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as! RecipeTableViewCell
                
                // 해당 indexPath에 맞는 레시피 단계를 셀에 전달하여 설정
                let step = recipeSteps[indexPath.row]
                cell.configure(with: step)

                // 셀의 delegate를 설정
                cell.delegate = self

                return cell
    }
}

extension RecipeViewController: RecipeCellDelegate {
    
    
    func didTapRemoveButton(cell: RecipeTableViewCell) {
            guard let indexPath = recipeTableView.indexPath(for: cell) else { return }
            recipeSteps.remove(at: indexPath.row)
            recipeTableView.reloadData() // 변경된 데이터로 테이블 뷰를 다시 로드
        }
}



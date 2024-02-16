//
//  TagPlusViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/20.
//

import UIKit
import Then

class TagPlusViewController: UIViewController {
    var selectedCellCount = 0
    var selectedTags: [String] = [] {
        didSet {
            // 선택된 태그가 업데이트될 때마다 새로운 값을 출력합니다.
//            print("Selected Tags: \(selectedTags)")
        }
    }
    var tags: [TagItem] = defaultTags
    // TagPlusCollectionViewCell 프로퍼티 추가
    //해시태그 수동 추가 필드
    private let tagplusField = UITextField().then {
        $0.placeholder = "다양한 해시태그를 추가해보세요!"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor(named: "font5")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(named: "gray4")
        $0.attributedPlaceholder = NSAttributedString(string: "다양한 해시태그를 추가해보세요!", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "font5") ?? UIColor.gray])
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
        $0.leftViewMode = .always
         
    }
    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        // 이미지 설정
        let plusImage = UIImage(named: "Home3")
        button.setImage(plusImage, for: .normal)
        // 이미지 크기 조정
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "gray2")
        
        

        return collectionView
    }()
    //저장 버튼
    private let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.init(named: "gray4")
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(navigatetToInfoWritingViewController), for: .touchUpInside)
        //$0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        self.view.addGestureRecognizer(tapGesture)
        //기본 태그 데이터를 초기화
        tags = defaultTags
        navigationControl()
        addSubviews()
        configUI()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(TagPlusCollectionViewCell.self, forCellWithReuseIdentifier: TagPlusCollectionViewCell.reuseIdentifier)
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        
        view.backgroundColor = UIColor(named: "gray2")
        // 태그 셀의 선택 상태 변경을 감지하고 저장 버튼의 배경색을 업데이트합니다.
        
    }
    private func updateSaveButtonAppearance(_ isSelected: Bool) {
            saveButton.backgroundColor = isSelected ? UIColor(named: "green") : UIColor(named: "gray4")
    }
    @objc func viewDidTap(gesture: UITapGestureRecognizer) {
        // 뷰를 탭하면 에디팅을 멈추게함.
        // 에디팅이 멈추므로 키보드가 내려감.
        view.endEditing(true)
    }
    // MARK: - 탭바제거
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
    // MARK: - 네비게이션
    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.title = "해시태그 추가"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    func addSubviews() {
        view.addSubview(tagplusField)
        tagplusField.addSubview(plusButton)
        view.addSubview(collectionView)
        view.addSubview(saveButton)
    }
    func configUI() {
        NSLayoutConstraint.activate([
            tagplusField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            tagplusField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tagplusField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            tagplusField.heightAnchor.constraint(equalToConstant: 50),
        ])
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: tagplusField.topAnchor, constant: 5),
            plusButton.trailingAnchor.constraint(equalTo: tagplusField.trailingAnchor, constant: -20),
            plusButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tagplusField.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -76),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 57)
        ])
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumInteritemSpacing = 5
                layout.minimumLineSpacing = 17
            }
    }
    func updateSaveButtonAppearance() {
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems, !selectedIndexPaths.isEmpty {
            // 선택된 셀이 있는 경우
            saveButton.backgroundColor = UIColor(named: "green") ?? UIColor.red
            saveButton.setTitleColor(UIColor.black, for: .selected)
        } else {
            // 선택된 셀이 없는 경우
            saveButton.backgroundColor = UIColor(named: "gray4") ?? UIColor.gray
            saveButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    @objc private func plusButtonTapped() {
        // 텍스트 필드에 입력된 텍스트 가져오기
        if let newTag = tagplusField.text, !newTag.isEmpty {
            // 입력된 텍스트가 비어있지 않으면 태그 배열에 추가
            tags.append(TagItem(tagTitle: newTag))
            // 콜렉션 뷰 리로드
            collectionView.reloadData()
            // 텍스트 필드 초기화
            tagplusField.text = nil
        }
    }
    // 셀을 터치했을 때 발생하는 이벤트
    @objc func navigateToPostViewController() {
        let MealPostVC = MealPostViewController()
        navigationController?.pushViewController(MealPostVC, animated: true)
        print("present click")
    }

    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    //게시글 작성으로 넘어감
    @objc func navigatetToInfoWritingViewController(_ sender: Any) {
        let InfoWriteVC = InfoWritingViewController()
        InfoWriteVC.selectedTags = selectedTags // 선택된 태그 전달
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환
        self.navigationController?.pushViewController(InfoWriteVC, animated: true)
    }
    // 선택된 태그 배열을 다른 뷰 컨트롤러로 전달하는 메서드
    func sendSelectedTagsToOtherViewController(_ selectedTags: [String]) {
        // 선택된 태그 배열을 인스턴스 프로퍼티에 저장
        self.selectedTags = selectedTags
        print("Selected Tags: \(selectedTags)")

    }

}
extension TagPlusViewController: UICollectionViewDelegate {
    
}
extension TagPlusViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagPlusCollectionViewCell.reuseIdentifier, for: indexPath) as? TagPlusCollectionViewCell else {
            return UICollectionViewCell()
        }
        let tagItem = tags[indexPath.item]
        cell.configure(with: tagItem.tagTitle, selectedTags: selectedTags)
        // TagPlusCollectionViewCell의 onSelectStatusChange 클로저 설정
        cell.onSelectStatusChange = { [weak self] isSelected in
            self?.updateSaveButtonAppearance(isSelected)
        }

        // TagPlusCollectionViewCell의 onSelectionChange 클로저 설정
        cell.onSelectionChange = { [weak self] in
            // 선택된 태그 배열을 다른 뷰 컨트롤러로 전달
            if let selectedTags = self?.collectionView.visibleCells.compactMap({ ($0 as? TagPlusCollectionViewCell)?.selectedTags }).flatMap({ $0 }) {
                self?.sendSelectedTagsToOtherViewController(selectedTags)
                print(selectedTags)
            }
        }
        
        return cell
    }
    
}
extension TagPlusViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagItem = tags[indexPath.item]
        let titleSize = NSString(string: tagItem.tagTitle).size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ])
        let cellWidth = titleSize.width + 40
        
        return CGSize(width: cellWidth, height: 45)
    }
}

//
//  WriteViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/10.
//

import UIKit

class WriteViewController: UIViewController {
    
    //검색 뷰
    lazy var searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "searchtf")
        if let borderColor = UIColor(named: "font3")?.cgColor {
            view.layer.borderColor = borderColor
        }
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        
        return view
    } ()
    
    // 텍스트 필드
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "관심있는 집밥을 검색해보세요"
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.textColor = UIColor(named: "searchfont")
        textField.attributedPlaceholder = NSAttributedString(string: "관심있는 집밥을 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "searchfont") ?? UIColor.gray])

        return textField
    }()
    
    // 검색 이미지
    lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Group 5064"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 순서버튼
    lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("최신순", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage(named: "Talk5"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(listAction), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = false
        view.isDirectionalLockEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var widthBaseView: UIView = {
            var view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var widthStackView: UIStackView = {
            var view = UIStackView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.distribution = .fill
            view.alignment = .fill
        view.spacing = 8
            return view
        }()
    
    lazy var contentbutton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor(named: "green")?.cgColor
        button.setTitle("#전체글", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.isSelected = true
        button.setTitleColor(UIColor(named: "green"), for: .selected)
        return button
    }()
    
    lazy var contentbutton2: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("#주간_BEST", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(UIColor(named: "green"), for: .selected)
        return button
    }()
    
    lazy var contentbutton3: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("#아침", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(UIColor(named: "green"), for: .selected)
        return button
    }()
    
    lazy var contentbutton4: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("#점심", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(UIColor(named: "green"), for: .selected)
        return button
    }()
    
    lazy var contentbutton5: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "gray2")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1.56
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("#저녁", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "폰트", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(UIColor(named: "green"), for: .selected)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let writingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Talk3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(writingButtonAction), for: .touchUpInside)
        return button
    }()
    
    var soruce: [MealSource] = [
        MealSource(mealLabel: "샐러드", mealImage: UIImage(named: "example1")),
        MealSource(mealLabel: "자취생 집밥", mealImage: UIImage(named: "example1")),
        MealSource(mealLabel: "콩나물밥", mealImage: UIImage(named: "example1")),
        MealSource(mealLabel: "사과잼", mealImage: UIImage(named: "example1")),
        MealSource(mealLabel: "콩나물밥", mealImage: UIImage(named: "example1")),
        MealSource(mealLabel: "콩나물밥", mealImage: UIImage(named: "example1")),
    ]
    
    //MARK: - 화면설정
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setConstraints()
        initialize()
        collectionView.reloadData()
    }
    
    func initialize() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.register(MealViewCell.self, forCellWithReuseIdentifier: "\(MealViewCell.self)")
    }
    
    private func addViews() {
        self.view.addSubview(searchView)
        self.searchView.addSubview(searchTextField)
        self.searchView.addSubview(searchImageView)
        self.view.addSubview(self.listButton)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.widthBaseView)
        self.widthBaseView.addSubview(self.widthStackView)
        self.widthStackView.addArrangedSubview(contentbutton)
        self.widthStackView.addArrangedSubview(contentbutton2)
        self.widthStackView.addArrangedSubview(contentbutton3)
        self.widthStackView.addArrangedSubview(contentbutton4)
        self.widthStackView.addArrangedSubview(contentbutton5)
        
        self.view.addSubview(self.collectionView)
        
        self.view.addSubview(self.writingButton)
        self.view.bringSubviewToFront(writingButton)
        self.writingButton.isHidden = false
        
    }
    
    private func setConstraints() {
        self.searchView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.searchView.widthAnchor.constraint(equalToConstant: 351).isActive = true
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 164),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 21),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -21),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10),
            searchTextField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: -10),

            searchImageView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
            searchImageView.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 14.95),
            searchImageView.heightAnchor.constraint(equalToConstant: 14.95),
            
            self.listButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 16),
            self.listButton.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: listButton.bottomAnchor, constant: 12),
            scrollView.heightAnchor.constraint(equalToConstant: 31),
            
            widthBaseView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            widthBaseView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            widthBaseView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            widthBaseView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            widthStackView.leadingAnchor.constraint(equalTo: widthBaseView.leadingAnchor),
            widthStackView.trailingAnchor.constraint(equalTo: widthBaseView.trailingAnchor),
            widthStackView.topAnchor.constraint(equalTo: widthBaseView.topAnchor),
            widthStackView.bottomAnchor.constraint(equalTo: widthBaseView.bottomAnchor),
            
            contentbutton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentbutton.widthAnchor.constraint(equalToConstant: 68),
            contentbutton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton2.widthAnchor.constraint(equalToConstant: 95),
            contentbutton2.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton3.widthAnchor.constraint(equalToConstant: 56),
            contentbutton3.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton4.widthAnchor.constraint(equalToConstant: 56),
            contentbutton4.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton4.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentbutton5.widthAnchor.constraint(equalToConstant: 56),
            contentbutton5.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentbutton5.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 19),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            writingButton.widthAnchor.constraint(equalToConstant: 51),
            writingButton.heightAnchor.constraint(equalToConstant: 51),
            writingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            writingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -12)
        
        ])
    }
    
    // 셀을 터치했을 때 발생하는 이벤트
    @objc func navigateToPostViewController() {
        let MealPostVC = MealPostViewController()
        navigationController?.pushViewController(MealPostVC, animated: true)
        print("present click")
    }
    
    // 글쓰기 버튼을 눌렀을 때 발생하는 이벤트
    @objc func writingButtonAction() {
        let nextVC = MealWritingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @objc func listAction() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

       
        let newestAction = UIAlertAction(title: "최신순", style: .default) { _ in
            print("최신순 selected")
        }
        let likesAction = UIAlertAction(title: "공감순", style: .default) { _ in
            print("공감순 selected")
        }
        let viewsAction = UIAlertAction(title: "조회순", style: .default) { _ in
            print("조회순 selected")
        }
        let oldestAction = UIAlertAction(title: "오래된 순", style: .default) { _ in
            print("오래된 순 selected")
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        actionSheet.addAction(newestAction)
        actionSheet.addAction(likesAction)
        actionSheet.addAction(viewsAction)
        actionSheet.addAction(oldestAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
}


//MARK: - 프로토콜
extension WriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return soruce.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MealViewCell.self)", for: indexPath) as? MealViewCell else {
            return UICollectionViewCell()
        }
        
        let item = soruce[indexPath.row]
        cell.mealLabel.text = item.mealLabel
        cell.mealImage.image = item.mealImage
        return cell
    }
}

extension WriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToPostViewController()
    }
}

// 여기서 cell의 크기를 결정
extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 2 - 20
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
        }
        
        // CollectionView Cell의 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 30.0
        }
}

    
    

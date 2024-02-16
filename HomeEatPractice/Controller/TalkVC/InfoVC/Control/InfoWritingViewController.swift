//
//  InfoWritingViewController.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/16.
//

import UIKit
import Then
import AVFoundation
import Photos
import PhotosUI

class InfoWritingViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    //MARK: - container 파트
    var selectedTags : [String] = []
    private lazy var customButton: UIButton = makeCustomButton()
    let talk12Image: UIImage? = UIImage(named: "Talk12")

    //MARK: - 사진과 앨범 파트
    private var selectedImages: [UIImage] = []
    //MARK: - 사진과 앨범 파트
    private enum Mode {
            case camera
            case album
    }
    //MARK: - 사진과 앨범 파트
    private var currentMode: Mode = .camera
    private let hashContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    //MARK: - 사진과 앨범 파트
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        //셀 만들어야 함
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
        return collectionView
    }()
   
    
    //MARK: - UIButton 파트
    private let addImageButton : UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("사진 추가", for: .normal)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.backgroundColor = UIColor(named: "searchtf")
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        return button
    }()
    //MARK: - UIImage 파트
    //첫번째 이미지 뷰
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
    //MARK: -- Tagbutton 파트
    private lazy var TagcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        //셀 만들어야 함
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCell")
        
        return collectionView
    }()
    //#해시태그
    private let tagImage = UIButton().then {
        $0.setImage(UIImage(named: "Talk11"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(navigateToTagPlusViewController), for: .touchUpInside)
        
    }
    
    //태그 문구
    private let tagButton = UIButton().then {
        $0.setTitle("#해시태그를 추가해 보세요!", for: .normal)
        $0.setTitleColor(UIColor(named: "green"), for: .normal)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.init(named: "green")?.cgColor
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //제목
    private let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = UIColor.init(named: "green")
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //제목 입력 텍스트 필드
    private let titleField = UITextField().then {
        $0.placeholder = "제목을 입력하세요!"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor(named: "font5")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(named: "gray4")
        $0.attributedPlaceholder = NSAttributedString(string: "제목을 입력하세요!", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "font5") ?? UIColor.gray])
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    private let contentLabel = UILabel().then {
        $0.text = "내용"
        $0.textColor = UIColor.init(named: "green")
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let contentField: UITextView = {
        let textView = UITextView()
        textView.text = "질문이나 이야기를 해 보세요!"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor(named: "font5")
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(named: "gray4")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 내용 여백 조절
        
        let verticalOffset = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        textView.contentInset = UIEdgeInsets(top: max(0, verticalOffset), left: 0, bottom: 0, right: 0)
        return textView
    }()

    //MARK: - 사진과 앨범 파트
    private var isCameraAuthorized: Bool {
       AVCaptureDevice.authorizationStatus(for: .video) == .authorized
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 화면의 다른 곳을 누려면 키보드가 내려가는 메서드.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
       // view에 탭 제스처를 추가.
        self.view.addGestureRecognizer(tapGesture)
        contentField.delegate = self
        view.backgroundColor = UIColor(named: "gray3")
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        navigationControl()
        configUI()
        
    }
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

    func navigationControl() {
        let backbutton = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(back(_:)))
        //간격을 배열로 설정
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        flexibleSpace.width = 5.0
        navigationItem.leftBarButtonItem = backbutton
        let rightBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save(_:)))
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.title = "정보토크 글쓰기"
        //title 흰색으로 설정
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
    }
    
    func configUI() {
        //let customButton = makeCustomButton()
        customButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.imageView)
        view.bringSubviewToFront(self.imageView)
        //MARK: - 사진과 앨범 파트
        view.addSubview(collectionView)
        view.addSubview(TagcollectionView)
        self.view.addSubview(tagButton)
        self.view.addSubview(tagImage)
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleField)
        self.view.addSubview(contentLabel)
        self.view.addSubview(contentField)
        self.view.addSubview(customButton)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 51),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
            self.imageView.heightAnchor.constraint(equalToConstant: 176),
            
        ])
        //MARK: - 사진과 앨범 파트
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 51),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 176),
        ])
        // TagcollectionView 표시 여부에 따라 tagButton의 숨김 여부 설정
            if !selectedTags.isEmpty {
                // selectedTags 배열이 비어있지 않을 때 TagcollectionView 표시
                NSLayoutConstraint.activate([
                    TagcollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 267),
                    TagcollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 22),
                    TagcollectionView.trailingAnchor.constraint(equalTo: tagImage.leadingAnchor,constant: 40),
                    TagcollectionView.heightAnchor.constraint(equalToConstant: 40),
                ])
                // TagcollectionView가 표시될 때 tagButton 숨김
                tagButton.isHidden = true
            } else {
                // selectedTags 배열이 비어있을 때 TagcollectionView 숨김
                TagcollectionView.isHidden = true
                // TagcollectionView가 숨겨질 때 tagButton 표시
                tagButton.isHidden = false
            }
//        NSLayoutConstraint.activate([
//            TagcollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 267),
//            TagcollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 22),
//            TagcollectionView.trailingAnchor.constraint(equalTo: tagImage.leadingAnchor,constant: 40),
//            TagcollectionView.heightAnchor.constraint(equalToConstant: 40),
//        ])
//
        NSLayoutConstraint.activate([
                tagButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 267),
                tagButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
                tagButton.heightAnchor.constraint(equalToConstant: 40),
                tagButton.widthAnchor.constraint(equalToConstant: 214)

        ])
        NSLayoutConstraint.activate([
                tagImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 265),
                tagImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                tagImage.heightAnchor.constraint(equalToConstant: 42),
                tagImage.widthAnchor.constraint(equalToConstant: 42)
        ])
        NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: tagImage.bottomAnchor, constant: 41),
                titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21),
                titleLabel.heightAnchor.constraint(equalToConstant: 34),
                titleLabel.widthAnchor.constraint(equalToConstant: 34)
        ])
        NSLayoutConstraint.activate([
                titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                titleField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                titleField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
                titleField.heightAnchor.constraint(equalToConstant: 50),
        ])
        NSLayoutConstraint.activate([
                contentLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 27),
                contentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                contentLabel.heightAnchor.constraint(equalToConstant: 50),
                contentLabel.widthAnchor.constraint(equalToConstant: 353)
        ])
        NSLayoutConstraint.activate([
                contentField.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 5),
                contentField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                contentField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
                contentField.heightAnchor.constraint(equalToConstant: 50),
        ])
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48),
            customButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
            customButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
            customButton.heightAnchor.constraint(equalToConstant: 176),
        ])
        contentField.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)

    }
    //MARK: - 사진과 앨범 파트 and 태그파트
    // sizeForItemAt 메서드 추가
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기 설정
        if collectionView == self.collectionView {
            return CGSize(width: 176, height: 176)
        } else if collectionView == TagcollectionView {
            let tag = selectedTags[indexPath.item]
            let tagWidth = tag.width(withConstrainedHeight: 40, font: UIFont.systemFont(ofSize: 15), margin: 50)
            return CGSize(width: tagWidth, height: 40)
        }

        return CGSize.zero
    }
    // contentSize의 변경을 관찰하여 동적으로 높이 조정
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newSize = change?[.newKey] as? CGSize {
            let newHeight = max(newSize.height, 50) // 최소 높이 제약 조건 설정
            contentField.constraints.filter { $0.firstAttribute == .height }.first?.constant = newHeight
            view.layoutIfNeeded()
        }
    }
    deinit {
        // 뷰 컨트롤러가 할당 해제될 때 옵저버를 제거
        contentField.removeObserver(self, forKeyPath: "contentSize")
    }
    //뒤로가기
    @objc func back(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        print("back click")
     }
    //저장
    @objc func save(_ sender: UIBarButtonItem) {
        guard let title = titleField.text, let content = contentField.text else {
            // title 또는 content가 nil이라면 에러 처리 또는 사용자에게 알림
            
            return
        }
    //MARK: - 서버 연동
    GeneralAPI.saveInfoTalk(title: title, content: content, tags: selectedTags) { result in
           switch result {
           case .success(let infoTalk):
               print("InfoTalk 저장 성공: \(infoTalk)")
               print("title:\(title)")
               print("content\(content)")

               // 이미지 업로드를 수행합니다.
               GeneralAPI.uploadImages(infoTalkID: infoTalk.id, images: self.selectedImages) { uploadResult in
                   switch uploadResult {
                   case .success:
                       print("이미지 업로드 성공")
                       let nextVC = TalkViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
                       nextVC.navigationItem.hidesBackButton = true // 백 버튼 숨기기
                       self.navigationController?.pushViewController(nextVC, animated: true)
                       // 성공 시 처리할 내용 추가
                   case .failure(let error):
                       print("이미지 업로드 실패: \(error.localizedDescription)")
                       // 실패 시 처리할 내용 추가
                   }
               }
           case .failure(let error):
               print("API 호출 실패: \(error.localizedDescription)")
               // 실패 시 처리할 내용 추가
           }
        }
    }
    //MARK: - 사진과 앨범 파트
    // 버튼 액션 함수
    @objc func touchUpImageAddButton(button: UIButton) {
        // 갤러리 접근 권한 허용 여부 체크
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                DispatchQueue.main.async {
                    self.showAlert(message: "갤러리를 불러올 수 없습니다. 핸드폰 설정에서 사진 접근 허용을 모든 사진으로 변경해주세요.")
                }
            case .denied, .restricted:
                DispatchQueue.main.async {
                    self.showAlert(message: "갤러리를 불러올 수 없습니다. 핸드폰 설정에서 사진 접근 허용을 모든 사진으로 변경해주세요.")
                }
            case .authorized, .limited: // 모두 허용, 일부 허용
                self.pickImage() // 갤러리 불러오는 동작을 할 함수
            @unknown default:
                print("PHPhotoLibrary::execute - \"Unknown case\"")
            }
        }
    }
    //MARK: - 사진과 앨범 파트
    // 갤러리 불러오기
    func pickImage(){
        let photoLibrary = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

        configuration.selectionLimit = 3 //한번에 가지고 올 이미지 갯수 제한
        configuration.filter = .any(of: [.images]) // 이미지, 비디오 등의 옵션

        DispatchQueue.main.async { // 메인 스레드에서 코드를 실행시켜야함
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            picker.isEditing = true
            self.present(picker, animated: true, completion: nil) // 갤러리뷰 프리젠트
        }
    }
   
    func makeCustomButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("사진 추가")
        attributedTitle.font = .systemFont(ofSize: 18, weight: .bold)
        config.attributedTitle = attributedTitle
        let pointSize = CGFloat(30)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        config.image = UIImage.init(named: "Talk1")
        config.preferredSymbolConfigurationForImage = imageConfig

        config.imagePlacement = .top
        config.background.backgroundColor = .darkGray
        config.baseForegroundColor = .lightGray
        config.cornerStyle = .small

        // 이미지와 텍스트 간격 조절
        config.imagePadding = 12.7
        config.titlePadding = 10

        let customButton = UIButton(configuration: config)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        customButton.translatesAutoresizingMaskIntoConstraints = false

        return customButton
    }
    //MARK: - 사진과 앨범 파트
    @objc func buttonTapped() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            self.currentMode = .camera
            self.openCamera()
        }

        let chooseFromLibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { _ in
            self.currentMode = .album
            self.customButton.isHidden = true
            self.collectionView.isHidden = false
            self.touchUpImageAddButton(button: self.customButton)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        takePhotoAction.setValue(UIColor.white, forKey: "titleTextColor")
        chooseFromLibraryAction.setValue(UIColor.white, forKey: "titleTextColor")
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")

        actionSheetController.addAction(takePhotoAction)
        actionSheetController.addAction(chooseFromLibraryAction)
        actionSheetController.addAction(cancelAction)

        self.present(actionSheetController, animated: true, completion: nil)
    }
    @objc func navigateToTagPlusViewController(_ sender: Any) {
        let tagplusVC = TagPlusViewController()
        tabBarController?.tabBar.isHidden = true //하단 탭바 안보이게 전환

        self.navigationController?.pushViewController(tagplusVC, animated: true)
        print("tagplus click")
    }
    //MARK: - 사진과 앨범 파트
    @objc private func openCamera() {
       #if targetEnvironment(simulator)
       fatalError()
       #endif
       
       AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
         guard isAuthorized else {
           self?.showAlertGoToSetting()
           return
         }
           
         
         DispatchQueue.main.async {
           let pickerController = UIImagePickerController()
           pickerController.sourceType = .camera
           pickerController.allowsEditing = false
           pickerController.mediaTypes = ["public.image"]
           pickerController.delegate = self
           self?.present(pickerController, animated: true)
         }
       }
     }
    
    func showAlertGoToSetting() {
        let alertController = UIAlertController(
          title: "현재 카메라 사용에 대한 접근 권한이 없습니다.",
          message: "설정 > {앱 이름}탭에서 접근을 활성화 할 수 있습니다.",
          preferredStyle: .alert
        )
        let cancelAlert = UIAlertAction(
          title: "취소",
          style: .cancel
        ) { _ in
            alertController.dismiss(animated: true, completion: nil)
          }
        let goToSettingAlert = UIAlertAction(
          title: "설정으로 이동하기",
          style: .default) { _ in
            guard
              let settingURL = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingURL)
            else { return }
            UIApplication.shared.open(settingURL, options: [:])
          }
        [cancelAlert, goToSettingAlert]
          .forEach(alertController.addAction(_:))
        DispatchQueue.main.async {
          self.present(alertController, animated: true)
        }
      }

    }

extension InfoWritingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        // 이미지를 selectedImages 배열에 추가
        selectedImages.append(image)
        
        // 이미지 뷰에 선택된 이미지 표시
        imageView.image = image
        // 버튼을 숨기고 이미지 뷰를 표시하도록 설정
        //addImageButton.isHidden = true
        imageView.isHidden = false
        customButton.isHidden = true // customButton도 함께 숨김

        self.imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -200), //화면 밖으로 이동시킬려고 밖으로 빼냄
            customButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 108),
            customButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -109),
            customButton.heightAnchor.constraint(equalToConstant: 176),
        ])
    }
}
//MARK: - 사진과 앨범 파트
extension InfoWritingViewController: PHPickerViewControllerDelegate {
    // 사진 선택이 끝났을 때 호출되는 함수
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let identifiers = results.compactMap(\.assetIdentifier)
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)

        let group = DispatchGroup()
        fetchResult.enumerateObjects { asset, index, pointer in
//            print("위도: \(asset.location?.coordinate.latitude)")
//            print("경도: \(asset.location?.coordinate.longitude)")
//            print("시간: \(asset.location?.timestamp)")
        }
        for result in results {
            group.enter()
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    guard let self = self else { return }

                    if let error = error {
                        print("Error loading image: \(error)")
                        group.leave()
                        return
                    }

                    if let image = image as? UIImage {
                        selectedImages.append(image)
                    }

                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        group.notify(queue: .main) {
            // 모든 이미지가 로드되었을 때 실행되는 부분
            DispatchQueue.main.async { [self] in
                if self.currentMode == .album {
                    // 앨범 모드일 경우의 처리
                    self.customButton.isHidden = true
                    self.collectionView.isHidden = false
                    self.selectedImages = selectedImages

                    // 이미지가 추가되었을 때 디버깅 정보 출력
                    print("selectedImages contents: \(self.selectedImages)")

                    self.collectionView.reloadData() // collectionView 갱신
                }
            }
            // 이미지 피커를 닫음
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - 사진과 앨범 파트 and 태그 파트
extension InfoWritingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    // 셀 개수 카운팅
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.collectionView { //사진과 앨범 부분
                return selectedImages.count
            } else if collectionView == TagcollectionView { //태그 부분
                return selectedTags.count
            }
            return 0
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == self.collectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
                let image = selectedImages[indexPath.item]
                cell.imageView.image = image
                return cell
           
            } else if collectionView == TagcollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
                let tag = selectedTags[indexPath.item]
                cell.configure(with: tag, image: talk12Image)
                return cell
            }

            return UICollectionViewCell()
    }
    
}

extension InfoWritingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "질문이나 이야기를 해 보세요!" {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "질문이나 이야기를 해 보세요!"
        }
    }
}
//string 동적 계산
extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont, margin: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.width) + margin
    }
}


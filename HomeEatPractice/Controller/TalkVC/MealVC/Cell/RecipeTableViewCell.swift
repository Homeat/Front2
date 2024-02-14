//
//  RecipeTableViewCell.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/11/24.
//

import UIKit
import Then
import AVFoundation
import Photos
import PhotosUI

class RecipeTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "RecipeTableViewCell"
    weak var delegate: RecipeCellDelegate?
    //MARK: - 사진추가 프로퍼티
    
    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 111, height: 111)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "gray2")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    
    //MARK: - 일반프로퍼티
    
    // 스텝을 나타내는 라벨
    lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(r: 187, g: 187, b: 187)
        label.text = "Step 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(UIColor(r: 187, g: 187, b: 187), for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(named: "gray2")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTapped(_ :)), for: .touchUpInside)
        return button
    }()
    
    // 레시피작성 텍스트뷰
    lazy var recipeTextView: UITextView = {
        let textView = UITextView()
        textView.text = "레시피를 작성해주세요."
        textView.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textView.textColor = UIColor(r: 204, g: 204, b: 204)
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(named: "gray4")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.isUserInteractionEnabled = false
        textView.delegate = self
        return textView
    }()
    
    // 재료입력 텍스트필드
    lazy var sourceTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "해당 단계에서 사용된 재료를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 204, g: 204, b: 204)])
        textField.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        textField.textColor = UIColor(r: 204, g: 204, b: 204)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 18.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    // 요리팁 텍스트필드
    lazy var tipTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "해당 단계의 요리팁을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 204, g: 204, b: 204)])
        textField.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        textField.textColor = UIColor(r: 204, g: 204, b: 204)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 18.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    // 아래쪽 경계선
    private let underBorderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 102, g: 102, b: 102)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - cell init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(named: "gray2")
        self.selectionStyle = .none
        setUI()
        setConstrsints()
        recipeTextView.delegate = self
        sourceTextField.delegate = self
        tipTextField.delegate = self
        setupTextFields()
        setupTextView()
        setupTapGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextView() {
        recipeTextView.delegate = self
        recipeTextView.isEditable = true
        recipeTextView.isSelectable = true
    }
    
    func setupTextFields() {
        recipeTextView.isUserInteractionEnabled = true
        recipeTextView.delegate = self
        recipeTextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(recipeTextViewTapped)))
        
        sourceTextField.isUserInteractionEnabled = true
        sourceTextField.delegate = self
        sourceTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sourceTextFieldTapped)))
        
        tipTextField.isUserInteractionEnabled = true
        tipTextField.delegate = self // Ensure delegate assignment
        tipTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tipTextFieldTapped)))
    }
    
    // UITextFieldDelegate method
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // You can perform any additional setup here if needed
        return true
    }
    
    // UITextViewDelegate method
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        // You can perform any additional setup here if needed
        return true
    }
    
    @objc func recipeTextViewTapped() {
        recipeTextView.becomeFirstResponder()
    }
    
    // UITapGestureRecognizer action methods
    @objc func sourceTextFieldTapped() {
        sourceTextField.becomeFirstResponder()
    }
    
    @objc func tipTextFieldTapped() {
        tipTextField.becomeFirstResponder()
    }
    
    func setUI() {
        contentView.addSubview(stepLabel)
        contentView.addSubview(removeButton)
        contentView.addSubview(photoCollectionView)
        contentView.addSubview(recipeTextView)
        contentView.addSubview(sourceTextField)
        contentView.addSubview(tipTextField)
        contentView.addSubview(underBorderLine)
    }
    
    func setConstrsints() {
        NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.5),
            stepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stepLabel.heightAnchor.constraint(equalToConstant: 17),
            
            removeButton.topAnchor.constraint(equalTo: stepLabel.topAnchor),
            removeButton.heightAnchor.constraint(equalToConstant: 17),
            removeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            photoCollectionView.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 15),
            photoCollectionView.leadingAnchor.constraint(equalTo: stepLabel.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: removeButton.trailingAnchor),
            photoCollectionView.heightAnchor.constraint(equalToConstant: 111),
            
            recipeTextView.topAnchor.constraint(equalTo: photoCollectionView.bottomAnchor, constant: 20),
            recipeTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeTextView.heightAnchor.constraint(equalToConstant: 110),
            
            sourceTextField.topAnchor.constraint(equalTo: recipeTextView.bottomAnchor, constant: 18),
            sourceTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sourceTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sourceTextField.heightAnchor.constraint(equalToConstant: 50),
            
            tipTextField.topAnchor.constraint(equalTo: sourceTextField.bottomAnchor, constant: 18),
            tipTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tipTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tipTextField.heightAnchor.constraint(equalToConstant: 50),
            
            underBorderLine.topAnchor.constraint(equalTo: tipTextField.bottomAnchor, constant: 19.5),
            underBorderLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            underBorderLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            underBorderLine.heightAnchor.constraint(equalToConstant: 1),
            underBorderLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    func setupTapGestureRecognizers() {
        let recipeTextViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(recipeTextViewTapped))
        recipeTextView.addGestureRecognizer(recipeTextViewTapGestureRecognizer)
        
        let sourceTextFieldTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sourceTextFieldTapped))
        sourceTextField.addGestureRecognizer(sourceTextFieldTapGestureRecognizer)
        
        let tipTextFieldTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tipTextFieldTapped))
        tipTextField.addGestureRecognizer(tipTextFieldTapGestureRecognizer)
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        print("삭제버튼탭")
        delegate?.didTapRemoveButton(cell: self)
    }
    
    
    // 뷰 컨트롤러를 찾는 메서드
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    
}

//MARK: - 레시피 사진추가 컬렉션뷰 Extension
extension RecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue a reusable cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀을 탭하면 액션 시트를 표시하여 사용자에게 카메라로 촬영 또는 갤러리에서 선택할 수 있도록 합니다.
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "카메라로 촬영", style: .default) { _ in
                self.showImagePicker(sourceType: .camera)
            }
            actionSheet.addAction(cameraAction)
            
            let galleryAction = UIAlertAction(title: "갤러리에서 선택", style: .default) { _ in
                self.showImagePicker(sourceType: .photoLibrary)
            }
            actionSheet.addAction(galleryAction)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            
            if let viewController = findViewController() {
                viewController.present(actionSheet, animated: true, completion: nil)
            }
    }
}

//MARK: - 사진 선택 Extension
extension RecipeTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택한 이미지를 가져옵니다.
        if let pickedImage = info[.originalImage] as? UIImage {
            // 이미지를 선택한 셀의 이미지 뷰에 표시합니다.
            if let indexPath = photoCollectionView.indexPathsForSelectedItems?.first {
                if let cell = photoCollectionView.cellForItem(at: indexPath) as? PhotoCell {
                    cell.plusImageView.image = pickedImage
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        // 사진 촬영을 선택할 수 있도록 코드 추가
            if sourceType == .camera {
                imagePicker.cameraCaptureMode = .photo
            }
            
            imagePicker.delegate = self
            
            if let viewController = findViewController() {
                viewController.present(imagePicker, animated: true, completion: nil)
            }
    }
}

//MARK: - 레시피 텍스트뷰 Extension
extension RecipeTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "레시피를 작성해주세요" {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "레시피를 작성해주세요"
        }
    }
}

// MARK: - 레시피 스텝 테이블뷰 프로토콜
protocol RecipeCellDelegate: AnyObject {
    func didTapRemoveButton(cell: RecipeTableViewCell)
}







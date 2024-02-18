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
    
    var recipeStep = RecipeStep()
    
    let imagePickerController = UIImagePickerController()
    let secondImagePickerController = UIImagePickerController()
    let thirdImagePickerController = UIImagePickerController()
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
    
    lazy var container: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photoAddButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addIcon"), for: .normal)
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
        button.contentMode = .scaleAspectFill
        button.tag = 1
        button.addTarget(self, action: #selector(photoAddButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondPhotoAddButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addIcon"), for: .normal)
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(secondPhotoAddButtonTapped), for: .touchUpInside)
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var thirdPhotoAddButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addIcon"), for: .normal)
        button.backgroundColor = UIColor(r: 54, g: 56, b: 57)
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(thirdPhotoAddButtonTapped), for: .touchUpInside)
        button.tag = 3
        button.translatesAutoresizingMaskIntoConstraints = false
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        // view에 탭 제스처를 추가.
        self.addGestureRecognizer(tapGesture)
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
    
    //MARK: - ViewSet
    func setUI() {
        contentView.addSubview(stepLabel)
        contentView.addSubview(removeButton)
        contentView.addSubview(container)
        container.addArrangedSubview(photoAddButton)
        container.addArrangedSubview(secondPhotoAddButton)
        container.addArrangedSubview(thirdPhotoAddButton)
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
            
            container.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 16),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 111),
            
            photoAddButton.heightAnchor.constraint(equalToConstant: 111),
            photoAddButton.widthAnchor.constraint(equalToConstant: 111),
            
            secondPhotoAddButton.heightAnchor.constraint(equalToConstant: 111),
            secondPhotoAddButton.widthAnchor.constraint(equalToConstant: 111),
            
            thirdPhotoAddButton.heightAnchor.constraint(equalToConstant: 111),
            thirdPhotoAddButton.widthAnchor.constraint(equalToConstant: 111),
            
            recipeTextView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
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
    
    //MARK: - 키보드처리
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 다음 텍스트 필드로 포커스를 이동하는 코드로 수정
        if textField == sourceTextField {
            tipTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func setupTextView() {
        recipeTextView.delegate = self
        recipeTextView.isEditable = true
        recipeTextView.isSelectable = true
    }
    
    func setupTextFields() {
        recipeTextView.isUserInteractionEnabled = true
        recipeTextView.delegate = self
        
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
    
    
    func setupTapGestureRecognizers() {
        let recipeTextViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(recipeTextViewTapped))
        recipeTextView.addGestureRecognizer(recipeTextViewTapGestureRecognizer)
        
        let sourceTextFieldTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sourceTextFieldTapped))
        sourceTextField.addGestureRecognizer(sourceTextFieldTapGestureRecognizer)
        
        let tipTextFieldTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tipTextFieldTapped))
        tipTextField.addGestureRecognizer(tipTextFieldTapGestureRecognizer)
    }
    
    @objc func viewDidTap(gesture: UITapGestureRecognizer) {
        // 뷰를 탭하면 키보드가 내려감.
        self.endEditing(true)
    }
    
    // 텍스트필드에 입력한 내용을 구조체에 저장
    func textFieldDidEndEditing(_ textField: UITextField) {
        // textField에 따라 다르게 동작하도록 if-else 문을 사용합니다.
        if textField == sourceTextField {
            // 첫 번째 텍스트 필드의 편집이 끝났을 때 실행할 코드를 작성합니다.
            print("source텍스트필드 수정.")
            recipeStep.sourceText = sourceTextField.text ?? ""
        } else if textField == tipTextField {
            // 두 번째 텍스트 필드의 편집이 끝났을 때 실행할 코드를 작성합니다.
            print("tip텍스트필드 수정.")
            recipeStep.sourceText = tipTextField.text ?? ""
        }
    }
    
    //MARK: - 사진추가 메서드
    @objc func photoAddButtonTapped(_ sender: UIButton) {
        showImagePicker(imagePickerController: imagePickerController)
    }
    
    @objc func secondPhotoAddButtonTapped(_ sender: UIButton) {
        showImagePicker(imagePickerController: secondImagePickerController)
    }
    
    @objc func thirdPhotoAddButtonTapped(_ sender: UIButton) {
        showImagePicker(imagePickerController: thirdImagePickerController)
    }
    
    func showImagePicker(imagePickerController: UIImagePickerController) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Action for selecting photo from album
        let selectPhotoAction = UIAlertAction(title: "앨범에서 선택", style: .default) { (_) in
            self.presentImagePicker(imagePickerController, sourceType: .photoLibrary)
        }
        
        // Action for taking photo using camera
        let takePhotoAction = UIAlertAction(title: "카메라로 촬영", style: .default) { (_) in
            self.presentImagePicker(imagePickerController, sourceType: .camera)
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(selectPhotoAction)
        alertController.addAction(takePhotoAction)
        alertController.addAction(cancelAction)
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func presentImagePicker(_ imagePickerController: UIImagePickerController, sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("Source type \(sourceType.rawValue) is not available.")
            return
        }
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        
        if sourceType == .camera {
            imagePickerController.cameraCaptureMode = .photo
        }
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - 셀 삭제 메서드
    @objc func deleteButtonTapped(_ sender: UIButton) {
        print("삭제버튼탭")
        delegate?.didTapRemoveButton(cell: self)
    }
    
    var imageArray: [UIImage?] = []
}
//MARK: - 레시피 텍스트뷰 Extension
extension RecipeTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "레시피를 작성해주세요." {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "레시피를 작성해주세요."
        }
        recipeStep.recipeText = textView.text
    }
}


//MARK: - 사진추가 프로토콜
extension RecipeTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Delegate method called when image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }

        switch picker {
        case imagePickerController:
            photoAddButton.setImage(pickedImage, for: .normal)
            imageArray.append(pickedImage)
            print("첫번째 사진추가")
        case secondImagePickerController:
            secondPhotoAddButton.setImage(pickedImage, for: .normal)
            imageArray.append(pickedImage)
            print("두번째 사진추가")
        case thirdImagePickerController:
            thirdPhotoAddButton.setImage(pickedImage, for: .normal)
            imageArray.append(pickedImage)
            print("세번째 사진추가")
        default:
            break
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Delegate method called when user cancels image picking
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - RecipeViewController에서 구조체를 사용하기 위한 프로토콜
protocol RecipeCellDelegate: AnyObject {
    func didTapRemoveButton(cell: RecipeTableViewCell)
    func didSaveRecipeStep(_ recipeStep: RecipeStep)
}









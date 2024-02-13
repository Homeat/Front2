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

class RecipeTableViewCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let identifier = "RecipeTableViewCell"
    
    //MARK: - 사진추가 프로퍼티
    // 사진 추가 버튼
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진 추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        return button
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
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstrsints()
        recipeTextView.delegate = self
        sourceTextField.delegate = self
        tipTextField.delegate = self
        setupTextFields()
        setupTextView()
        setupTapGestureRecognizers()
//        contentView.isUserInteractionEnabled = false
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
        contentView.addSubview(addButton)
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
            
            
            addButton.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 15),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 111),
            addButton.widthAnchor.constraint(equalToConstant: 111),
            
            recipeTextView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
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
    // 사진 추가 액션
    @objc func addPhoto(sender: UIButton) {
        guard let viewController = self.findViewController() else {
            print("뷰 컨트롤러를 찾을 수 없습니다.")
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: "사진 추가", message: "사진을 가져올 방법을 선택하세요", preferredStyle: .actionSheet)
        
        let albumAction = UIAlertAction(title: "앨범에서 선택", style: .default) { (action) in
            imagePickerController.sourceType = .photoLibrary
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "카메라로 촬영", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                viewController.present(imagePickerController, animated: true, completion: nil)
            } else {
                // 카메라 사용 불가능한 경우에 대한 처리
                print("카메라를 사용할 수 없습니다.")
            }
        }
        
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(albumAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        // 액션 시트를 현재 뷰 컨트롤러에서 표시
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // 사진 추가 액션
    @objc func deleteButtonTapped(sender: UIButton) {
        print("삭제버튼탭")
    }
    
    
    // 이미지 선택 또는 촬영 완료 시 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택한 이미지 처리
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 이미지를 사용하여 원하는 작업 수행
            // 예를 들어, 이미지뷰에 선택한 이미지 표시 등
        }
        
        // 이미지 피커 컨트롤러 닫기
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 선택 또는 촬영 취소 시 호출되는 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커 컨트롤러 닫기
        picker.dismiss(animated: true, completion: nil)
    }
    
    // ... 이전 코드 생략 ...
    
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




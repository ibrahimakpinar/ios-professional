//
//  PasswordTextField.swift
//  Password
//
//  Created by ibrahim AKPINAR on 26.02.2023.
//

import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    
    func editingChanged(_ sender: PasswordTextField)
}

final class PasswordTextField: UIView {
    
    // MARK: - Delegates
    
    weak var delegate: PasswordTextFieldDelegate?
    
    // MARK: - Private fields
    
    private let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    private let placeHolderText: String
    private let eyeButton = UIButton(type: .custom)
    private let dividerView = UIView()
    private let errorLablel = UILabel()
    
    // MARK: - fields
    let textField = UITextField()

    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
}

private extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Lock Image View
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Text Field
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        textField.addTarget(
            self,
            action: #selector(textFieldEditingChanged),
            for: .editingChanged
        )
        
        // Eye Button

        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(
            self,
            action: #selector(togglePasswordView),
            for: .touchUpInside
        )
        
        // Divider View
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        // Error Label
        
        errorLablel.translatesAutoresizingMaskIntoConstraints = false
        errorLablel.font = .preferredFont(forTextStyle: .footnote)
        errorLablel.textColor = .systemRed
        errorLablel.text = "Your password must meet the requirements below."
        errorLablel.numberOfLines = 0
        errorLablel.lineBreakMode = .byCharWrapping
        errorLablel.isHidden = true
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLablel)
        
        // Lock Image Constraints
        
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        // Password Text Field Constraints
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1)
        ])
        
        // Eye Button Constraints
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Divider View
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // Error Lablel
        NSLayoutConstraint.activate([
            errorLablel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4),
            errorLablel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLablel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Content Hugging & Content Compression Resistance Priority
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}

// MARK: - Private Functions

private extension PasswordTextField {
    
    @objc func togglePasswordView() {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self)
    }
}

// MARK: - UITextFieldDelegate

extension PasswordTextField: UITextFieldDelegate {}



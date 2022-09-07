//
//  LoginView.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 29.07.2022.
//

import UIKit

final class LoginView: UIView {
    
    // MARK: - UIViews
    
    let stackView = UIStackView()
    let usernameTextFiled = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented yet!")
    }
}

extension LoginView {
    
    private enum LayoutConstants {
        static let stackViewSpacing: CGFloat = 8
        static let dividerHeight: CGFloat = 1
        static let cornerRadius: CGFloat = 5
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = LayoutConstants.stackViewSpacing
        
        usernameTextFiled.translatesAutoresizingMaskIntoConstraints = false
        usernameTextFiled.placeholder = "Username"
        usernameTextFiled.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.enablePasswordToggle()
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        layer.cornerRadius = LayoutConstants.cornerRadius
        clipsToBounds = true
    }
    
    func layout() {
        stackView.addArrangedSubview(usernameTextFiled)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
  	
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            dividerView.heightAnchor.constraint(equalToConstant: LayoutConstants.dividerHeight)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextFiled.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

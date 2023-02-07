//
//  UIViewController+Extension.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 24.10.2022.
//

import UIKit

extension UIViewController {
    func createLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.741,
                                       green: 0.741,
                                       blue: 0.741,
                                       alpha: 1)
        return view
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.addTarget(self,
                         action: action,
                         for: .touchUpInside)
        button.setTitle(title,
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold",
                                         size: 15)
        button.backgroundColor = UIColor(red: 0,
                                         green: 0.478,
                                         blue: 1,
                                         alpha: 1)
        button.layer.cornerRadius = 24
        return button
    }
    
    func createDisabledButton(title: String, action: Selector) -> UIButton {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.isEnabled = false
        button.addTarget(self,
                         action: action,
                         for: .touchUpInside)
        button.setTitle(title,
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold",
                                         size: 15)
        button.backgroundColor = #colorLiteral(red: 0.4964438081, green: 0.7357916236, blue: 0.9985125661, alpha: 1)
        button.layer.cornerRadius = 24
        return button
    }

    func createAnIntervalSelectButton(title: String, action: Selector) -> UIButton {
        let button = UIButton.init(type: .system)
        button.tintColor = .black
        button.addTarget(self,
                         action: action,
                         for: .touchUpInside)
        button.setTitle(title,
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold",
                                         size: 22)
        button.layer.borderColor = UIColor(red: 0.592,
                                           green: 0.592,
                                           blue: 0.592,
                                           alpha: 1).cgColor
        button.layer.cornerRadius = 2
        return button
    }

    func createTextField(placeholder: String, keyboardType: UIKeyboardType) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = keyboardType
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.62,
                                                                         green: 0.62,
                                                                         blue: 0.62,
                                                                         alpha: 1),
                         NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Regular",
                                                             size: 14) as Any])
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.textColor = .black
        if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
            let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(templateImage,
                                 for: .normal)
            clearButton.tintColor = UIColor(red: 0.62,
                                            green: 0.62,
                                            blue: 0.62,
                                            alpha: 1)
        }
        return textField
    }
    
    func createEmptyTextField(keyboardType: UIKeyboardType) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = keyboardType
        textField.autocorrectionType = .no
        return textField
    }
    
    func createBlurEffect() -> UIVisualEffectView {
        let view = UIVisualEffectView()
        view.isHidden = true
        view.effect = UIBlurEffect(style: .dark)
        return view
    }
    
    func createTitleLabel(title: String) -> UILabel {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeueCyr-Black",
                           size: 28)
        view.text = title
        return view
    }
    
    func createHeaderLabel(title: String) -> UILabel {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeueCyr-Black",
                           size: 16)
        view.text = title
        view.isEnabled = false
        return view
    }
    
    func createColorLabel(title: String) -> UILabel {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeueCyr-Black",
                           size: 9)
        view.text = title
        return view
    }
    
    func createFieldDescriptionTextField(title: String) -> UILabel {
        let label = UILabel()
        label.isHidden = true
        label.text = title
        label.textColor = UIColor(red: 0.62,
                                  green: 0.62,
                                  blue: 0.62,
                                  alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Medium",
                            size: 11)
        return label
    }
}



//  CustomTextField.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 16/02/23.

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.font = font
        self.autocorrectionType = .no
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black.withAlphaComponent(0.3)
        ]
        self.attributedPlaceholder = NSAttributedString(string: "Загаловак", attributes: attributes)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

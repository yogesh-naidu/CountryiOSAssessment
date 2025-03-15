//
//  UITextField.swift
//  Assignment
//
//

import UIKit

extension UITextField{
    
    func placholderColor(color: UIColor) {
        guard let text = self.placeholder else { return }
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}

//
//  UITableView.swift
//  Assignment
//
//

import Foundation
import UIKit

extension UITableView{
    
    func restore() {
        self.backgroundView = nil
    }
    
    func setEmptyMessage(_ message: String, color: UIColor = .black) {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
           
           let messageLabel = UILabel()
           messageLabel.text = message
           messageLabel.textColor = color
           messageLabel.numberOfLines = 0
           messageLabel.textAlignment = .center
           
           // Enable Auto Layout
           messageLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(messageLabel)
           
           // Center the label within the view
           NSLayoutConstraint.activate([
               messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
               messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
           ])
           
           self.backgroundView = view
           self.separatorStyle = .none
       }
}

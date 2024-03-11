//
//  UIView + Ext.swift
//  OMG-Test
//
//  Created by Andrey on 11.03.2024.
//

import UIKit

extension UIView {
    func forAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setSimpleConstraints(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
        ])
    }
}

//
//  UICollectionViewCell + Ext.swift
//  OMG-Test
//
//  Created by Andrey on 11.03.2024.
//

import UIKit

extension UICollectionViewCell {
    func animateStart() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func animateStop() {
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
}

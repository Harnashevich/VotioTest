//
//  Extensions.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 27.03.24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    func addBorderColor(_ views: UIView...) {
        views.forEach {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        }
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.width/2
    }
}

extension NSLayoutConstraint {
    
    static func activate(_ constraints: [NSLayoutConstraint]) {
        constraints.forEach {
            ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            $0.isActive = true
        }
    }
}

extension UIStackView {

    func addArrangedSubviews(_ views: UIView...) {
        addArrangedSubviews(views)
    }

    private func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview(_:))
    }
}


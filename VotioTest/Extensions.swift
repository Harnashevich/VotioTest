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

extension String {
    
    var currentFormatt: String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let oldDate = olDateFormatter.date(from: self)
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        convertDateFormatter.dateFormat = "d MMMM HH:mm"
        
        return convertDateFormatter.string(from: oldDate ?? Date())
    }
}

extension UIButton {
    
    func setScoreWithPlus(score: Int) {
        self.setTitle("" + String(score), for: .normal)
    }
    
    func set(score: Int) {
        self.setTitle(String(score), for: .normal)
    }
}

extension UILabel {
    
    func setText(with number: Int?) {
        guard let number = number else {
            self.text = ""
            return
        }
        self.text = String(number)
    }
    
    func setText(with number: Double?) {
        guard let number = number else {
            self.text = ""
            return
        }
        self.text = String(number)
    }
    
    func setWithPlus(number: Double, isChangeTextColor: Bool) {
        let text = String(number)
        if number > 0 {
            self.text = "" + text
            if isChangeTextColor {
                self.textColor = .green
            }
        } else {
            if isChangeTextColor {
                self.textColor = .red
            }
            self.text = text
        }
    }
}

extension Double {
    
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = (multiplier * self).rounded() // move the decimal right
        let originalDecimal = newDecimal / multiplier // move the decimal back
        return originalDecimal
    }
}

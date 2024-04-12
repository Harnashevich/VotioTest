//
//  RatingView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 10.04.24.
//

import UIKit

public final class RatingView: UIView {
    
    //MARK: - UI
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5.6"
        label.font = .systemFont(ofSize: 30, weight: .black)
        return label
    }()
    
    private lazy var ratingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "User Rating"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private lazy var minusView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var plusView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemGray6
        return view
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
        configureRating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods

extension RatingView {
    
    private func configureUI() {
        addSubviews(ratingLabel, ratingDescriptionLabel, minusView, plusView)
        addBorderColor(minusView, plusView)
    }
    
    func configureRating() {
        let rating = Double.random(in: -10...10).reduceScale(to: 1)
        
        ratingLabel.text = "\(rating)"
        ratingLabel.textColor = (rating < 0) ? .red : .blue
        
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = (rating < 0) ? .red : .blue
        
        if (rating < 0) {
            view.frame = CGRect(
                x: minusView.frame.size.width * ((10 + rating)/10),
                y: 0,
                width: (minusView.frame.size.width * 0.1) * (-rating),
                height: minusView.frame.size.height
            )
            minusView.addSubview(view)
        } else {
            view.frame = CGRect(
                x: 0,
                y: 0,
                width: (plusView.frame.size.width * 0.1) * rating,
                height: plusView.frame.size.height
            )
            plusView.addSubview(view)
        }
    }
}

//MARK: - Layout

extension RatingView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            ratingDescriptionLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            ratingDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            minusView.topAnchor.constraint(equalTo: ratingDescriptionLabel.bottomAnchor, constant: 10),
            minusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            minusView.heightAnchor.constraint(equalToConstant: 8),
            minusView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            minusView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            plusView.topAnchor.constraint(equalTo: ratingDescriptionLabel.bottomAnchor, constant: 10),
            plusView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            plusView.heightAnchor.constraint(equalToConstant: 8),
            plusView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            plusView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//
//  RatingView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 10.04.24.
//

import UIKit

public final class RatingView: UIView {
    
    //MARK: - UI
    
    private lazy var mainRatingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .black)
        return label
    }()
    
    private lazy var ratingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "User Rating"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var minusView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var plusView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var minusTenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "-10"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var tenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "10"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
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
        addSubviews(mainRatingView)
        addBorderColor(minusView, plusView)
        mainRatingView.addSubviews(
            ratingLabel,
            ratingDescriptionLabel,
            separatorView,
            minusView,
            plusView,
            minusTenLabel,
            tenLabel
        )
    }
    
    func configureRating() {
        let rating = Double.random(in: -10...10).reduceScale(to: 1)
        
        ratingLabel.text = "\(rating)"
        ratingLabel.textColor = (rating < 0) ? .red : .blue
        
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = (rating < 0) ? .red : .blue
        minusView.addSubview(view)
        if (rating < 0) {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: minusView.topAnchor),
                view.bottomAnchor.constraint(equalTo: minusView.bottomAnchor),
                view.trailingAnchor.constraint(equalTo: minusView.trailingAnchor),
                view.widthAnchor.constraint(equalTo: minusView.widthAnchor, multiplier: abs(rating) * 0.1)
            ])
        } else {
            plusView.addSubview(view)
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: plusView.topAnchor),
                view.bottomAnchor.constraint(equalTo: plusView.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: plusView.leadingAnchor),
                view.widthAnchor.constraint(equalTo: plusView.widthAnchor, multiplier: abs(rating) * 0.1)
            ])
        }
    }
}

//MARK: - Layout

extension RatingView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainRatingView.topAnchor.constraint(equalTo: topAnchor),
            mainRatingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainRatingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainRatingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainRatingView.heightAnchor.constraint(equalToConstant: 100),
            
            ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ratingLabel.topAnchor.constraint(equalTo: mainRatingView.topAnchor, constant: 10),
            
            ratingDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ratingDescriptionLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            
            separatorView.heightAnchor.constraint(equalToConstant: 5),
            separatorView.widthAnchor.constraint(equalToConstant: 1),
            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: ratingDescriptionLabel.bottomAnchor, constant: 10),
            
            minusView.heightAnchor.constraint(equalToConstant: 5),
            minusView.leadingAnchor.constraint(equalTo: mainRatingView.leadingAnchor, constant: 20),
            minusView.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: -10),
            minusView.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor),
            
            plusView.heightAnchor.constraint(equalToConstant: 5),
            plusView.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 10),
            plusView.trailingAnchor.constraint(equalTo: mainRatingView.trailingAnchor, constant: -20),
            plusView.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor),
            
            minusTenLabel.leadingAnchor.constraint(equalTo: minusView.leadingAnchor),
            minusTenLabel.bottomAnchor.constraint(equalTo: minusView.topAnchor, constant: -5),
            
            tenLabel.trailingAnchor.constraint(equalTo: plusView.trailingAnchor),
            tenLabel.bottomAnchor.constraint(equalTo: plusView.topAnchor, constant: -5),
        ])
    }
}

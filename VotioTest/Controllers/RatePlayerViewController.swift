//
//  RatePlayerViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 28.03.24.
//

import UIKit

public final class RateViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var rateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Rate"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var deselectButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightGray.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Deselect", for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubviews(rateView, titleLabel, topStackView, bottomStackView, deselectButton)
        view.addBorderColor(rateView)
        rateView.addSubview(closeButton)
        
        for _ in 0...4 {
            let button: UIButton = {
                let button = UIButton()
                button.setTitle("+10", for: .normal)
                button.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
                button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
                button.backgroundColor = .blue.withAlphaComponent(0.5)
                return button
            }()
            
            topStackView.addArrangedSubview(button)
        }
        
        for _ in 0...4 {
            let button: UIButton = {
                let button = UIButton()
                button.setTitle("-1", for: .normal)
                button.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
                button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
                button.backgroundColor = .blue.withAlphaComponent(0.5)
                return button
            }()

            bottomStackView.addArrangedSubview(button)
        }
        setConstraints()
    }
    
    public override func viewWillLayoutSubviews() {
        topStackView.arrangedSubviews.forEach {
            $0.makeCircle()
        }
        bottomStackView.arrangedSubviews.forEach {
            $0.makeCircle()
        }
        self.topStackView.layoutIfNeeded()
        self.bottomStackView.layoutIfNeeded()
    }
}

//MARK: - Methods

extension RateViewController {
    
    @objc private func closeScreen() {
        dismiss(animated: true)
    }
}

//MARK: - Layout

extension RateViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 30),
            
            rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: rateView.centerXAnchor),
            
            topStackView.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 90),
            topStackView.leadingAnchor.constraint(equalTo: rateView.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            bottomStackView.leadingAnchor.constraint(equalTo: rateView.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            
            deselectButton.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 20),
            deselectButton.leadingAnchor.constraint(equalTo: rateView.leadingAnchor, constant: 20),
            deselectButton.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            deselectButton.heightAnchor.constraint(equalToConstant: 40),
            deselectButton.bottomAnchor.constraint(equalTo: rateView.bottomAnchor, constant: -20)
        ])
    }
}

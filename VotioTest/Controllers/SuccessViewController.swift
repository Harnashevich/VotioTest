//
//  SuccessViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 12.06.24.
//

import UIKit

public final class SuccessViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var successView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "successImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Your vote has been counted"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
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
        view.addSubviews(successView)
        successView.addSubviews(imageView, textLabel, closeButton)
        
        setConstraints()
    }
}

//MARK: - Methods

extension SuccessViewController {
   
    @objc private func closeButtonTap() {
        self.dismiss(animated: false)
    }
}

//MARK: - Layout

extension SuccessViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            successView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            successView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            successView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: successView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: successView.topAnchor, constant: 20),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: successView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: successView.trailingAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: successView.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 120),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.bottomAnchor.constraint(equalTo: successView.bottomAnchor, constant: -20)
        ])
    }
}

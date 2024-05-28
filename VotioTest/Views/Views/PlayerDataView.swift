//
//  PlayerDataView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 10.04.24.
//

import UIKit

public final class PlayerDataView: UIView {
    
    //MARK: - UI
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10/03/1999"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "182cm/75kg"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "🇩🇪 Germany"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .white
        return label
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods

extension PlayerDataView {
    
    private func configureUI() {
        backgroundColor = .systemGray6
        addSubviews(stackView)
        stackView.addArrangedSubviews(dateLabel, countryLabel, weightLabel)
    }
}

//MARK: - Layout

extension PlayerDataView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
} 

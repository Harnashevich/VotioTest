//
//  PlayerCell.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 28.03.24.
//

import UIKit

public final class PlayerCell: UITableViewCell {
    
    static let identifier = String(describing: PlayerCell.self)
    
    //MARK: - UI
    
    private lazy var playerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var playerImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray.withAlphaComponent(0.5)
        image.layer.cornerRadius = 8
        image.image = UIImage(systemName: "soccerball")
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.text = "Lionel Messi"
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.backgroundColor = .red.withAlphaComponent(0.1)
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.text = "Defender"
        return label
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private var scoreLabel: UILabel = {
        var label = UILabel()
        label.text = "5.0"
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.isHidden = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.backgroundColor = .blue.withAlphaComponent(0.2)
        return label
    }()
    
    private var plusLabel: UILabel = {
        var label = UILabel()
        label.text = "+"
        label.textColor = .blue
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        //        label.isHidden = true
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = .blue.withAlphaComponent(0.2)
        return label
    }()
    
    //MARK: - Initialization
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods

extension PlayerCell {
    
    private func configureUI() {
        contentView.addSubviews(
            playerView,
            playerImageView,
            nameLabel,
            positionLabel,
            stackView
        )
        stackView.addArrangedSubviews(scoreLabel, plusLabel)
        
        addBorderColor(playerView, playerImageView)
    }
    
    func configureCell() {
    }
}

//MARK: - Layout

extension PlayerCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            playerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            playerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            playerImageView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 10),
            playerImageView.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 10),
            playerImageView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -10),
            playerImageView.heightAnchor.constraint(equalToConstant: 50),
            playerImageView.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: playerImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: playerView.trailingAnchor, constant: -100),
            
            positionLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 20),
            positionLabel.bottomAnchor.constraint(equalTo: playerImageView.bottomAnchor),
            positionLabel.trailingAnchor.constraint(lessThanOrEqualTo: playerView.trailingAnchor, constant: -100),
            
            stackView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: playerView.centerYAnchor),
            
            scoreLabel.heightAnchor.constraint(equalToConstant: 40),
            scoreLabel.widthAnchor.constraint(equalToConstant: 40),
            
            plusLabel.heightAnchor.constraint(equalToConstant: 40),
            plusLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}

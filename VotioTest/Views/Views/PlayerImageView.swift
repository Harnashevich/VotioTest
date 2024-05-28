//
//  PlayerImageView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 27.05.24.
//

import UIKit

public final class PlayerImageView: UIView {
    
    //MARK: - UI
    
    private lazy var playerBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "playerBackgroundView")
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var playerImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray.withAlphaComponent(0.5)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 50, weight: .black)
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .black)
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
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

extension PlayerImageView {
    
    private func configureUI() {
        addSubviews(playerBackgroundImageView, bottomView)
        playerBackgroundImageView.addSubviews(numberLabel, playerImageView, positionLabel)
    }
    
    func setPlayer(with player: Player?) {
        numberLabel.text = player?.number
        playerImageView.sd_setImage(
            with: URL(string: player?.photo ?? String()),
            placeholderImage: UIImage(systemName: "soccerball")
        )
        
        positionLabel.text = switch player?.amplua {
        case "Goalkeeper": "GK"
        case "Defender": "D"
        case "Midfield": "M"
        case "Forward": "F"
        case .none: " "
        case .some(_): " "
        }
        
    }
}

//MARK: - Layout

extension PlayerImageView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            playerBackgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            playerBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerBackgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            playerImageView.topAnchor.constraint(equalTo: playerBackgroundImageView.topAnchor, constant: 20),
            playerImageView.bottomAnchor.constraint(equalTo: playerBackgroundImageView.bottomAnchor, constant: -20),
            playerImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            playerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            numberLabel.leadingAnchor.constraint(equalTo: playerBackgroundImageView.leadingAnchor, constant: 15),
            numberLabel.topAnchor.constraint(equalTo: playerImageView.topAnchor),
            
            positionLabel.trailingAnchor.constraint(equalTo: playerBackgroundImageView.trailingAnchor, constant: -15),
            positionLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            
            bottomView.heightAnchor.constraint(equalToConstant: 20),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
}


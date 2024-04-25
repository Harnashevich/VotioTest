//
//  PlayerDataView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 10.04.24.
//

import UIKit

public final class PlayerDataView: UIView {
    
    //MARK: - UI
    
    private lazy var ampluaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .blue.withAlphaComponent(0.2)
        label.textColor = .blue
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 25
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "🗓️ 10.03.1999"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 22
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "👤 182cm/75kg"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 22
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "🇩🇪 Germany"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 22
        return label
    }()
    
    private lazy var footLabel: UILabel = {
        let label = UILabel()
        label.text = "👣 Left foot"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 22
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
        addSubviews(ampluaLabel, dateLabel, weightLabel, countryLabel, footLabel)
        addBorderColor(dateLabel, weightLabel, countryLabel, footLabel)
    }
    
    func configureView(with player: Player) {
        ampluaLabel.text = "\(player.amplua), \(player.number)"
    }
}

//MARK: - Layout

extension PlayerDataView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ampluaLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ampluaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ampluaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ampluaLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: ampluaLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 44),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.47),
            
            weightLabel.topAnchor.constraint(equalTo: ampluaLabel.bottomAnchor, constant: 20),
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weightLabel.heightAnchor.constraint(equalToConstant: 44),
            weightLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.47),
            
            countryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            countryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countryLabel.heightAnchor.constraint(equalToConstant: 44),
            countryLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.47),
            
            footLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10),
            footLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            footLabel.heightAnchor.constraint(equalToConstant: 44),
            footLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.47),
            footLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
} 

//
//  StatsView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 10.04.24.
//

import UIKit

public final class StatsView: UIView {
    
    //MARK: - UI
    
    private struct StatsModel {
        var stats: String
        var count: Int
    }
    
    private lazy var topStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private lazy var bottomStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    //MARK: - Variables
    
    private var statsModel: [StatsModel] = [
        .init(stats: "Matches", count: Int.random(in: 40...60)),
        .init(stats: "Goals", count: Int.random(in: 0...20)),
        .init(stats: "Assists", count: Int.random(in: 0...30))
    ]
    
    private var cardsModel: [StatsModel] = [
        .init(stats: "Yellow Cards", count: Int.random(in: 0...10)),
        .init(stats: "Red Cards", count: Int.random(in: 0...5))
    ]
    
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

extension StatsView {
    
    private func configureUI() {
        addSubviews(topStack, bottomStack)
        
        for stats in statsModel {
            let view = UIView()
            view.layer.cornerRadius = 8
            topStack.addArrangedSubviews(view)
            addBorderColor(view)
            
            let countLabel = UILabel()
            countLabel.text = "\(stats.count)"
            countLabel.font = .systemFont(ofSize: 25, weight: .heavy)
            countLabel.textColor = .blue
            countLabel.textAlignment = .center
            view.addSubview(countLabel)
            
            let titleLabel = UILabel()
            titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
            titleLabel.textColor = .black
            titleLabel.textAlignment = .center
            titleLabel.text = stats.stats
            view.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                countLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 5),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
        
        for card in cardsModel {
            let view = UIView()
            view.layer.cornerRadius = 8
            bottomStack.addArrangedSubviews(view)
            addBorderColor(view)
            
            let countLabel = UILabel()
            countLabel.text = "\(card.count)"
            countLabel.font = .systemFont(ofSize: 25, weight: .heavy)
            countLabel.textColor = (card.stats == "Yellow Cards") ? .systemYellow : .red
            countLabel.textAlignment = .center
            view.addSubview(countLabel)
            
            let titleLabel = UILabel()
            titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
            titleLabel.textColor = .black
            titleLabel.textAlignment = .center
            titleLabel.text = card.stats
            view.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                countLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 5),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    }
}

//MARK: - Layout

extension StatsView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            topStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            topStack.heightAnchor.constraint(equalToConstant: 80),
            
            bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 10),
            bottomStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bottomStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            bottomStack.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

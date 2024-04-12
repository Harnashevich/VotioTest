//
//  MastershipCell.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 11.04.24.
//

import UIKit

public final class MastershipCell: UITableViewCell {
    
    static let identifier = String(describing: MastershipCell.self)
    
    //MARK: - UI
    
    private lazy var mastershipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var mastershipView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .blue
        return view
    }()
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        mastershipView.removeFromSuperview()
        mastershipLabel.text = nil
    }
}

//MARK: - Methods

extension MastershipCell {
    
    private func configureUI() {
        addSubviews(mastershipLabel, countLabel, lineView)
        addBorderColor(lineView)
    }
    
    func configureCell(
        rating: Int,
        title: String
    ) {
        mastershipLabel.text = title
        countLabel.text = "\(rating)"
        lineView.addSubview(mastershipView)
        
        NSLayoutConstraint.activate([
            mastershipView.topAnchor.constraint(equalTo: lineView.topAnchor),
            mastershipView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            mastershipView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            mastershipView.widthAnchor.constraint(equalTo: lineView.widthAnchor, multiplier: CGFloat(rating) * 0.01)
        ])
    }
}

//MARK: - Layout

extension MastershipCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mastershipLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mastershipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mastershipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
           
            countLabel.centerYAnchor.constraint(equalTo: mastershipLabel.centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            lineView.heightAnchor.constraint(equalToConstant: 8),
            lineView.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

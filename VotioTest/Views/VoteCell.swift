//
//  VoteCell.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 27.03.24.
//

import UIKit

public final class VoteCell: UITableViewCell {
    
    static let identifier = String(describing: VoteCell.self)
    
    //MARK: - UI
    
    private lazy var voteView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .link.withAlphaComponent(0.15)
        return view
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Голосование за звание лучшего"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .blue.withAlphaComponent(0.1)
        label.textAlignment = .center
        label.text = " 12.03.2024 14:30 "
        return label
    }()
    
    private lazy var ballImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "VotioLogo")
        return image
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .blue
        return image
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
        titleLabel.text = nil
        dateLabel.text = nil
    }
}

//MARK: - Methods

extension VoteCell {
    
    private func configureUI() {
        addBorderColor(voteView, titleView)
        contentView.addSubviews(voteView, titleView, dateLabel, calendarImageView)
        titleView.addSubviews(ballImageView, titleLabel)
    }
    
    func configureCell(with poll: Poll) {
        titleLabel.text = "\(poll.playersVotingType) " + poll.title
        let pollDate = "\(poll.dateStart.currentFormatt) - \(poll.dateEnd.currentFormatt)"
        dateLabel.text = (poll.isArchive == 0) ? pollDate : "Finished"
    }
}

//MARK: - Layout

extension VoteCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            voteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            voteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            voteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            voteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            titleView.topAnchor.constraint(equalTo: voteView.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: voteView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: voteView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: voteView.bottomAnchor, constant: -50),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            calendarImageView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
            calendarImageView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            
            
            ballImageView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            ballImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            ballImageView.widthAnchor.constraint(equalToConstant: 100),
            ballImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

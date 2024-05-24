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

    private lazy var xImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "multiply")
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var firstTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var secondTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var leageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .blue
        label.text = "Vote"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "voteBackgroundView")
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        return image
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "calendarBlackIcon")
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
        firstTeamLabel.text = nil
        secondTeamLabel.text = nil
        titleLabel.text = nil
        leageLabel.text = nil
        xImageView.isHidden = true
        dateLabel.text = nil
    }
}

//MARK: - Methods

extension VoteCell {
    
    private func configureUI() {
        contentView.addSubviews(
            dateLabel,
            calendarImageView,
            backgroundImageView,
            xImageView,
            firstTeamLabel,
            secondTeamLabel,
            titleLabel,
            leageLabel
        )
        backgroundImageView.addSubview(voteLabel)
    }
    
    func configureCell(with poll: Poll) {
//        titleLabel.text = poll.title
        
        let matchTeamsArray = poll.title.components(separatedBy: " x ")
        if matchTeamsArray.count == 2 {
            let firstTeam = matchTeamsArray[0]
            let secondTeam = matchTeamsArray[1]
            
            xImageView.isHidden = false
            
            firstTeamLabel.text = firstTeam
            secondTeamLabel.text = secondTeam
        } else {
            xImageView.isHidden = true
            titleLabel.text = poll.title
        }
        
        leageLabel.text = poll.subtitle
        
        let pollDate = "\(poll.dateStart.currentFormatt)"
        dateLabel.text = (poll.isArchive == 0) ? pollDate : "Finished"
    }
}

//MARK: - Layout

extension VoteCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: calendarImageView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor, constant: 10),
            
            calendarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            calendarImageView.topAnchor.constraint(equalTo: topAnchor),
            calendarImageView.heightAnchor.constraint(equalToConstant: 20),
            calendarImageView.widthAnchor.constraint(equalToConstant: 20),
            
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            xImageView.heightAnchor.constraint(equalToConstant: 12),
            xImageView.widthAnchor.constraint(equalToConstant: 12),
            xImageView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 25),
            xImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            firstTeamLabel.centerYAnchor.constraint(equalTo: xImageView.centerYAnchor),
            firstTeamLabel.trailingAnchor.constraint(equalTo: xImageView.leadingAnchor, constant: -10),
            firstTeamLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
            
            secondTeamLabel.centerYAnchor.constraint(equalTo: xImageView.centerYAnchor),
            secondTeamLabel.leadingAnchor.constraint(equalTo: xImageView.trailingAnchor, constant: 10),
            secondTeamLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: xImageView.centerYAnchor),
            
            leageLabel.topAnchor.constraint(equalTo: xImageView.bottomAnchor, constant: 20),
            leageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            leageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            leageLabel.heightAnchor.constraint(equalToConstant: 20),
            
            voteLabel.topAnchor.constraint(equalTo: leageLabel.bottomAnchor, constant: 10),
            voteLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            voteLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            voteLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor)
        ])
    }
}

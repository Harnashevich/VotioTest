//
//  VoteHeaderView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 24.05.24.
//

import UIKit

class VoteHeaderView: UICollectionReusableView {
    
    static let identifier = String(describing: VoteHeaderView.self)
    
    private lazy var voteBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "playerBackgroundView")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var xImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "multiply")
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        return label
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
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
     override init(frame: CGRect) {
         super.init(frame: frame)
         configureUI()
         setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //MARK: - Callback
    
    var productTapped: (()->())?
    
    private func configureUI() {
        addSubviews(
            voteBackgroundImageView,
            xImageView,
            dateLabel,
            leageLabel,
            firstTeamLabel,
            secondTeamLabel,
            titleLabel,
            bottomView
        )
    }
    
    func setHeader(poll: PollDetails) {
        dateLabel.text = "\(poll.dateStart.currentFormatt) - \(poll.dateEnd.currentFormatt)"
        leageLabel.text = poll.subtitle
        
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
    }
}

//MARK: - Layout

extension VoteHeaderView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            voteBackgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            voteBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            voteBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            voteBackgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            xImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            xImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            xImageView.heightAnchor.constraint(equalToConstant: 12),
            xImageView.widthAnchor.constraint(equalToConstant: 12),
            
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: xImageView.topAnchor, constant: -20),
            
            leageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            leageLabel.topAnchor.constraint(equalTo: xImageView.bottomAnchor, constant: 20),
            
            bottomView.heightAnchor.constraint(equalToConstant: 20),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            
            firstTeamLabel.centerYAnchor.constraint(equalTo: xImageView.centerYAnchor),
            firstTeamLabel.trailingAnchor.constraint(equalTo: xImageView.leadingAnchor, constant: -10),
            firstTeamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            secondTeamLabel.centerYAnchor.constraint(equalTo: xImageView.centerYAnchor),
            secondTeamLabel.leadingAnchor.constraint(equalTo: xImageView.trailingAnchor, constant: 10),
            secondTeamLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: xImageView.centerYAnchor),
        ])
    }
}

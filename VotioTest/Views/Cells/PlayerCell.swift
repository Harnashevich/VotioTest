//
//  PlayerCell.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 28.03.24.
//

import UIKit
import SDWebImage

protocol PlayerCellDelegate: AnyObject {
    func scoreTapped(_ cell: PlayerCell, indexPathRow: Int)
}

public final class PlayerCell: UICollectionViewCell {
    
    static let identifier = String(describing: PlayerCell.self)
    
    weak var delegate: PlayerCellDelegate?
    
    //MARK: - UI
    
    private lazy var playerBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "playerBackgroundView")
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var playerImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray.withAlphaComponent(0.5)
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.textAlignment = .left
        label.text = "Messi"
        return label
    }()

    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Lionel"
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.text = "Defender"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 8
        stack.clipsToBounds = true
        stack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.scoreTapped))
        stack.addGestureRecognizer(gesture)
        return stack
    }()
    
    private var scoreLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private var rateView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var yourRateLabel: UILabel = {
        var label = UILabel()
        label.text = "Your rate"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var voteLabel: UILabel = {
        var label = UILabel()
        label.text = "Vote"
        label.textColor = .blue
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    //MARK: - Variables
    
    var indexPathRow: Int?
    var voteStage: PlayersViewController.VoteStage?
    
    //MARK: - Initialization
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func prepareForReuse() {
        secondNameLabel.text = nil
        nameLabel.text = nil
        positionLabel.text = nil
        playerImageView.image = nil
        indexPathRow = nil
        voteStage = nil
        numberLabel.text = nil
    }
}

//MARK: - Methods

extension PlayerCell {
    
    //MARK: - Private
    
    @objc private func scoreTapped(_ sender:UITapGestureRecognizer) {
        guard let indexPathRow else { return }
        delegate?.scoreTapped(self, indexPathRow: indexPathRow)
    }
    
    private func configureUI() {
        contentView.addSubviews(
            playerBackgroundImageView,
            playerImageView,
            stackView,
            numberLabel,
            nameLabel,
            secondNameLabel,
            positionLabel
        )
        stackView.addArrangedSubviews(rateView, voteLabel)
        rateView.addSubviews(yourRateLabel, scoreLabel)
    }
    
    //MARK: - Public
    
    func setScore(_ score: Int) {
        if score == 0 {
            voteLabel.isHidden = false
            rateView.isHidden = true
        } else if score < 0 {
            voteLabel.isHidden = true
            rateView.isHidden = false
            scoreLabel.textColor = .red
            scoreLabel.setText(with: score)
        } else {
            voteLabel.isHidden = true
            rateView.isHidden = false
            scoreLabel.textColor = .blue
            scoreLabel.text = "\(score)"
        }
    }
    
    func setResultScore(score: Double) {
        yourRateLabel.text = "User rating"
        if score < 0 {
            voteLabel.isHidden = true
            rateView.isHidden = false
            scoreLabel.textColor = .red
            scoreLabel.setText(with: score.reduceScale(to: 1))
        } else {
            voteLabel.isHidden = true
            rateView.isHidden = false
            scoreLabel.textColor = .blue
            scoreLabel.setWithPlus(number: score.reduceScale(to: 1),
                                        isChangeTextColor: false)
        }
    }
    
    func configureCell(
        with player: PlayerVoting,
        indexPatn: IndexPath,
        stage: PlayersViewController.VoteStage
    ) {
        voteStage = stage
        indexPathRow = indexPatn.row
        numberLabel.text = player.number
        
        let fullNameArray = player.name.components(separatedBy: " ")
        if fullNameArray.count >= 2 {
            nameLabel.text = fullNameArray[0]
            secondNameLabel.text = fullNameArray[1]
        }
        
        positionLabel.text = player.amplua
        playerImageView.sd_setImage(with: URL(string: player.photo))
    }
}

//MARK: - Layout

extension PlayerCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            playerBackgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            playerBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerBackgroundImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            
            playerImageView.topAnchor.constraint(equalTo: topAnchor),
            playerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            
            stackView.leadingAnchor.constraint(equalTo: playerBackgroundImageView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: playerBackgroundImageView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: playerBackgroundImageView.bottomAnchor),
            
            voteLabel.heightAnchor.constraint(equalToConstant: 40),
            rateView.heightAnchor.constraint(equalToConstant: 40),
            
            yourRateLabel.leadingAnchor.constraint(equalTo: rateView.leadingAnchor, constant: 10),
            yourRateLabel.centerYAnchor.constraint(equalTo: rateView.centerYAnchor),
            
            scoreLabel.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -10),
            scoreLabel.centerYAnchor.constraint(equalTo: rateView.centerYAnchor),
            
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            secondNameLabel.topAnchor.constraint(equalTo: playerBackgroundImageView.bottomAnchor, constant: 10),
            secondNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}

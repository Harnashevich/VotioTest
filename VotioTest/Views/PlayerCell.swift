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

public final class PlayerCell: UITableViewCell {
    
    static let identifier = String(describing: PlayerCell.self)
    
    weak var delegate: PlayerCellDelegate?
    
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
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.text = "Lionel Messi"
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
//        label.backgroundColor = .red.withAlphaComponent(0.1)
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.text = "Defender"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.scoreTapped))
        stack.addGestureRecognizer(gesture)
        return stack
    }()
    
    private var scoreLabel: UILabel = {
        var label = UILabel()
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
        label.isHidden = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = .blue.withAlphaComponent(0.2)
        return label
    }()
    
    //MARK: - Variables
    
    var indexPathRow: Int?
    
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
    
    public override func prepareForReuse() {
        nameLabel.text = nil
        positionLabel.text = nil
        playerImageView.image = nil
        indexPathRow = nil
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
            playerView,
            playerImageView,
            nameLabel,
            positionLabel,
            stackView
        )
        stackView.addArrangedSubviews(scoreLabel, plusLabel)
        
        addBorderColor(playerView, playerImageView)
    }
    
    //MARK: - Public
    
    func setScore(_ score: Int) {
        if score == 0 {
            plusLabel.isHidden = false
            scoreLabel.isHidden = true
        } else if score < 0 {
            plusLabel.isHidden = true
            scoreLabel.isHidden = false
            scoreLabel.backgroundColor = .red.withAlphaComponent(0.2)
            scoreLabel.textColor = .red
            scoreLabel.setText(with: score)
        } else {
            plusLabel.isHidden = true
            scoreLabel.isHidden = false
            scoreLabel.backgroundColor = .blue.withAlphaComponent(0.2)
            scoreLabel.textColor = .blue
            scoreLabel.text = "\(score)"
        }
    }
    
    func configureCell(with player: PlayersVoting, indexPatn: IndexPath) {
        indexPathRow = indexPatn.row
        nameLabel.text = player.name

        let attrString = NSMutableAttributedString(string: player.number + " " + player.amplua)
        attrString.addAttributes(
            [
                .font: UIFont.systemFont(ofSize: 15, weight: .bold),
                .foregroundColor: UIColor.black
            ],
            range: NSRange(location: 0, length: player.number.count)
        )
        
        positionLabel.attributedText = attrString
        playerImageView.sd_setImage(
            with: URL(string: player.photo),
            placeholderImage: UIImage(systemName: "soccerball")
        )
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

//
//  PlayerDetailsViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 9.04.24.
//

import UIKit

public final class PlayerDetailsViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        lazy var title = UILabel()
        title.text = playerVoting.name
        title.textColor = .black
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        
        lazy var button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowBack"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        view.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        return view
    }()
    
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInset = UIEdgeInsets(top: view.frame.size.width * 0.13, left: 0, bottom: 0, right: 0)
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .systemGray6
        stack.spacing = 10
        return stack
    }()
    
//    private lazy var playerImageView: UIImageView = {
//        let image = UIImageView()
//        image.tintColor = .lightGray.withAlphaComponent(0.5)
//        image.contentMode = .scaleAspectFill
//        image.clipsToBounds = true
//        return image
//    }()
    
    private lazy var playerImageView: PlayerImageView = {
        let view = PlayerImageView()
        return view
    }()
    
    private lazy var playerDataView: PlayerDataView = {
        let view = PlayerDataView()
        return view
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView()
        return view
    }()
    
    private lazy var statsView: StatsView = {
        let view = StatsView()
        return view
    }()
    
    private lazy var mastershipView: MastershipView = {
        let view = MastershipView()
        return view
    }()
    
    //MARK: - Variables
    
//    private var playerId: Int
    private var playerVoting: PlayerVoting
    private var player: Player?
    
    //MARK: - Initialization
    
    init(playerVoting: PlayerVoting) {
        self.playerVoting = playerVoting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError ()
    }
    
    //MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(scrollView, topView)
        scrollView.addSubviews(stackView)
        stackView.addArrangedSubviews(
            playerImageView,
            playerDataView,
            ratingView,
            statsView,
            mastershipView
        )
        setConstraints()
        fetchPlayer()
    }
}

//MARK: - Methods

extension PlayerDetailsViewController {
    
    private func fetchPlayer() {
        APICaller.shared.getPlayer(id: playerVoting.id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.player = data.result
                    self.playerImageView.setPlayer(with: self.player)
                    
//                    self.playerImageView.sd_setImage(
//                        with: URL(string: self.player?.photo ?? String()),
//                        placeholderImage: UIImage(systemName: "soccerball")
//                    )
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc private func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Layout

extension PlayerDetailsViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            playerImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            playerImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        ])
    }
}

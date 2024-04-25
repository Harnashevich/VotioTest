//
//  PlayerDetailsViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 9.04.24.
//

import UIKit

public final class PlayerDetailsViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var playerImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray.withAlphaComponent(0.5)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
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
    
    private var playerId: Int
    private var player: Player?
    
    //MARK: - Initialization
    
    init(playerId: Int) {
        self.playerId = playerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError ()
    }
    
    //MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubviews(stackView)
        setUpCloseButton()
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
        APICaller.shared.getPlayer(id: playerId) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.player = data.result
                    if let player = self.player {
                        self.playerImageView.sd_setImage(
                            with: URL(string: self.player?.photo ?? String()),
                            placeholderImage: UIImage(systemName: "soccerball")
                        )
                        self.playerDataView.configureView(with: player)
                        self.ratingView.configureRating()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    /// Sets up close button
    private func setUpCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
    }
    
    /// Handle close button tap
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
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
            playerImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
    }
}

//
//  PlayersViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 28.03.24.
//

import UIKit

public class PlayersViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(
            PlayerCell.self,
            forCellReuseIdentifier: PlayerCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var voteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Vote", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(voteTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Variables
    
    private let pollId: Int
    private var pollDetails: PollDetails?
    
    private var playersScoreDictionary: [Int: Int] = [:]
    private var availableScores = [Int]()
    
    private var playersList = [PlayersVoting]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Initialization
    
    init(pollId: Int) {
        self.pollId = pollId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError ()
    }
    
    //MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(tableView, voteButton)
        setConstraints()
        fetchPoll()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .semibold)]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}

//MARK: - Methods

extension PlayersViewController {
    
    private func fetchPoll() {
        APICaller.shared.getPoll(id: pollId) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.pollDetails = data.result
                    self.playersList = data.result.playersVoting
                    self.availableScores = data.result.playersVotingType.scores
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func upodateScoreForPlayer(withPlayerId playerId: Int, toScore score: Int) {
        if score == 0 {
            self.playersScoreDictionary[playerId] = nil
        } else {
            self.playersScoreDictionary[playerId] = score
            self.availableScores.enumerated().forEach { (index, value) in
                if value == score {
                    self.availableScores.remove(at: index)
                }
            }
        }
        self.playersList.enumerated().forEach { (index, player) in
            if player.id == playerId {
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    @objc private func voteTapped() {
        print("Vote tapped")
        print("результат \(pollDetails?.playersVotingType)")
    }
}

//MARK: - UITableViewDataSource

extension PlayersViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playersList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlayerCell.identifier,
            for: indexPath
        ) as? PlayerCell else {
            fatalError()
        }
        let player = playersList[indexPath.row]
        cell.delegate = self
        cell.configureCell(with: player, indexPatn: indexPath)
        if let score = self.playersScoreDictionary[player.id] {
            cell.setScore(score)
        } else {
            cell.setScore(0)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension PlayersViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = RateViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true)
        
        print("tap cell")
    }
}

//MARK: - PlayerCellDelegate

extension PlayersViewController: PlayerCellDelegate {
    
    func scoreTapped(_ cell: PlayerCell, indexPathRow: Int) {
        let vc = RateViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
        if let playerScore = self.playersScoreDictionary[self.playersList[indexPathRow].id] {
            availableScores.append(playerScore)
            vc.set(selectedScore: playerScore)
        }
        if let matchResult = self.pollDetails?.playersVotingType {
            vc.setView(playerId: self.playersList[indexPathRow].id,
                                    matchResult: matchResult,
                                    availabelScores: self.availableScores)
        }
        vc.ratePlayerClosure = { [unowned self] (id, score) in
            self.upodateScoreForPlayer(withPlayerId: id, toScore: score)
        }
    }
}

//MARK: - Layout

extension PlayersViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            voteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            voteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            voteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            voteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

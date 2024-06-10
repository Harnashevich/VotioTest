//
//  PlayersViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 28.03.24.
//

import UIKit

public class PlayersViewController: UIViewController {
    
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
        title.text = "Players voting"
        title.textColor = .black
        title.font = .systemFont(ofSize: 20, weight: .bold)
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: view.frame.size.width * 0.13, left: 0, bottom: 100, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            PlayerCell.self,
            forCellWithReuseIdentifier: PlayerCell.identifier
        )
        collectionView.register(
            VoteHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: VoteHeaderView.identifier
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var voteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Vote", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.addTarget(self, action: #selector(voteTapped), for: .touchUpInside)
        return button
    }()
     
    //MARK: - Enum
    
    enum VoteStage {
        case notVoted
        case voted
    }
    
    //MARK: - Variables
    
    private let pollId: Int
    private var pollDetails: PollDetails?
    
    private var playersScoreDictionary: [Int: Int] = [:]
    private var availableScores = [Int]()
//    private var playersVotingStats: [PlayersVoting] = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    private var playersList = [PlayerVoting]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var voteStage: VoteStage = .voted
    
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
        view.addSubviews(collectionView, topView, voteButton)
        setConstraints()
        fetchPoll()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .black),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
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
                    
                    switch data.result.stage {
                    case 1:
                        self.voteStage = .notVoted
                        self.playersList = data.result.playersVoting
                        self.voteButton.isHidden = false
                    case 2:
                        self.voteStage = .voted
                        self.playersList = data.result.playersVotingStats
                        self.voteButton.isHidden = true
                    default:
                        break
                    }
                    
                    
                    self.pollDetails = data.result
                   
                    self.availableScores = data.result.playersVotingType.scores

                    self.playersList.forEach {
                        self.playersScoreDictionary[$0.id] = 0
                    }
                    
                    print("playersScoreDictionary")
                    print(self.playersScoreDictionary)
                    
                    self.createFooter()
                    self.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func upodateScoreForPlayer(withPlayerId playerId: Int, toScore score: Int) {
        if score == 0 {
            self.playersScoreDictionary[playerId] = /*nil*/ 0
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
                self.collectionView.reloadItems(at:  [indexPath])
            }
        }
    }
    
    private func createFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        let label = UILabel(frame: footer.bounds)
        label.textAlignment = .center
        if let votets = playersList.last?.voters {
            label.text = "Users voted: \(votets)"
        }
        label.textColor = .black
        footer.isHidden = (voteStage == .notVoted)
        footer.addSubview(label)
//        collectionView.tableFooterView = footer
    }
    
    private func showAlert(with text: String) {
        let alert = UIAlertController(title: "Notice", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default))
        self.present(alert, animated: true)
    }
    
    @objc private func voteTapped() {
        let playesrScoresRequestModel: PlayerScoresRequestModel = .init(playerScores: playersScoreDictionary.map {
            PlayerScores(playerId: $0.key, score: $0.value)
        })
        
        var scoresCount = 0
        playesrScoresRequestModel.playerScores.forEach {
            if $0.score != 0 {
                scoresCount += 1
            }
        }
        
        let playersCount = playesrScoresRequestModel.playerScores.count

        if playersCount < 10 {
            if playersCount != scoresCount {
                showAlert(with: "Rate all players")
                return
            }
        } else {
            if scoresCount != 10 {
                showAlert(with: "Distribute all scores")
                return
            }
        }
        
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(playesrScoresRequestModel),
              let json = String(data: jsonData, encoding: String.Encoding.utf8) else { return }
        
        print("json")
        print(json)
        
        
        APICaller.shared.votePollPlayers(
            id: pollId,
            playersScores: json
        ) { [weak self ]result in
            guard let self else { return }
            switch result {
            case true:
                print("Проголосовано успешно")
                self.fetchPoll()
            case false:
                print("Проголосовано НЕУСПЕШНО")
            }
        }
    }
    
    @objc private func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension PlayersViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playersList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlayerCell.identifier,
            for: indexPath
        ) as? PlayerCell else {
            fatalError()
        }
        
        let player = playersList[indexPath.row]
        
        cell.delegate = self
        
        cell.configureCell(
            with: player,
            indexPatn: indexPath,
            stage: voteStage
        )
        
        if let score = self.playersScoreDictionary[player.id] {
            cell.setScore(score)
        } else {
            cell.setScore(0)
        }
        
        if voteStage == .voted {
            cell.setResultScore(score: player.score ?? Double())
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: VoteHeaderView.identifier,
            for: indexPath
        ) as? VoteHeaderView else {
            return UICollectionReusableView()
        }
        if let pollDetails {
            sectionHeader.setHeader(poll: pollDetails)
        }
    
        return sectionHeader
    }
}

//MARK: - UICollectionViewDelegate

extension PlayersViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let player = playersList[indexPath.row]
        let vc = PlayerDetailsViewController(playerVoting: player)
        vc.title = player.name
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PlayersViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.size.width / 2 - 20,
            height: collectionView.frame.size.width / 1.4 - 20
        )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(
            width: collectionView.frame.size.width,
            height: collectionView.frame.size.width * 0.5
        )
    }
}

//MARK: - PlayerCellDelegate

extension PlayersViewController: PlayerCellDelegate {
    
    func scoreTapped(_ cell: PlayerCell, indexPathRow: Int) {
        guard voteStage == .notVoted else { return }
        let vc = RateViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
        if let playerScore = playersScoreDictionary[playersList[indexPathRow].id] {
            availableScores.append(playerScore)
            vc.set(selectedScore: playerScore)
        }
        if let matchResult = pollDetails?.playersVotingType {
            vc.setView(
                playerId: playersList[indexPathRow].id,
                matchResult: matchResult,
                availabelScores: self.availableScores
            )
        }
        vc.ratePlayerClosure = { [unowned self] (id, score) in
             upodateScoreForPlayer(withPlayerId: id, toScore: score)
        }
    }
}

//MARK: - Layout

extension PlayersViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           
            voteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            voteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            voteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            voteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//
//  RatePlayerViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 28.03.24.
//

import UIKit

public final class RateViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var rateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Rate"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var deselectButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightGray.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Deselect", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(deselectButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Variables
    
    var playerId: Int?
    var scores = [Int]()
    
    private var matchResult: MatchResultsModel?
    private var oldScore: Int?
    private var selectedScore: Int?
    
    //MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubviews(rateView, titleLabel, topStackView, bottomStackView, deselectButton)
        view.addBorderColor(rateView)
        
        rateView.addSubview(closeButton)
        
        configureStack(topStackView)
        configureStack(bottomStackView)
        
        setConstraints()
    }
    
    public override func viewWillLayoutSubviews() {
        topStackView.arrangedSubviews.forEach {
            $0.makeCircle()
        }
        bottomStackView.arrangedSubviews.forEach {
            $0.makeCircle()
        }
        self.topStackView.layoutIfNeeded()
        self.bottomStackView.layoutIfNeeded()
    }
    
    //MARK: - Callbacks
    
    var ratePlayerClosure: ((Int, Int) -> ())?
}

//MARK: - Methods

extension RateViewController {
    
    //MARK: - Public
    
    func set(selectedScore: Int) {
        self.selectedScore = selectedScore
        oldScore = selectedScore
        deselectButton.isHidden = false
    }
    
    func setView(playerId: Int, matchResult: MatchResultsModel, availabelScores: [Int]) {
        self.matchResult = matchResult
        self.playerId = playerId
        self.scores = availabelScores
        setupButtons(for: matchResult)
    }
    
    //MARK: - Private
    
    private func setupButtons(for result: MatchResultsModel) {
        result.scores.enumerated().forEach { index, score in
            if index < 5,
               let button = topStackView.arrangedSubviews[index] as? UIButton {
                setup(button: button, withScore: score)
            } else if let button = bottomStackView.arrangedSubviews[index - 5] as? UIButton {
                setup(button: button, withScore: score)
            }
        }
    }
    
    private func setup(button: UIButton, withScore score: Int) {
        if score < 0 {
            button.set(score: score)
        } else {
            button.setScoreWithPlus(score: score)
        }
        
        guard self.scores.contains(score) else {
            button.isEnabled = false
            button.backgroundColor = .lightGray
            button.setTitleColor(.black, for: .normal)
            return
        }
        guard let selectedScore = selectedScore,
              selectedScore == score else {
            button.backgroundColor = score > 0 ? .blue.withAlphaComponent(0.2) : .red.withAlphaComponent(0.2)
            button.setTitleColor(score > 0 ? .blue : .red,
                                 for: .normal)
            return
        }
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
    }
    
    private func configureStack(_ stack: UIStackView) {
        for _ in 0...4 {
            let button: UIButton = {
                let button = UIButton()
                button.addTarget(self, action: #selector(ratingButtonTap), for: .touchUpInside)
                button.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
                button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
                button.backgroundColor = .blue.withAlphaComponent(0.2)
                return button
            }()
            
            stack.addArrangedSubview(button)
        }
    }
    
    @objc private func ratingButtonTap(_ sender: UIButton) {
        print("Score \(sender.titleLabel?.text)")
        let rating = Int(sender.titleLabel?.text ?? "0") ?? 0
        selectedScore = rating
        
        guard let rating = selectedScore else {
            return
        }
        if let playerId = self.playerId {
            self.ratePlayerClosure?(playerId, rating)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func deselectButtonTap() {
        print("Deselect")
        if let playerId = self.playerId {
            self.ratePlayerClosure?(playerId, 0)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func closeScreen() {
        if let playerId = self.playerId {
            self.ratePlayerClosure?(playerId, oldScore ?? 0)
        }
        self.dismiss(animated: true)
    }
}

//MARK: - Layout

extension RateViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 30),
            
            rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: rateView.centerXAnchor),
            
            topStackView.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 90),
            topStackView.leadingAnchor.constraint(equalTo: rateView.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            bottomStackView.leadingAnchor.constraint(equalTo: rateView.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            
            deselectButton.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 20),
            deselectButton.leadingAnchor.constraint(equalTo: rateView.leadingAnchor, constant: 20),
            deselectButton.trailingAnchor.constraint(equalTo: rateView.trailingAnchor, constant: -20),
            deselectButton.heightAnchor.constraint(equalToConstant: 40),
            deselectButton.bottomAnchor.constraint(equalTo: rateView.bottomAnchor, constant: -20)
        ])
    }
}

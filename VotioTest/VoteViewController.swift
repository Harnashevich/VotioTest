//
//  VoteViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 26.03.24.
//

import UIKit

public final class VoteViewController: UIViewController {
    
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
        title.text = "Voting list"
        title.textColor = .black
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        tableView.register(
            VoteCell.self,
            forCellReuseIdentifier: VoteCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .blue.withAlphaComponent(0.03)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Variables
    
    private var polls = [Poll]()
    
    //MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(tableView, topView)
        print(view.frame.size.width)
        navigationController?.navigationBar.isHidden = true
        setConstraints()
        fetchPolls()
    }
}

//MARK: - Methods

extension VoteViewController {
    
    private func fetchPolls() {
        APICaller.shared.getPolls { [weak self] reuslt in
            guard let self else { return }
            DispatchQueue.main.async {
                switch reuslt {
                case .success(let data):
                    self.polls = data.result
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource

extension VoteViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        polls.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: VoteCell.identifier,
            for: indexPath
        ) as? VoteCell else {
            fatalError()
        }
        cell.configureCell(with: polls[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate

extension VoteViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayersViewController(pollId: polls[indexPath.row].id)
        vc.title = polls[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }
}

//MARK: - Layout

extension VoteViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

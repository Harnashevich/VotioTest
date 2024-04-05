//
//  VoteViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 26.03.24.
//

import UIKit

public final class VoteViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(
            VoteCell.self,
            forCellReuseIdentifier: VoteCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Variables
    
    private var polls = [Poll]()
    
    //MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Voting list"
        view.backgroundColor = .white
        view.addSubview(tableView)
        setConstraints()
        fetchPolls()
        
        // set font for title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
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
        vc.title = "Player voting"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Layout

extension VoteViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

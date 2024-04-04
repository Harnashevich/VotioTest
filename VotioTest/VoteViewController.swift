//
//  VoteViewController.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 26.03.24.
//

import UIKit

class VoteViewController: UIViewController {
    
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
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Voting list"
        view.backgroundColor = .white
        view.addSubview(tableView)      
        setConstraints()
    }
}

//MARK: - Methods

extension VoteViewController {
    
}

//MARK: - UITableViewDataSource

extension VoteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: VoteCell.identifier,
            for: indexPath
        ) as? VoteCell else {
            fatalError()
        }
        cell.configureCell()
        return cell
    }
}

//MARK: - UITableViewDelegate

extension VoteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TAP TAP")
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

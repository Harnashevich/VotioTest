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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Variables
    
    //MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setConstraints()
    }
}

//MARK: - Methods

extension PlayersViewController {
    
}

//MARK: - UITableViewDataSource

extension PlayersViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        11
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlayerCell.identifier,
            for: indexPath
        ) as? PlayerCell else {
            fatalError()
        }
        cell.configureCell()
        return cell
    }
}

//MARK: - UITableViewDelegate

extension PlayersViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RateViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

//MARK: - Layout

extension PlayersViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

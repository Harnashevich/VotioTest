//
//  MastershipView.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 11.04.24.
//

import UIKit

public final class SelfSizingTableView: UITableView {
    
    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}

public final class MastershipView: UIView {
    
    struct Mastership {
        var title: String
        var rating: Int
    }
    
    //MARK: - UI
    
    private lazy var mastershipView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .left
        label.text = "Player parametrs"
        return label
    }()
    
    //MARK: - UI
    
    private lazy var tableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.register(
            MastershipCell.self,
            forCellReuseIdentifier: MastershipCell.identifier
        )
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Variables
    
    private var mastership: [Mastership] = [
        .init(title: "Readiness", rating: Int.random(in: 0...100)),
        .init(title: "Motivation", rating: Int.random(in: 0...100)),
        .init(title: "Health", rating: Int.random(in: 0...100)),
        .init(title: "Fitness", rating: Int.random(in: 0...100)),
        .init(title: "Psychology", rating: Int.random(in: 0...100)),
        .init(title: "P.T.", rating: Int.random(in: 0...100)),
        .init(title: "Mastership rating", rating: Int.random(in: 0...100))
    ]
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods

extension MastershipView {
    
    private func configureUI() {
        addSubviews(mastershipView, titleLabel, tableView)
        mastershipView.addSubviews(titleLabel, tableView)
    }
}

//MARK: - UITableViewDataSource

extension MastershipView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mastership.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MastershipCell.identifier,
            for: indexPath
        ) as? MastershipCell else {
            fatalError()
        }
        cell.configureCell(
            rating: mastership[indexPath.row].rating,
            title: mastership[indexPath.row].title
        )
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MastershipView: UITableViewDelegate {
    
}

//MARK: - Layout

extension MastershipView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mastershipView.topAnchor.constraint(equalTo: topAnchor),
            mastershipView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mastershipView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mastershipView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: mastershipView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: mastershipView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: mastershipView.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: mastershipView.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: mastershipView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mastershipView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mastershipView.bottomAnchor, constant: -20)
        ])
    }
}

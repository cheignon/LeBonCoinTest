//
//  DetailView.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 15/11/2022.
//

import UIKit

class DetailView: UIView {

    var tableView: UITableView!
    var closeButton: UIButton!
    var delegate: (UITableViewDataSource & UITableViewDelegate & DetailDisplayLogic)?

    init(delegate: (UITableViewDataSource & UITableViewDelegate & DetailDisplayLogic)) {
        super.init(frame: UIScreen.main.bounds)
        self.delegate = delegate
        self.initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }

    func initialize() {
        self.backgroundColor = .white
        self.setupTableView()
        self.setupButton()
        self.setupAutolayout()
    }

    func setupTableView () {
        self.tableView = UITableView()
        self.tableView.dataSource = self.delegate
        self.tableView.delegate = self.delegate
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 600
        self.addSubview(self.tableView)
        self.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageCell")
        self.tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: "TitleCell")
        self.tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "DescriptionCell")

    }

    func setupButton() {
        self.closeButton = UIButton()
        self.closeButton.layer.cornerRadius = 20
        self.closeButton.backgroundColor = .lightGray.withAlphaComponent(0.4)
        let imageTemplate = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        imageTemplate?.withTintColor(.white)
        self.closeButton.setImage(imageTemplate, for: .normal)
        self.closeButton.tintColor = .white
        self.closeButton.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        self.addSubview(self.closeButton)
    }

    @objc func buttonDidClick() {
        self.delegate?.dismiss()
    }

    func setupAutolayout() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.closeButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.closeButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 8),
            self.closeButton.heightAnchor.constraint(equalToConstant: 40),
            self.closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

}

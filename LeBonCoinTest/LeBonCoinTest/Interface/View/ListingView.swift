//
//  ListingView.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import UIKit

class ListingView: UIView {

    var tableView: UITableView!
    var searchBar: UISearchBar!
    var delegate: (UITableViewDelegate & UITableViewDataSource & UISearchBarDelegate)?

    init(delegate: UITableViewDelegate & UITableViewDataSource & UISearchBarDelegate) {
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
        self.setupSearchBar()
        self.setupAutolayout()
    }

    func setupTableView () {
        self.tableView = UITableView()
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.rowHeight = 80
        self.addSubview(self.tableView)
        self.tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: "listingCell")

    }

    func setupSearchBar() {
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self.delegate
        self.searchBar.showsBookmarkButton = true
        let imageTemplate = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysTemplate)
        imageTemplate?.withTintColor(.lightGray)
        self.searchBar.setImage(imageTemplate, for: .bookmark, state: .normal)
        self.addSubview(self.searchBar)
    }

    func setupAutolayout() {

        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.searchBar.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }

    func changeSearchBarForFilter(nameCategegory: String) {
        DispatchQueue.main.async {
            self.searchBar.showsBookmarkButton = false
            self.searchBar.showsCancelButton = true
            self.searchBar.searchTextField.text = nameCategegory
            self.tableView.reloadData()
        }
    }

    func changeSearchBarForNormalState() {
        DispatchQueue.main.async {
            self.searchBar.showsBookmarkButton = true
            self.searchBar.searchTextField.text = ""
            self.tableView.reloadData()
        }
    }

}

//
//  ListingTableViewCell.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 11/11/2022.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    var thumbImageView: UIImageView = UIImageView()
    var categoryLabel: UILabel = UILabel()
    var titleLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    var urgentLabel: UILabel = UILabel()
    let containerView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()

    }

    func initialize() {
        self.selectionStyle = .none
        self.addSubview(self.thumbImageView)
        self.addSubview(self.urgentLabel)
        self.addSubview(self.categoryLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.priceLabel)
        self.setupImageView()
        self.setuplabel()
        self.setupAutoLayout()

    }

    func setupImageView() {
        self.thumbImageView.layer.cornerRadius = 5.0
        self.thumbImageView.clipsToBounds = true
        self.thumbImageView.contentMode = .scaleAspectFill
    }

    func setuplabel() {
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textColor = .gray

        self.categoryLabel.layer.cornerRadius = (self.categoryLabel.frame.size.height / 2)
        self.categoryLabel.numberOfLines = 0
        self.categoryLabel.layer.cornerRadius = 10
        self.categoryLabel.clipsToBounds = true
        self.categoryLabel.backgroundColor = UIColor(red: 238/255, green: 119/255, blue: 52/255, alpha: 0.2)
        self.categoryLabel.textColor = UIColor(red: 238/255, green: 119/255, blue: 52/255, alpha: 1)
        self.categoryLabel.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))

        self.priceLabel.clipsToBounds = true
        self.priceLabel.numberOfLines = 0
        self.priceLabel.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.2)
        self.priceLabel.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)
        self.priceLabel.layer.cornerRadius = 10

        self.urgentLabel.clipsToBounds = true
        self.urgentLabel.numberOfLines = 0
        self.urgentLabel.text = NSLocalizedString(" URGENT ", comment: "")
        self.urgentLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.2)
        self.urgentLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        self.urgentLabel.layer.cornerRadius = 10

    }

    func setupAutoLayout() {
        self.thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.urgentLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.thumbImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 8),
            self.thumbImageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: -4),
            self.thumbImageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 4),
            self.thumbImageView.widthAnchor.constraint(equalToConstant: 64),
            self.thumbImageView.heightAnchor.constraint(equalToConstant: 64),

            self.categoryLabel.leftAnchor.constraint(equalTo: self.thumbImageView.rightAnchor, constant: 8),
            self.categoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            self.categoryLabel.heightAnchor.constraint(equalToConstant: 24),
            self.categoryLabel.topAnchor.constraint(equalTo: self.thumbImageView.topAnchor),

            self.titleLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 8),
            self.titleLabel.leftAnchor.constraint(equalTo: self.thumbImageView.rightAnchor, constant: 8),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),

            self.priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.priceLabel.topAnchor.constraint(equalTo: self.urgentLabel.topAnchor),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.urgentLabel.bottomAnchor),

            self.urgentLabel.leftAnchor.constraint(equalTo: self.categoryLabel.rightAnchor, constant: 8),
            self.urgentLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
            self.urgentLabel.topAnchor.constraint(equalTo: self.categoryLabel.topAnchor),
            self.urgentLabel.bottomAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor)

        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayUrgent(isUrgent: Bool) {
        self.urgentLabel.isHidden = !isUrgent
    }

    override func layoutIfNeeded() {
        setupAutoLayout()
    }

}

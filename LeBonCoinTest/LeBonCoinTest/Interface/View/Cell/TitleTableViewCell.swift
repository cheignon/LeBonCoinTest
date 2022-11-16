//
//  TitleTableViewCell.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    var titleLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    var urgentLabel: UILabel = UILabel()
    
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
        self.addSubview(self.urgentLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.priceLabel)
        self.setupLabel()
        self.setupAutoLayout()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLabel() {
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

        self.titleLabel.numberOfLines = 0
        self.titleLabel.textColor = .darkGray
        self.titleLabel.textAlignment = .center
    }
    
    func setupAutoLayout() {
        self.urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.urgentLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.urgentLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
    
            self.priceLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.priceLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            
            self.titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.urgentLabel.bottomAnchor, constant: 8),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])

    }

}

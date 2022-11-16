//
//  DescriptionTableViewCell.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    var descriptionLabel: UILabel = UILabel()
    
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
    
    func initialize () {
        self.selectionStyle = .none
        self.addSubview(self.descriptionLabel)
        self.setupLabel()
        self.setupAutoLayout()
    }

    func setupLabel() {
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = .gray
    }
    
    func setupAutoLayout() {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)])
         
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

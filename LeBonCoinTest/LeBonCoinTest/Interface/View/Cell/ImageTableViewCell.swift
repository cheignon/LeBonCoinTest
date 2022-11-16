//
//  ImageTableViewCell.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 15/11/2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    var imageProduct: UIImageView = UIImageView()

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initialize() {
        self.imageProduct.contentMode = .scaleAspectFill
        self.imageProduct.clipsToBounds = true

        self.addSubview(self.imageProduct)
        self.setupAutoLayout()
    }

    func setupAutoLayout() {
        self.imageProduct.translatesAutoresizingMaskIntoConstraints = false
        let size = UIScreen.main.bounds.width
        NSLayoutConstraint.activate([
            self.imageProduct.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageProduct.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageProduct.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageProduct.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageProduct.widthAnchor.constraint(equalToConstant: size),
            self.imageProduct.heightAnchor.constraint(equalToConstant: size)
        ])
    }

}

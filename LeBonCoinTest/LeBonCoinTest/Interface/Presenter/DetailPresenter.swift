//
//  DetailPresenter.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import UIKit

protocol DetailPresentationLogic
{
    func presentImageCell(cell: UITableViewCell, image: UIImage)
    func presentCell(cell: UITableViewCell, object: ClassifiedAd)
}

class DetailPresenter: DetailPresentationLogic {

    var viewController: DetailDisplayLogic?

    func presentImageCell(cell: UITableViewCell, image: UIImage) {
        if let imageCell = cell as? ImageTableViewCell {
            imageCell.imageProduct.image = image
        }
    }
    
    func presentCell(cell: UITableViewCell, object: ClassifiedAd) {
        if let titleCell = cell as? TitleTableViewCell {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            if let formattedPrice = formatter.string(from: object.price as NSNumber) {
                titleCell.priceLabel.text = " \(formattedPrice) "
            }
            titleCell.titleLabel.text = object.title
            titleCell.urgentLabel.alpha = object.is_urgent ? 1 : 0
        }
        if let descriptionCell = cell as? DescriptionTableViewCell {
            descriptionCell.descriptionLabel.text = object.desc
        }
    }
    
}

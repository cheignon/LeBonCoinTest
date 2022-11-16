//
//  DetailInteractor.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import UIKit

protocol DetailBusinessLogic
{
    func prepareCell(for indexPath: IndexPath, object: ClassifiedAd?) -> UITableViewCell
}

class DetailInteractor: DetailBusinessLogic {
    
    var presenter: DetailPresentationLogic?
    var listingWorker: ListingWorker?
    
    func prepareCell(for indexPath: IndexPath, object: ClassifiedAd?) -> UITableViewCell {
        guard let securedObject = object else {
            return UITableViewCell()
        }
        var cell: UITableViewCell!
        switch indexPath.row {
        case 0:
            cell = ImageTableViewCell()
            let imageUrl = securedObject.images_url.thumb
            self.listingWorker = ListingWorker()
            self.listingWorker?.getListingUseCase.getImage(url: imageUrl, completioHandler: { image in
                DispatchQueue.main.async {
                    self.presenter?.presentImageCell(cell: cell, image: image)
                }
            })
        case 1:
            cell = TitleTableViewCell()
                self.presenter?.presentCell(cell: cell, object: securedObject)
            
        case 2:
            cell = DescriptionTableViewCell()
            self.presenter?.presentCell(cell: cell, object: securedObject)
        default:
            cell = UITableViewCell()
            self.presenter?.presentCell(cell: cell, object: securedObject)
        }
        return cell
    }
    
}

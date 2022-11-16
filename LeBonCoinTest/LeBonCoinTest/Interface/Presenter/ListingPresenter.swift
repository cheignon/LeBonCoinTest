//
//  ListingPresenter.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 11/11/2022.
//

import UIKit

protocol ListingPresentationLogic {
    func presentErrorMessage(error: APIServiceError)
    func presentClasifiedAd(response: Listing.API.Response)
    func emitCategories(response: CategoryList.API.Response)
    func treatmentCategory(categories: [Category])
    func configureCell(response: Cell.Interface.Response)
    func presentListingByCategory(request: Sort.Element.Response)
    func presentListingFilteredByText(request: Filter.Element.Response)
}

class ListingPresenter: ListingPresentationLogic {

    var viewController: ListingDisplayLogic?

    func presentErrorMessage(error: APIServiceError) {

        var errorMessage: String
        switch error {
        case .emptyData:
            errorMessage = NSLocalizedString("Les données retournées sont vide", comment: "")
        case.badUrl:
            errorMessage = NSLocalizedString("L'url fournit n'est pas valide", comment: "")
        case .decodingError:
            errorMessage = NSLocalizedString("Le parsing des données a echoué", comment: "")
        case .statusNotOK:
            errorMessage = NSLocalizedString("Le serveur retourne une erreur", comment: "")
        case .requestError:
            errorMessage = NSLocalizedString("Les parametres de la requetes ne sont pas valide", comment: "")
        }
        self.viewController?.displayErrorMessage(message: errorMessage)
    }

    func presentClasifiedAd(response: Listing.API.Response) {
        /*
         Presenter: "c'est du vrai n'importe quoi les info son baclé faut tout que je reorganise tout ca"
         */
        let dataSorted = response.datas.sorted()

        /*
         Presenter: "C'est bon le bosse va etre content la, faut que j'encrypte les info si jamais les flics me chope en route"
         */
        let viewModel = Listing.API.ViewModel(datasSorted: dataSorted)

        /*
         Presenter: "Bon je file ca au bosse"
         */
        self.viewController?.displayDatas(viewModel: viewModel)

    }

    func emitCategories(response: CategoryList.API.Response) {
        /*
         Presenter: "Ha enfin, les dernieres infos que j'attendais depuis des semaines, plus qu'a les securisé et cest bon"
         */
        let viewModel = CategoryList.API.ViewModel(category: response.category)
        self.viewController?.stockCategoryInfo(viewModel: viewModel)

    }

    func treatmentCategory(categories: [Category]) {

        /*
         Presenter: "Bon vu que le bigBoss est chiant je vait lui proposer des themes"
         */
        let actionSheetTitle = NSLocalizedString("Filtre par categorie", comment: "")
        let actionSheet = UIAlertController(title: actionSheetTitle, message: nil, preferredStyle: .actionSheet)
        for category in categories {
            let action = UIAlertAction(title: category.name, style: .default) { _ in
                self.viewController?.didClickOnActionSheet(categoryId: category.id)
            }
            actionSheet.addAction(action)
        }
        let cancelActionTitle = NSLocalizedString("Annuler", comment: "")
        let actionCancel = UIAlertAction(title: cancelActionTitle, style: .cancel)
        actionSheet.addAction(actionCancel)
        self.viewController?.displayActionSheet(viewController: actionSheet)
    }

    func configureCell(response: Cell.Interface.Response) {
        /*
         Presenter: "C'est qui qu'on appel pour faire du photoshope, pour etre payer une misere... c'est bibi"
         */

        let cell =  response.cell
        cell.titleLabel.text = " \(response.title) "
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedPrice = formatter.string(from: response.price as NSNumber) {
            cell.priceLabel.text = " \(formattedPrice) "
        }
        cell.thumbImageView.image = response.image
        cell.displayUrgent(isUrgent: response.urgent)
        cell.categoryLabel.text = " \(response.categoryName) "
    }

    func presentListingByCategory(request: Sort.Element.Response) {
        /*
         Presenter : "Heureusement, que javais tout preparé ... si ca continué je finir par me faire choper"
         */
        let viewModel = Sort.Element.ViewModel(categoryName: request.categoryName, listingByCategory: request.listingByCategory)
        self.viewController?.displayListingSorted(viewModel: viewModel)
    }

    func presentListingFilteredByText(request: Filter.Element.Response) {
        /*
         Presenter : "Non mais il sont serieux la ?... faire une liste par mot, si ca continue je vais me tiré une balle dans la tete c'est pas possible"
         */
        let viewModel = Filter.Element.ViewModel(listingFilterdBytext: request.listingFilterdBytext)
        self.viewController?.displayListingFiltered(viewModel: viewModel)
    }
}

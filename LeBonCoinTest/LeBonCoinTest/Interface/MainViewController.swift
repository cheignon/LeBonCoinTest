//
//  MainViewController.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import UIKit

protocol ListingDisplayLogic
{
    func displayDatas(viewModel: Listing.API.ViewModel)
    func stockCategoryInfo(viewModel: CategoryList.API.ViewModel)
    func displayErrorMessage(message: String)
    func displayActionSheet(viewController: UIAlertController)
    func didClickOnActionSheet(categoryId: Int)
    func displayListingSorted(viewModel:Sort.Element.ViewModel)
    func displayListingFiltered(viewModel:Filter.Element.ViewModel)
}

class MainViewController: UIViewController {

    var interactor: (ListingBusinessLogic & ListingDataStore)?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var data: [ClassifiedAd]?
    var dataSorted: [ClassifiedAd]?
    var categories: [Category]?
    var isFilter: Bool = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setupConfiguration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    override func loadView() {
        self.view = ListingView(delegate: self)
    }
    
    func setupConfiguration() {
        let viewController = self
        let interactor = ListingInteractor()
        let presenter = ListingPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.object = interactor
    }
    
    func fetchData() {
        // ca sert a rien mais on respect la clean VIP
        let requestListing = Listing.API.Request()
        
        // la view vient de s'afficher mais pas de donnée faut aller donc aller les chercher sur l'API zut alors
        self.interactor?.getListing(request: requestListing)
        
        // on veut pouvoir avoir les categoriser ces infos
        let requestCategory = CategoryList.API.Request()
        self.interactor?.getCategory(request: requestCategory)
    }
    
    
}

extension MainViewController: ListingDisplayLogic {
  
    func stockCategoryInfo(viewModel: CategoryList.API.ViewModel) {
        self.categories = viewModel.category
    }
    
    
    func displayErrorMessage(message: String) {
        let title = NSLocalizedString("Une erreur est survenue", comment: "")
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okActionTitle = NSLocalizedString("OK", comment: "")
        let actionOK = UIAlertAction(title: okActionTitle, style: .default)
        alertView.addAction(actionOK)
        self.present(alertView, animated: true)
    }
    
    
    func displayDatas(viewModel: Listing.API.ViewModel) {
        /*
         ViewController: "Mouahahahaha, je suis le roi du monde faut que je montre ca"
         */
        self.data = viewModel.datasSorted
        
        /*
         ViewController: "Je vais demander a mon sbire de faire une Keynote"
         */
        (self.view as? ListingView)?.tableView.reloadData()
    }
    
    
    func displayActionSheet(viewController: UIAlertController) {
        self.present(viewController, animated: true)
    }
    
    func didClickOnActionSheet(categoryId: Int) {
        /*check si on a bien optenue les categories*/
        guard let listing = self.data, let categories = self.categories else {
            return
        }
        let request = Sort.Element.Request(id: categoryId, listing: listing, categories: categories)
        self.interactor?.sortListingByID(request: request)
        
    }
    
    func displayListingSorted(viewModel: Sort.Element.ViewModel) {
        self.dataSorted = viewModel.listingByCategory
        self.isFilter = true
        (self.view as? ListingView)?.changeSearchBarForFilter(nameCategegory: viewModel.categoryName)
    }
    
    func displayListingFiltered(viewModel: Filter.Element.ViewModel) {
        self.dataSorted = viewModel.listingFilterdBytext
        self.isFilter = true
        (self.view as? ListingView)?.tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSelected = isFilter ? self.dataSorted?[indexPath.row] : self.data?[indexPath.row]
        self.interactor?.object = itemSelected
        self.router?.routeToDetail()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFilter {
            return self.dataSorted?.count ?? 0
        }
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! ListingTableViewCell
        if let element = isFilter ? self.dataSorted?[indexPath.row] : self.data?[indexPath.row], let categories = self.categories {
            let request = Cell.Interface.Request(cell: cell, info: element)
            self.interactor?.prepareCell(request: request, categories: categories)
        }
        return cell
        
    }
    
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        /*check si on a bien optenue les categories*/
        guard let categoriesSecured = self.categories else {
            return
        }
        /*
         demarrage de la procedure d'affichage du filtre par categorie
         */
        self.interactor?.makeFilter(categories: categoriesSecured)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchText == "" {
            self.isFilter = false
            self.dataSorted = []
            (self.view as? ListingView)?.changeSearchBarForNormalState()
            return
        }
        guard let listing = (self.dataSorted?.isEmpty ?? true) ? self.data : self.dataSorted else {
            return
        }
        let request = Filter.Element.Request(searchText: searchText, listing: listing)
        self.interactor?.filterListingByText(request: request)
    }
    
}


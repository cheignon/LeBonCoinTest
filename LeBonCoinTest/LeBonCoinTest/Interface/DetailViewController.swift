//
//  DetailViewController.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 15/11/2022.
//

import UIKit

protocol DetailDisplayLogic
{
    func dismiss()
}

class DetailViewController: UIViewController {

    var interactor: DetailBusinessLogic?
    var object: ClassifiedAd?
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
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = DetailView(delegate: self)
    }
    
    func setupConfiguration() {
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
}

extension DetailViewController: DetailDisplayLogic {
    func dismiss() {
        self.dismiss(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.interactor?.prepareCell(for: indexPath, object: self.object) else {
            return UITableViewCell()
        }
        return cell
    }
    
}

extension DetailViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
}

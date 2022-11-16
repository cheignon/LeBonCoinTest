//
//  ListingInteractor.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 11/11/2022.
//

import Foundation

protocol ListingBusinessLogic
{
    func getListing(request: Listing.API.Request)
    func getCategory(request: CategoryList.API.Request)
    func makeFilter(categories: [Category])
    func prepareCell(request: Cell.Interface.Request, categories: [Category])
    func sortListingByID(request: Sort.Element.Request)
    func filterListingByText(request: Filter.Element.Request)
}

protocol ListingDataStore {
    var object: ClassifiedAd? { get set }
}

class ListingInteractor: ListingBusinessLogic, ListingDataStore {
    
    var object: ClassifiedAd?
    var presenter: ListingPresentationLogic?
    var listingWorker: ListingWorker?
    
    func getListing(request: Listing.API.Request) {
        
        /* voix off : "l'interactor il s'en fou en faite de l'evenement c'est un gros feignant donc il delegue a son pote le worker : "aller hop va travailler" */
        
        self.listingWorker = ListingWorker()
        
        /* voix off : "Mais que dois-je faire dit le worker, vas chercher les infos sur l'api repondit l'interactor (si cetait pas un test on aurais pu verrifié l'etat du reseau et voir ce quon avait en database)" */
        
        self.listingWorker?.getListing(completionHandler: { data, error in
            DispatchQueue.main.async {
                if error != nil {
                    /*
                     Le Worker : "interactore!, interactore j'ai une erreur"
                     L'interactor: "T'inquiete poto j'ai une connaissance qui va gerer ca, on l'appel le presenter
                     "*/
                    self.presenter?.presentErrorMessage(error: error!)
                    return
                }
                
                /*
                 Worker : J'ai des donnée je crois
                 Interactor : verifie quand meme on ne sait jamais, car il etait une fois ...
                 */
                
                guard let verifiedDatas = data else {
                    /*
                     Worker : "j'ai bien fait de verifié sinon je me saurais fait engueuler encore une fois"
                     */
                    self.presenter?.presentErrorMessage(error: APIServiceError.emptyData)
                    return
                }
                
                /*
                 Worker: "c'est bon j'ai choper ce qu'il te faut"
                 Interactor: "T'es un bon gars, voici l'adresse de me contacte... 1200 Ocean Dr, Miami Beach, soit discret, son nom c'est le presenter il sera quoi faire de ca, mais avant tout ca mes ces info dans cette valise"
                 */
                let response = Listing.API.Response(datas: verifiedDatas)
                self.presenter?.presentClasifiedAd(response: response)
            }
        })
    }
    
    func getCategory(request: CategoryList.API.Request) {
        /*
         Interactor: "tu es la poto ?"
         */
        if self.listingWorker == nil {
            self.listingWorker = ListingWorker()
        }
        
        /*
         Interactor: "J'ai une autre mission pour toi, les infos que tu nous as fournis ne sont pas asser precisent il faut que tu approfondisse ta recherche"
         Worker: " Ok , pas de probleme je mis met"
         */
        
        self.listingWorker?.getCategory(completionHandler: { categories, error in
            DispatchQueue.main.async {
                if error != nil {
                    /*
                     Worker: "Patron, j'ai foiré la mission"
                     Interactore: " Bon ok, je previens le presenter"
                     */
                    self.presenter?.presentErrorMessage(error: error!)
                    return
                }
                /*
                 Worker: "J'ai tout ce qu'il vous faut"
                 Interactor: "OK, tu connais la procedure..."
                 */
                guard let verifiedDatas = categories else {
                    /*
                     Worker : "j'ai bien fait de verifié sinon je me saurais fait engueuler encore une fois"
                     */
                    self.presenter?.presentErrorMessage(error: APIServiceError.emptyData)
                    return
                }
                let response = CategoryList.API.Response(category: verifiedDatas)
                self.presenter?.emitCategories(response: response)
            }
        })
    }
    
    func makeFilter(categories: [Category]) {
     
        self.presenter?.treatmentCategory(categories: categories)
        
    }
    
    func prepareCell(request: Cell.Interface.Request, categories: [Category]) {
    
        /*
         Interactor: "tu es la poto ?"
         */
        if self.listingWorker == nil {
            self.listingWorker = ListingWorker()
        }
        
        /*
         Interatore : "Essaye de choper les tronches des mecs sur lesquel on bosse, merci.
         et oublie pas de monté un resumé sur eux"
         */
        let urlImage = request.info.images_url.small
        self.listingWorker?.getImage(url: urlImage, completionHandler: { image in
            DispatchQueue.main.async {
            
                let categoryName = categories.name(id: request.info.category_id)
                let title = request.info.title
                let price =  request.info.price
                let urgent = request.info.is_urgent
                let cell = request.cell
                let response = Cell.Interface.Response(image: image,
                                                       categoryName: categoryName,
                                                       title: title,
                                                       price: price,
                                                       urgent: urgent,
                                                       cell: cell)
                self.presenter?.configureCell(response: response)
            }
        })
    }
    
    func sortListingByID(request: Sort.Element.Request) {
        /*
         Interactor: "tu es la poto ?"
         */
        if self.listingWorker == nil {
            self.listingWorker = ListingWorker()
        }
        
        /*
         Interactore: "houhou poto!  jai le vrai big boss la il veux que les dossier sur un parrain de la pegre denomé ...."
         Worker: "No problem boss, je regroupe ca et je tenvoie .... et oui je sais direct dans la valise secu"
         
         */
        self.listingWorker?.sorteByCategory(id: request.id, listing: request.listing, categories: request.categories, completionHandler: { listing, name in
            DispatchQueue.main.async {
                let response = Sort.Element.Response(categoryName: name, listingByCategory: listing)
                self.presenter?.presentListingByCategory(request: response)
            }
        })
       
    }
    
    func filterListingByText(request: Filter.Element.Request) {
        /*
         Interactor: "tu es la poto ?"
         */
        if self.listingWorker == nil {
            self.listingWorker = ListingWorker()
        }
        /*
         Interactore : "J'ai pris un cuite hier laisse tomber, tu peux me retrouver le dossier qui s'appele ..."
         Worker: "Serieux je fait tout le boulot jen ai mare"
         */
        guard let litingFiltered = self.listingWorker?.filterByText(searchText: request.searchText, listing: request.listing) else {
            return
        }
        
        /* Worker : "c'est bon jai ce quil faut, jai du fouillé dans tout les dossier par titre et description cest trop relou "
         Intercator: "Tu assures... bon met ca dans la valise securisé et jenvoie ca a mon contact"*/
        
        let response = Filter.Element.Response(listingFilterdBytext: litingFiltered)
        self.presenter?.presentListingFilteredByText(request: response)
    }
    
}

//
//  ApiImplementation.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import UIKit

enum APIServiceError: Error {
    case badUrl, requestError, decodingError, statusNotOK, emptyData
}

struct ApiImplementation: ApiProtocol {

    static let baseUrl: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"

    func getListing(completionHandler: @escaping ApiListingCompletionHandler) {
        guard let url = ApiImplementation.listingUrl() else {
            completionHandler(nil, APIServiceError.badUrl)
            return
        }
        self.makeRequest(url: url) { data, error in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            guard let data = data, let resultDecoded = try? JSONDecoder().decode([ClassifiedAdApiEntity].self, from: data) else {
                completionHandler(nil, APIServiceError.decodingError)
                return
            }

            let models = resultDecoded.toModel()
            completionHandler(models, nil)
        }
    }

    func getCategory(completionHandler: @escaping ApiCategoryCompletionHandler) {
        guard let url = ApiImplementation.categoryUrl() else {
            completionHandler(nil, APIServiceError.badUrl)
            return
        }
        self.makeRequest(url: url) { data, error in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            let string = String(data: data!, encoding: .utf8)

            guard let resultDecoded = try? JSONDecoder().decode([CategoryAPIEntity].self, from: data!) else {
                completionHandler(nil, APIServiceError.decodingError)
                return
            }

            let models = resultDecoded.toModel()
            completionHandler(models, nil)
        }
    }

    private func makeRequest(url: URL, completionHandler: @escaping ApiDataCompletionHandler) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil {
                completionHandler(nil, APIServiceError.requestError)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, APIServiceError.statusNotOK)
                return
            }

            guard let data = data else {
                completionHandler(nil, APIServiceError.emptyData)
                return
            }

            completionHandler(data, nil)
        }
        task.resume()
    }

    func getImageFrom(url: String, completionHandler: @escaping ApiImageCompletionHandler) {
        guard let correctUrl = URL(string: url) else {
            completionHandler(UIImage(named: "emptyImage")!)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: correctUrl) { (data, _, error) in
            if error != nil {
                completionHandler(UIImage(named: "emptyImage")!)
                return
            }

            if let unwrappedData = data {
                guard let image = UIImage(data: unwrappedData) else {
                    completionHandler(UIImage(named: "emptyImage")!)
                    return
                }
                completionHandler(image)
            }
        }
        dataTask.resume()
    }

    static func listingUrl() -> URL? {
        return URL(string: "\(ApiImplementation.baseUrl)" + "listing.json")
    }

    static func categoryUrl() -> URL? {
        return URL(string: "\(ApiImplementation.baseUrl)" + "categories.json")
    }

}

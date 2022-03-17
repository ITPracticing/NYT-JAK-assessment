//
//  APIManager.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import Foundation

class APIManager {
    
    static let shareManager = APIManager()
    
    private var dataTask: URLSessionDataTask?
    
    func getDesiredArticleData(desredArticle: String?, completion: @escaping (Result<SearchingArticleDataModel, Error>) -> Void) {
        
        guard let desredArticle = desredArticle else { return }
        let desiredArticelURL = APIKeys.UrlExtensions.fetchSearchingURL(articleName: (desredArticle.replacingOccurrences(of: " ", with: "")))
        guard let url = URL(string: desiredArticelURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(SearchingArticleDataModel.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    
    func getPopularArticleData(desiredPopulareArctcile: String, desiredPeriod: MostPopularePeriodModel = .lastDay, completion: @escaping (Result<PopulareArticleArrayDataModel, Error>) -> Void) {
        
        let popularArticleURL = APIKeys.UrlExtensions.fetchPopulareArticleURL(requiredPopulareArticle: desiredPopulareArctcile, desiredPeriod: desiredPeriod)
        print(popularArticleURL)
        guard let url = URL(string: popularArticleURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PopulareArticleArrayDataModel.self, from: data)
                print(jsonData)
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}



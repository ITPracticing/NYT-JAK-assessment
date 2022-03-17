//
//  APIKeys.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import Foundation

struct APIKeys {
    struct UrlExtensions {
        // My own Unique API Key
        static let myAPIKey = "wByi4oqAIs2GUoKtsAKMAHfAh0BrsXQs"
        
        /// Ex Format: "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=yourkey"
        static let mainPopularUrl = "https://api.nytimes.com/svc/mostpopular/v2/"
        
        /// Ex Format: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=wByi4oqAIs2GUoKtsAKMAHfAh0BrsXQs&q=election"
        static let mainSearchUrl = "https://api.nytimes.com/svc/search/v2/articlesearch.json?"

        // Test Urls
//        static let smaplePopulareurl = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=wByi4oqAIs2GUoKtsAKMAHfAh0BrsXQs"
//        static let sampleSearchingUrl = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=wByi4oqAIs2GUoKtsAKMAHfAh0BrsXQs&q=Travel"
        static func fetchSearchingURL(articleName: String) -> String {
            return mainSearchUrl + "q=\(articleName)" + "&api-key=\(myAPIKey)"
        }
        static func fetchPopulareArticleURL(requiredPopulareArticle: String, desiredPeriod: MostPopularePeriodModel) -> String {
            return mainPopularUrl + "\(requiredPopulareArticle)" + "/\(desiredPeriod).json?" + "api-key=\(myAPIKey)"
        }
    }
  }


//
//  DataModel.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import Foundation

// MARK: -  For serching articles

struct SearchingArticleDataModel: Decodable {
    let result: SearchingArticleArray?
    
    private enum CodingKeys: String, CodingKey {
        case result = "response"
    }
}
struct SearchingArticleArray: Decodable {
    let articles: [SearchingArticleDetails]
    
    private enum CodingKeys: String, CodingKey {
        case articles = "docs"
    }
}
struct SearchingArticleDetails: Decodable {
    let title: SearchingArticelTitle?
    let year: String?

    
    private enum CodingKeys: String, CodingKey {
        case year = "pub_date"
        case title = "headline"

    }
}
struct SearchingArticelTitle: Decodable {
    let titleName: String?
    
    private enum CodingKeys: String, CodingKey {
        case titleName = "main"
    }
}


// MARK: -  For populare articles

struct PopulareArticleArrayDataModel: Decodable {
    let results: [PopulareArticleDetails]
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
struct PopulareArticleDetails: Decodable {
    let title: String?
    let year: String?

    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case year = "published_date"

    }
}
struct PopulareArticelTitle: Decodable {
    let titleName: String?
    
    private enum CodingKeys: String, CodingKey {
        case titleName = "main"
    }
}

//
//  ArticleData.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import Foundation

struct ArticleData {
    
    // Names of Articles extract from  "https://developer.nytimes.com/docs/articlesearch-product/1/overview"
    static let SearchingArticelNamesArray = [
        "Adventure Sports",
        "Arts & Leisure",
        "Arts",
        "Automobiles",
        "Blogs",
        "Books",
        "Booming",
        "Business Day",
        "Business",
        "Cars",
        "Circuits",
        "Classifieds",
        "Connecticut",
        "Crosswords & Games",
        "Culture",
        "DealBook",
        "Dining",
        "Editorial",
        "Education",
        "Energy",
        "Entrepreneurs",
        "Environment",
        "Escapes",
        "Fashion & Style",
        "Fashion",
        "Favorites",
        "Financial",
        "Flight",
        "Food",
        "Foreign",
        "Generations",
        "Giving",
        "Global Home",
        "Health & Fitness",
        "Health",
        "Home & Garden",
        "Home",
        "Jobs",
        "Key",
        "Letters",
        "Long Island",
        "Magazine",
        "Market Place",
        "Media",
        "Men's Health",
        "Metro",
        "Metropolitan",
        "Movies",
        "Museums",
        "National",
        "Nesting",
        "Obits",
        "Obituaries",
        "Obituary",
        "OpEd",
        "Opinion",
        "Outlook",
        "Personal Investing",
        "Personal Tech",
        "Play",
        "Politics",
        "Regionals",
        "Retail",
        "Retirement",
        "Science",
        "Small Business",
        "Society",
        "Sports",
        "Style",
        "Sunday Business",
        "Sunday Review",
        "Sunday Styles",
        "T Magazine",
        "T Style",
        "Technology",
        "Teens",
        "Television",
        "The Arts",
        "The Business of Green",
        "The City Desk",
        "The City",
        "The Marathon",
        "The Millennium",
        "The Natural World",
        "The Upshot",
        "The Weekend",
        "The Year in Pictures",
        "Theater",
        "Then & Now",
        "Thursday Styles",
        "Times Topics",
        "Travel",
        "U.S.",
        "Universal",
        "Upshot",
        "UrbanEye",
        "Vacation",
        "Washington",
        "Wealth",
        "Weather",
        "Week in Review",
        "Week",
        "Weekend",
        "Westchester",
        "Wireless Living",
        "Women's Health",
        "Working",
        "Workplace",
        "World",
        "Your Money"
    ]
    
}
    

// for poplare articles
    enum MostPopulareArticleTypeModel: CaseIterable, CustomStringConvertible {
        
        case viewed
        case shared
        case emailed

        static let allCases: [MostPopulareArticleTypeModel] = [viewed, shared, emailed]
        static var populaterTiltesArray: [String] {
            return ["Most Viewed", "Most Shared", "Most Emailed"]
        }
        
        var description: String {
            switch self {
            case .viewed:
                return "viewed"
            case .shared:
                return "shared"
            case .emailed:
                return "emailed"
            }
        }
    }
    
    enum MostPopularePeriodModel: CaseIterable, CustomStringConvertible {
        
        case lastDay
        case last7Days
        case last30Days
        
        var description: String {
            switch self {
            case .lastDay:
                return "1"
            case .last7Days:
                return "7"
            case .last30Days:
                return "30"
            }
        }
    }

// determine the articles list should arisen from search or populre view
enum ArticlesListViewSection {
    case searchSection
    case populareSection
    
}
    

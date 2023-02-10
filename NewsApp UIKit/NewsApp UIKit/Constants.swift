//
//  Constants.swift
//  NewsApp UIKit
//

//Data for API

//Api Guide
//https://newsapi.org/docs/get-started

import Foundation

struct Constants {
    
//    API_KEY = "Your API key"
    static var API_KEY = ""
    static var API_URL = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2023-01-23&sortBy=popularity&apiKey=\(Constants.API_KEY)")
}

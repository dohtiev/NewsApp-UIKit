//
//  Constants.swift
//  NewsApp UIKit
//

import Foundation

struct Constants {
    static var API_KEY = ""
    static var API_URL = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2023-01-23&sortBy=popularity&apiKey=\(Constants.API_KEY)")
}

//Api Guide
//https://newsapi.org/docs/get-started

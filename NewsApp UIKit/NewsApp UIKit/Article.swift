//
//  Article.swift
//  NewsApp UIKit
//

import Foundation

struct Article: Hashable, Identifiable{
    var id = UUID()
    var name: String = ""
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
}

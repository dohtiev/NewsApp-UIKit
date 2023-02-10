//
//  Article.swift
//  NewsApp UIKit
//

//Article data structure

import UIKit

class Article: NSObject{
    var id = UUID()
    var name: String?
    var author: String?
    var title: String?
    var desc: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

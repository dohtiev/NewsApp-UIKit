//
//  DateFormatter.swift
//  NewsApp UIKit
//

import Foundation

func formatDate(date: String) -> String {
   let dateFormatterGet = DateFormatter()
   dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
   let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "en_US")
   let dateObj: Date? = dateFormatterGet.date(from: date)
   return dateFormatter.string(from: dateObj!)
}

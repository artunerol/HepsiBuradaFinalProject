//
//  DateFormatterHandler.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 31.10.2021.
//

import UIKit

class DateFormatterHandler {
    
    static let shared = DateFormatterHandler()
    
    public func getFormattedDate(with inputDate: String) -> String{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"

            let date: Date? = dateFormatterGet.date(from: inputDate)
            return dateFormatterPrint.string(from: date!);
        }
}

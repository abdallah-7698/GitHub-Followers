//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by MacOS on 27/07/2022.
//

import Foundation

// conver the String date into Date then convert the date into String again

extension Date{

    func convertToMonthYearFormat()->String{
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}

//extension String{
//    func convertToDate()->Date?{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = .current
//        return dateFormatter.date(from: self)
//    }
//
//    // conpine the two func
//    func convertToDisplayFormat()->String{
//        guard let date = self.convertToDate() else {return "N/A"}
//        return date.convertToMonthYearFormat()
//    }
//
//}

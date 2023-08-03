//
//  Date+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/2/23.
//

import Foundation

extension Date {
    
    func toString(format:String = "yyyy") -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}

//
//  String+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/4/23.
//

import Foundation

extension String {
    
    func extractDate() -> Date? {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
            
            for match in matches {
                if match.resultType == .date, let date = match.date {
                    return date
                }
            }
        } catch {
            print("Error creating NSDataDetector: \(error)")
        }
        
        return nil
    }
    
}

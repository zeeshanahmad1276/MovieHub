//
//  UIImage+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

extension UIImage {
    
    func saveImageToDocumentsDirectory(withName name: String) {
        guard let data = self.jpegData(compressionQuality: 1.0) else {
            print("Error converting image to data.")
            return
        }
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent(name)
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error saving image to documents directory: \(error.localizedDescription)")
        }
    }

}

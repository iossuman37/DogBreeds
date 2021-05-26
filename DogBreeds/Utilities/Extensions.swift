//
//  Extensions.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import Foundation
import UIKit
let imageCache = NSCache<NSString, UIImage>()
//Fetch image asynchronously for imageView
class DogBreedImageView: UIImageView {
    
    var urlString : String?
    
    func loadImageFromUrlString(path: String){
        let url = URL(string: path)
        urlString = path
        
        image = nil
        self.contentMode = .scaleAspectFit
        if let imageFromCache = imageCache.object(forKey: path as NSString) {
            self.image = imageFromCache
            return
        }
        session.dataTask(with: url!, completionHandler: { (data,response,error) in
            if error != nil {
                print(error?.localizedDescription ?? "NA")
                return
            }
            
            if let imageData = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: imageData){
                        
                        if self.urlString == path {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: path as NSString)
                    }
                }
            }
            
            }).resume()
        
    }
}

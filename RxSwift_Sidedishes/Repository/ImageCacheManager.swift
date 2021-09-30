//
//  ImageCacheManager.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/09/28.
//

import Foundation
import UIKit

class ImageCacheManager {
    
    let cacheManager: NSCache<NSString, UIImage>
    
    init() {
        cacheManager = NSCache<NSString, UIImage>()
    }
    
    func fetchImage(url: String) -> UIImage {
        let cacheKey = NSString(string: url)
        var resultImage = UIImage()
        
        if let cachedImage = cacheManager.object(forKey: cacheKey) {
            return cachedImage
        }
        
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let _ = error {
                    resultImage = UIImage()
                }
                if let data = data, let image = UIImage(data: data) {
                    self?.cacheManager.setObject(image, forKey: cacheKey)
                    resultImage = image
                }
            }
            return resultImage
        }
    }
}

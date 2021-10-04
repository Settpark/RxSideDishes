//
//  ImageCacheManager.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/09/28.
//

import UIKit

class ImageCacheManager {
    
    let cacheManager: NSCache<NSString, UIImage>
    let apiservice: APIServiceType
    
    init(apiservice: APIServiceType) {
        self.cacheManager = NSCache<NSString, UIImage>()
        self.apiservice = apiservice
    }
    
    func getCachedImage(url: String, onComplete: @escaping (Result<UIImage, Error>) -> Void) {
        let cacheKey = NSString(string: url)
        var resultImage = UIImage(systemName: "arrow.uturn.up")!
        
        if let cachedImage = cacheManager.object(forKey: cacheKey) {
            onComplete(.success(cachedImage))
        }
        else {
            self.apiservice.getfetchedImage(url: url) { result in
                switch result {
                case .success(let image):
                    self.cacheManager.setObject(resultImage, forKey: cacheKey)
                    onComplete(.success(image))
                case .failure(_):
                    resultImage = UIImage(systemName: "trash") ?? UIImage()
                }
            }
        }
    }
    
    
}

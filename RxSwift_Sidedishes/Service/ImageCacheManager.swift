//
//  ImageCacheManager.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/09/28.
//

import UIKit
import RxSwift

class ImageCacheManager {
    
    let cacheManager: NSCache<NSString, UIImage>
    let apiservice: APIServiceType
    
    init(apiservice: APIServiceType) {
        self.cacheManager = NSCache<NSString, UIImage>()
        self.apiservice = apiservice
    }
    
    func getCachedImage(url: String) -> Observable<UIImage> {
        let cacheKey = NSString(string: url)
        
        if let cachedImage = cacheManager.object(forKey: cacheKey) {
            return Observable<UIImage>.just(cachedImage)
        }
        else {
            return self.apiservice.getfetchedImage(url: url)
                .do { self.cacheManager.setObject($0, forKey: cacheKey)}
                .map { $0 }
        }
    }
    
    
}

//
//  ImageCacheManager.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/09/28.
//

import UIKit
import RxSwift

class ImageCacheManager {
    
    private let diskCacheManager = FileManager.default
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
    
    func getDiskCachedImage(url: String) -> Observable<UIImage> {
        let cachedDirectory = diskCacheManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let dataPath = cachedDirectory.appendingPathComponent("DiskCache")
        let strPath = dataPath.appendingPathComponent(url.split(separator: "/").last!.description)
        makeDirectory(url: dataPath)
        if diskCacheManager.fileExists(atPath: strPath.path) {
            do {
                let data = try Data(contentsOf: strPath)
                let image = UIImage(data: data) ?? UIImage()
                return Observable<UIImage>.just(image)
            } catch {
                return Observable<UIImage>.just(UIImage())
            }
        } else {
            return self.apiservice.getfetchedImage(url: url)
                .do { self.diskCacheManager.createFile(atPath: strPath.path, contents: $0.pngData() , attributes: nil); print("저장함")}
                .map { $0 }
        }
    }
    
    func makeDirectory(url: URL) {
        if !diskCacheManager.fileExists(atPath: url.path) {
            do {
                try diskCacheManager.createDirectory(atPath: url.path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                
            }
        }
    }
    
}

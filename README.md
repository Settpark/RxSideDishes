# RxSideDishes

### 1. Sequence Diagram

<p align="center"><img src="ReadmeImage/Banchan_Sequence_Diagram.png" width="" height="270"/>


### 2. ImageCache

1. 1차시도(메모리 캐시) - ImageCache매니저를 싱글톤으로 생성하고, UIImageView를 Extension함.

```Swift
class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

extension UIImageView {
    func setImageUrl(_ url: String) {
        
        let cacheKey = NSString(string: url)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            print("캐시에서 가져옴")
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                            print("네트워크에서 가져옴")
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}

```
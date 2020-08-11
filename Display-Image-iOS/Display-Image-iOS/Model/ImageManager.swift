import Foundation
import UIKit

protocol ImageManagerDelegate {
    func imageManagerDidFinishLoadingImage(image: UIImage)
    func imageManagerDidFailToLoadImage()
}

struct ImageManager {
    
    var delegate: ImageManagerDelegate?
    
    func performRequest(with url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.imageManagerDidFailToLoadImage()
                return
            }else if let safeData = data {
                if let image = UIImage(data: safeData) {
                    self.delegate?.imageManagerDidFinishLoadingImage(image: image)
                }else {
                    self.delegate?.imageManagerDidFailToLoadImage()
                    return
                }
            }else {
                self.delegate?.imageManagerDidFailToLoadImage()
                return
            }
        }
        task.resume()
    }
}

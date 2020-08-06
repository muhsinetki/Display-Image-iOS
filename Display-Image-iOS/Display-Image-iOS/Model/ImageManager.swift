import Foundation
import UIKit

protocol ImageManagerDelegate {
    func didDownloadImage(_ imageManager: ImageManager, image: UIImage)
    func didFailWithError(error: Error)
}

struct ImageManager {
    
    var delegate: ImageManagerDelegate?
    
    func performRequest(with url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                if let image = UIImage(data: safeData) {
                    self.delegate?.didDownloadImage(self, image: image)
                }
            }
        }
        task.resume()
    }
}

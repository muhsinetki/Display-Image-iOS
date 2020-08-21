//
//  ViewController.swift
//  Display-Image-iOS
//
//  Created by Muhsin Etki on 5.08.2020.
//  Copyright © 2020 Muhsin Etki. All rights reserved.
//

import UIKit
import NVActivityIndicatorViewExtended
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlTextField: UITextField!
    var imageManager = ImageManager()
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageManager.delegate = self
        self.view.addSubview(activityIndicator)
        activityIndicator.isHidden=true
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        if let urlString = urlTextField.text {
            if let url = URL(string: urlString){
                imageManager.performRequest(with: url)
                activityIndicator.startAnimating()
            }
        }
        self.imageView.image = nil
    }
}

//MARK: - ImageManagerDelegate
extension ViewController: ImageManagerDelegate {
    
    func imageManagerDidFinishLoadingImage(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    func imageManagerDidFailToLoadImage() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            self.imageView.image = nil
            let alertController = UIAlertController(title: self.title, message: "Invalid image URL", preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            { action -> Void in
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

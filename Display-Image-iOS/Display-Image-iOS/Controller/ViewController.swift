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
    var activityIndicator : NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageManager.delegate = self
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: view.center.x/2, y: view.center.y/2 , width: view.frame.width/2, height: view.frame.height/2), type: .pacman, color: .systemPink, padding: 0)
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        if let urlString = urlTextField.text {
            if let url = URL(string: urlString){
                imageManager.performRequest(with: url)
                if let indicator = activityIndicator{
                    self.view.addSubview(indicator)
                    indicator.startAnimating()
                }
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
            if let indicator = self.activityIndicator {
                indicator.stopAnimating()
            }
        }
    }
    
    func imageManagerDidFailToLoadImage() {
        DispatchQueue.main.async {
            if let indicator = self.activityIndicator {
                indicator.stopAnimating()
            }
            self.imageView.image = nil
            let alertController = UIAlertController(title: self.title, message: "Invalid image URL", preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            { action -> Void in
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

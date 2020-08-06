//
//  ViewController.swift
//  Display-Image-iOS
//
//  Created by Muhsin Etki on 5.08.2020.
//  Copyright © 2020 Muhsin Etki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageManager = ImageManager()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageManager.delegate = self
        urlTextField.delegate = self
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        urlTextField.endEditing(true)
        self.imageView.image = nil
        self.loadingLabel.text = "Loading..."
    }
}

//MARK: - ImageManagerDelegate
extension ViewController: ImageManagerDelegate {
    func didDownloadImage(_ imageManager: ImageManager, image: UIImage) {
        
        DispatchQueue.main.async {
            self.imageView.image = image
            self.loadingLabel.text = ""
        }
        
        
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.imageView.image = nil
            self.loadingLabel.text = ""
            
            let alertController = UIAlertController(title: self.title, message: "Invalid image URL", preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            { action -> Void in
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlTextField.endEditing(true)
        self.imageView.image = nil
        self.loadingLabel.text = "Loading..."
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type URL"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let urlString = urlTextField.text {
            if let url = URL(string: urlString){
                imageManager.performRequest(with: url)
            }
        }
        urlTextField.text = ""
    }
}

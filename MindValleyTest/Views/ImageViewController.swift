//
//  ImageViewController.swift
//  MindValleyTest
//
//  Created by Vahe on 9/22/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageUrl : ImageURL?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightOrientation()
        viewIsReady()
    }
    
    private func viewIsReady() {
        if let inImage = imageUrl {
            imageView.setImageFrom(imageURLString: inImage.full, placeHolderImage: nil, progressHandler: { [unowned self] (totalExpectedBytes, downloadedBytes, error) in
                let progress = Float(downloadedBytes) / Float(totalExpectedBytes)
                self.progressView.setProgress(progress, animated: true)
            }) { (image, error) in
                self.progressView.isHidden = true
            }
        }
    }
    
    private func setRightOrientation() {
        if UIDevice.current.orientation.isLandscape {
            imageView.contentMode = .scaleToFill
        } else {
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setRightOrientation()
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func swipeGestureActions(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

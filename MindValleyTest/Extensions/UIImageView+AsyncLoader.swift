//
//  UIImageView+AsyncLoader.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import UIKit

protocol AsyncLoader {
    func setImageFrom(imageURLString: String, placeHolderImage: UIImage?, completionHandler: DownloadHandler?)
    func setImageFrom(imageURLString : String, placeHolderImage: UIImage?, progressHandler: @escaping DownloadProgressHandler, completionHandler: @escaping DownloadHandler)
}

typealias DownloadHandler = (_ image: UIImage?,  _ error: Error?) -> Void
typealias DownloadProgressHandler = (_ totalBytesExpected : Int64,  _ bytesDownloaded: Int64, _ error : Error?) -> Void

extension UIImageView: AsyncLoader {
    
    func setImageFrom(imageURLString : String, placeHolderImage: UIImage? = nil, completionHandler: DownloadHandler?) {
        guard imageURLString.count > 0 else {
            if let handler = completionHandler {
                handler(nil, nil)
            }
            return
        }
        if placeHolderImage != nil {
            image = placeHolderImage
        }
        ImageDownloadManager.shared.getImageFromURL(imageURLString: imageURLString) { (image : UIImage?, error :Error?) in
            guard let inImage = image else {
                if let handler = completionHandler {
                    handler(nil, error)
                }
                return
            }
            self.updateImage(image: inImage, imageUrl: imageURLString)
            if let handler = completionHandler {
                handler(inImage, nil)
            }
        }
    }
    
    func setImageFrom(imageURLString: String, placeHolderImage: UIImage? = nil, progressHandler: @escaping DownloadProgressHandler, completionHandler: @escaping DownloadHandler) {
        guard imageURLString.count > 0  else {
            completionHandler(nil, nil)
            return
        }
        if placeHolderImage != nil {
            self.image = placeHolderImage;
        }
        ImageDownloadManager.shared.getImageFromURL(imageURLString: imageURLString, progessHandler: { (expectedBytes: Int64, downloadedBytes: Int64, error: Error?) in
            progressHandler(expectedBytes, downloadedBytes, error)
        }) { (image: UIImage?, error: Error?) in
            guard let inImage = image else {
                completionHandler(nil, nil)
                return
            }
            self.updateImage(image: inImage, imageUrl: imageURLString)
            completionHandler(inImage, error)
        }
    }
    
    private func updateImage(image: UIImage, imageUrl: String) {
        UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}

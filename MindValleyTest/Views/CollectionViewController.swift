//
//  CollectionViewController.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var dataManager = DataManager()
    let transitionDelegate: CollectionViewTransitioningDelegate = CollectionViewTransitioningDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewIsReady()
    }
    
    private func viewIsReady() {
        dataManager.fetchPerson(success: {
            self.collectionView.reloadData()
        }) { error in
            switch error {
            case .NoInternetConnection:
                self.showError(message: Defines.Messages.NoInternetConnectionMessage.rawValue)
                return
            case .TimeOut:
                self.showError(message: Defines.Messages.TimeOut.rawValue)
                return
            default:
                self.showError(message: Defines.Messages.UnknownError.rawValue)
                return
            }
        }
    }
    
    private func showError(message: String) {
        let alertController = UIAlertController(title: Defines.Messages.ErrorTitle.rawValue, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.numberOfImages()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        configureCell(cell: cell, for: dataManager.imageUrlAt(index: indexPath.row)!)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let attributes = collectionView.layoutAttributesForItem(at: indexPath as IndexPath)
        let attributesFrame = attributes?.frame
        let frameToOpenFrom = collectionView.convert(attributesFrame!, to:  collectionView.superview)
        transitionDelegate.openingFrame = frameToOpenFrom
        let imageViewController = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        imageViewController.imageUrl = dataManager.imageUrlAt(index: indexPath.row)
        imageViewController.modalPresentationStyle = .custom
        imageViewController.transitioningDelegate = transitioningDelegate
        present(imageViewController, animated: true, completion: nil)
    }
    
    func configureCell(cell: CollectionViewCell, for image: ImageURL) {
        cell.imageView.setImageFrom(imageURLString: image.thumb, placeHolderImage: #imageLiteral(resourceName: "placeholder"), completionHandler: nil)
    }
}

//
//  DataManager.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

final class DataManager: NSObject {
    
    var personService = PersonService()
    var images: NSMutableArray = []
    
    func fetchPerson(success: @escaping (() -> ()), failure: ((RequestError) -> ())?) {
        personService.performPersons(success: { [unowned self] (isSuccess, response) in
            do {
                if response != nil {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode([Person].self, from: response!)
                    for person in responseData {
                        let photosURL = ImageURL(full: person.imageURLs.full, thumb: person.imageURLs.thumb)
                        self.images.add(photosURL)
                    }
                    success()
                }
            } catch {
                fatalError("Can't decode to Person")
            }
        }) { (error) in
            failure?(error)
        }
    }
    
    func numberOfImages() -> Int {
        return images.count
    }
    
    func imageUrlAt(index: Int) -> ImageURL? {
        var image: ImageURL? = nil
        if index < images.count {
            image = images[index] as? ImageURL
        }
        return image
    }
}

//
//  dogsViewModel.swift
//  konfioExercise
//
//  Created by Flink on 12/16/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import Foundation
import UIKit

class dogsViewModel{
    
    private let context = coreDataManager.shared.persistentContainer.viewContext
    private var arrDogs = [dog]()
    private var arrImages = [String:UIImage]()
    var localArrDogs = [Dogs]()
    var dispatchGroup = DispatchGroup()
    
    func numberSections() -> Int{
        return 1
    }
    
    func numberRowsInSection() -> Int{
        return arrDogs.count
    }
    
    func dogIndexPath(indexPath: Int) -> dog
    {
        return arrDogs[indexPath]
    }
    
    func getImageDowAtIndex(url: String) -> UIImage?
    {
        return arrImages[url]
    }
    
    func getTextAge(age: Int) -> String{
        if age > 1{
            return "Almost \(age) years"
        }else{
            return "Almost \(age) year"
        }
    }
    
    func checkLocalData(completion: @escaping ((Bool) -> Void))
    {
        do{
            localArrDogs = try context.fetch(Dogs.fetchRequest())
            if localArrDogs.count != 0
            {
                for data in localArrDogs
                {
                    let localDog = dog(dogName: data.dogName!, description: data.dogDescription!, age: Int(data.dogAge), url: data.dogUrl!)
                    arrDogs.append(localDog)
                }
                completion(true)
            }
            else
            {
                completion(false)
            }
        }catch let error as NSError{
            print("error \(error) \(error.userInfo)")
            completion(false)
        }
    }
    
    func getData(completion: @escaping ((Bool) -> Void))
    {
        apiKonfio.shared.downloadData{ (status, info) in
            if status != 200
            {
                completion(false)
            }
            else
            {
                self.cleanData(info: info) { (flag) in
                    completion(flag)
                }
            }
        }
    }
    
    func cleanData(info: NSDictionary, completion: @escaping ((Bool) -> Void))
    {
        if let data = info["data"] as? [[String:Any]]
        {
            apiKonfio.shared.cleanDogs(data: data){ (arrDogs) in
                self.arrDogs = arrDogs
                self.saveData { (flag) in
                    print(flag)
                }
                completion(true)
            }
        }
        else
        {
            completion(false)
        }
    }
    
    func downloadImages(completion: @escaping ((Bool) -> Void))
    {
        let images = self.arrDogs.map( {$0.url} )
        let reduceImages = Array(Set(images))
        if reduceImages.count != 0
        {
            for urlImage in reduceImages
            {
                dispatchGroup.enter()
                let imageDownloaded = UIImage()
                let cleanUrl = urlImage.replacingOccurrences(of: " ", with: "")
                imageDownloaded.downloaded(from: cleanUrl) { (image, urlImage2) in
                    DispatchQueue.main.async {
                        self.arrImages[urlImage2] = image
                        self.dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                completion(true)
            }
        }
        else
        {
            completion(false)
        }
    }
    
    func saveData(completion: @escaping ((Bool) -> Void))
    {
        for puppy in arrDogs
        {
            let dogSave = Dogs(entity: Dogs.entity(), insertInto: self.context)
            dogSave.dogAge = Int16(puppy.age)
            dogSave.dogDescription = puppy.description
            dogSave.dogName = puppy.dogName
            dogSave.dogUrl = puppy.url
            if !coreDataManager.shared.saveContext()
            {
                completion(false)
            }
            else
            {
                completion(true)
            }
        }
    }
    
}

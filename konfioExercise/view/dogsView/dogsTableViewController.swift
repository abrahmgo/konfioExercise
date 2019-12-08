//
//  dogsTableViewController.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class dogsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private let context = coreDataManager.shared.persistentContainer.viewContext
    private var arrDogs = [dog]()
    private var arrImages = [String:UIImage]()
    var localArrDogs = [Dogs]()
    var dispatchGroup = DispatchGroup()
    var useFlag = 0
    
    func initView()
    {
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = useFlag == 0 ? "Dogs We Love" : "Dogs I Love"
        checkLocalData()
    }
    
    func getData()
    {
        apiKonfio.shared.downloadData{ (status, info) in
            if status != 200
            {
                self.showAlertMessage(titleStr: "Dogs", messageStr: (info["message"] as! String) + " \(status). 😿 ")
            }
            else
            {
                self.cleanData(info: info)
            }
        }
    }
    
    func cleanData(info: NSDictionary)
    {
        if let data = info["data"] as? [[String:Any]]
        {
            apiKonfio.shared.cleanDogs(data: data){ (arrDogs) in
                DispatchQueue.main.async {
                    self.arrDogs = arrDogs
                    self.saveData()
                    self.downloadImages()
                    self.tableView.reloadData()
                }
            }
        }
        else
        {
            self.showAlertMessageCompletion(titleStr: "Dogs", messageStr: "Incorrect data format. 😿") { (_) in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func saveData()
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
                DispatchQueue.main.async {
                    self.showAlertMessage(titleStr: "Dogs", messageStr: "We couldn't save the puppies 🐕")
                }
            }
        }
    }
    
    func downloadImages()
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
                        self.tableView.reloadData()
                        self.dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
            }
        }
    }
    
    func checkLocalData()
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
                DispatchQueue.main.async {
                    self.downloadImages()
                    self.tableView.reloadData()
                }
            }
            else
            {
                self.getData()
            }
        }catch let error as NSError{
            print("error \(error) \(error.userInfo)")
            DispatchQueue.main.async {
                self.showAlertMessageCompletion(titleStr: "Dogs", messageStr: "Somethin is wrong \(error) \(error.userInfo) 🤬", completion: { (_) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrDogs.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! dogCellTableViewCell
        if arrDogs.count != 0
        {
            cell.showTitle.text = arrDogs[indexPath.row].dogName
            cell.showDescription.text = arrDogs[indexPath.row].description
            cell.showSubtitle.text = "Almost "+String(arrDogs[indexPath.row].age)+" years"
        }
        if arrImages.count != 0
        {
            let urlImage = arrDogs[indexPath.row].url.replacingOccurrences(of: " ", with: "")
            if arrImages.contains(where: { (key,value) -> Bool in
                key == urlImage
            })
            {
                cell.showImage.image = arrImages[urlImage]
            }
        }
        return cell
    }

}

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
    
    private var arrDogs = [dog]()
    private var arrImages = [String:UIImage]()
    var dispatchGroup = DispatchGroup()
    var useFlag = 0
    
    func initView()
    {
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = useFlag == 0 ? "Dogs We Love" : "Dogs I Love"
        apiKonfio.shared.downloadData{ (status, info) in
            if status != 200
            {
                self.showAlertMessage(titleStr: "Dogs", messageStr: "The dogs are unavailable \(status). 😿 ")
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
                    self.downloadImages()
                    self.tableView.reloadData()
                }
            }
        }
        else
        {
            self.showAlertMessage(titleStr: "Dogs", messageStr: "Incorrect data format. 😿")
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

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

    func initView()
    {
        apiKonfio.shared.downloadData{ (status, info) in
            if status != 200
            {
                print("something is wrong")
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
                    self.tableView.reloadData()
                }
            }
        }
        else
        {
            print("formato incorrecto de información")
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
        return cell
    }

}

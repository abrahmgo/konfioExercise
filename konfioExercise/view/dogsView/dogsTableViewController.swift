//
//  dogsTableViewController.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class dogsTableViewController: UITableViewController {
    
    
    private let viewModel = dogsViewModel()
    private let context = coreDataManager.shared.persistentContainer.viewContext
    private var arrDogs = [dog]()
    private var arrImages = [String:UIImage]()
    var localArrDogs = [Dogs]()
    var dispatchGroup = DispatchGroup()
    var useFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    
    func initView()
    {
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = useFlag == 0 ? "Dogs We Love" : "Dogs I Love"
        viewModel.checkLocalData { (flag) in
            if flag
            {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.downloadImages()
            }
            else
            {
                self.viewModel.getData { (flag) in
                    if !flag
                    {
                        DispatchQueue.main.async {
                            self.showAlertMessage(titleStr: "Dogs", messageStr: "We can't retrive the data")
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        self.downloadImages()
                    }
                }
            }
        }
    }
    
    func downloadImages()
    {
        self.viewModel.downloadImages { (flag) in
            if flag
            {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberRowsInSection()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! dogCellTableViewCell
        let dogIndex = viewModel.dogIndexPath(indexPath: indexPath.row)
        let urlImage = dogIndex.url.replacingOccurrences(of: " ", with: "")
        cell.showTitle.text = dogIndex.dogName
        cell.showSubtitle.text = viewModel.getTextAge(age: dogIndex.age)
        cell.showDescription.text = dogIndex.description
        cell.showImage.image = viewModel.getImageDowAtIndex(url: urlImage)
        return cell
    }
}

//
//  mainViewController.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction func dogsWeLove(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "dogsTableView") as! dogsTableViewController
        VC1.useFlag = 0
        self.navigationController?.pushViewController(VC1, animated: true)
    }
    
    @IBAction func dosgILove(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "dogsTableView") as! dogsTableViewController
        VC1.useFlag = 1
        self.navigationController?.pushViewController(VC1, animated: true)
    }
}

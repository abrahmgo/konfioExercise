//
//  ViewController.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        apiKonfio.shared.downloadData { (status, info) in
            print(status)
            print(info)
        }
        // Do any additional setup after loading the view.
    }


}


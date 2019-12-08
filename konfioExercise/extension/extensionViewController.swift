//
//  extensionViewController.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertMessageCompletion(titleStr:String, messageStr:String, completion: @escaping ((Bool) -> Void)) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            completion(true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  labelDescription.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class labelDescription: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    func setupLabel()
    {
        self.font = UIFont.systemFont(ofSize: 13)
        self.textColor = UIColor(hexString: "#666666")
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
    }
}


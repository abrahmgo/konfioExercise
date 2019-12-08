//
//  labelSubTitle.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class labelSubtitle: UILabel {
    
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
        self.font = UIFont.systemFont(ofSize: 12)
        self.textColor = UIColor(hexString: "#333333")
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
    }
}

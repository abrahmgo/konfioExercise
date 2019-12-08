//
//  buttonPrincipal.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class buttonPrincipal: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton()
    {
        self.layer.cornerRadius = 28
        self.titleLabel?.font = .systemFont(ofSize: 22)
        self.setTitleColor(UIColor(hexString: "#F8F8F8"), for: .normal)
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = UIColor(hexString: "#333333")
    }
}

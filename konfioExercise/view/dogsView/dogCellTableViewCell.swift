//
//  dogCellTableViewCell.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit

class dogCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var showSubtitle: UILabel!
    @IBOutlet weak var cardData: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardData.layer.cornerRadius = 5
        showImage.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

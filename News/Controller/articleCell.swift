//
//  articleCell.swift
//  News
//
//  Created by Uri Vishnevski on 27/09/2020.
//  Copyright © 2020 Uri Vishnevski. All rights reserved.
//

import UIKit

class articleCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

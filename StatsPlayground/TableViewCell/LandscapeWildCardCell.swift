//
//  LandscapeWildCardCell.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 20/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class LandscapeWildCardCell: UITableViewCell {
    @IBOutlet weak var wildCardWin1: UIImageView!
    @IBOutlet weak var wildCardWin2: UIImageView!
    @IBOutlet weak var wildCardWin3: UIImageView!
    @IBOutlet weak var wildCardWin4: UIImageView!
    @IBOutlet weak var wildCardWin5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

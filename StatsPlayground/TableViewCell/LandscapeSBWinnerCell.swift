//
//  LandscapeSBWinnerCell.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 20/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class LandscapeSBWinnerCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var Lyear8: UILabel!
    @IBOutlet weak var Lyear7: UILabel!
    @IBOutlet weak var Lyear6: UILabel!
    @IBOutlet weak var Lyear5: UILabel!
    @IBOutlet weak var Lyear4: UILabel!
    @IBOutlet weak var Lyear3: UILabel!
    @IBOutlet weak var Lyear2: UILabel!
    @IBOutlet weak var Lyear1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

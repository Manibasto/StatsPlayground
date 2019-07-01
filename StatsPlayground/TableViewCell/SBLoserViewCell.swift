//
//  SBLoserViewCell.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 20/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class SBLoserViewCell: UITableViewCell {
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var year5: UILabel!
    @IBOutlet weak var year4: UILabel!
    @IBOutlet weak var year3: UILabel!
    @IBOutlet weak var year2: UILabel!
    @IBOutlet weak var year1: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

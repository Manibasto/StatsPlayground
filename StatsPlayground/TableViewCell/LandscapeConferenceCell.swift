//
//  LandscapeConferenceCell.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 20/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class LandscapeConferenceCell: UITableViewCell {
    @IBOutlet weak var conferenceWin1: UIImageView!
    @IBOutlet weak var conferenceWin2: UIImageView!
    @IBOutlet weak var conferenceWin3: UIImageView!
    @IBOutlet weak var conferenceWin4: UIImageView!
    @IBOutlet weak var conferenceWin5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

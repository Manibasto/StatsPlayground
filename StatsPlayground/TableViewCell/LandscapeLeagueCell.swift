//
//  LandscapeLeagueCell.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 20/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class LandscapeLeagueCell: UITableViewCell {
    @IBOutlet weak var leagueWin1: UIImageView!
    @IBOutlet weak var leagueWin2: UIImageView!
    @IBOutlet weak var leagueWin3: UIImageView!
    @IBOutlet weak var leagueWin4: UIImageView!
    @IBOutlet weak var leagueWin5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

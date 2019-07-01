//
//  TableViewCell3.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 11/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class TableViewCell3: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var SBLoser: UILabel!
    @IBOutlet weak var loserYear1: UILabel!
    @IBOutlet weak var loserYear2: UILabel!
    @IBOutlet weak var loserYear3: UILabel!
    @IBOutlet weak var loserYear4: UILabel!
    @IBOutlet weak var loserYear5: UILabel!
    @IBOutlet weak var SBLoser2: UILabel!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

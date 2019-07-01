//
//  TableViewCell4.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 12/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class TableViewCell4: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var divWinner: UILabel!
    @IBOutlet weak var divYear1: UILabel!
    @IBOutlet weak var divYear2: UILabel!
    @IBOutlet weak var divYear3: UILabel!
    @IBOutlet weak var divYear4: UILabel!
    @IBOutlet weak var divYear5: UILabel!
    @IBOutlet weak var divWinner2: UILabel!
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

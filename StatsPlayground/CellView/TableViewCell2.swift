//
//  TableViewCell2.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 11/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//
import UIKit

class TableViewCell2: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var SBWinner: UILabel!
    @IBOutlet weak var year1: UILabel!
    @IBOutlet weak var year2: UILabel!
    @IBOutlet weak var year3: UILabel!
    @IBOutlet weak var year4: UILabel!
    @IBOutlet weak var year5: UILabel!
    @IBOutlet weak var SBWinner2: UILabel!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

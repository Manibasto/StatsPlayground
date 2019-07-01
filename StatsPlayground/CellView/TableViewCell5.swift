//
//  TableViewCell5.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 26/02/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class TableViewCell5: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet weak var playoff: UILabel!
    @IBOutlet weak var win: UILabel!
    @IBOutlet weak var playoff2: UILabel!
    @IBOutlet weak var win2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

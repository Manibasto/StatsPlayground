//
//  TableViewCell6.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 26/02/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class TableViewCell6: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var league2: UILabel!
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

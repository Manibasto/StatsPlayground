//
//  YearViewCell.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 19/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class YearViewCell: UICollectionViewCell {
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                yearLabel.textColor = UIColor.green
//                yearLabel.font = UIFont.boldSystemFont(ofSize: 14)
//            } else {
//                yearLabel.textColor = UIColor.darkText
//                yearLabel.font = UIFont.systemFont(ofSize: 14)
//            }
//        }
//    }

}

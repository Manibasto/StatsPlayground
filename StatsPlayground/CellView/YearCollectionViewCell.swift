//
//  yearCollectionViewCell.swift
//  StatsPlayground
//  Created by Anil Kumar on 25/02/19.
//  Copyright © 2019 AIT. All rights reserved.
import UIKit

class YearCollectionViewCell: UICollectionViewCell {
    //mark: - IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    
    //changeing the color of the selected cell
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dateLabel!.textColor = UIColor.green
                dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
            } else {
                dateLabel!.textColor = UIColor.darkText
                dateLabel.font = UIFont.systemFont(ofSize: 14)
            }
        }
    }
}

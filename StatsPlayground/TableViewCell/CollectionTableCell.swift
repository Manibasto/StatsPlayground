//
//  CollectionTableCell.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 19/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class CollectionTableCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    
    var leftArrowFlag: Bool = false
    var righArrowFlag: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let firstcell = UINib(nibName: "YearViewCell", bundle: nil)
        self.collectionView.register(firstcell, forCellWithReuseIdentifier: "YearViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func leftArrowTapped(_ sender: Any) {
        
        if (leftArrowFlag == true){
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
            self.moveCollectionToFrame(contentOffset: contentOffset)
            let testName : [String:Bool] = ["Name": true]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: testName )
            righArrowFlag = true
            leftArrowFlag = false
        }else {return}
        
    }
    
    @IBAction func rightArrowTapped(_ sender: Any) {
        
        if (righArrowFlag == true){
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
            self.moveCollectionToFrame(contentOffset: contentOffset)
            let testName : [String:Bool] = ["Name": false]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: testName)
            leftArrowFlag = true
            righArrowFlag = false
        }else {return}
        
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    
}

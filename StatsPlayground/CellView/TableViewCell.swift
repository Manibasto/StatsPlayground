//
//  TableViewCell.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 11/12/18.
//  Copyright © 2018 AIT. All rights reserved.
import UIKit

class TableViewCell: UITableViewCell{
    //MARK: - IBOutlet
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    //MARK: - Declarations
    var leftArrowFlag: Bool = false
    var righArrowFlag: Bool = true
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: - setSelected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func leftArrow(_ sender: Any) {
        
                if (leftArrowFlag == true){
                    let collectionBounds = self.collectionview.bounds
                    let contentOffset = CGFloat(floor(self.collectionview.contentOffset.x - collectionBounds.size.width))
                    self.moveCollectionToFrame(contentOffset: contentOffset)
                    let testName : [String:Bool] = ["Name": true]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: testName )
                    righArrowFlag = true
                    leftArrowFlag = false
                }else {return}
        
    }
    @IBAction func rightArrow(_ sender: Any) {
        
                if (righArrowFlag == true){
                    let collectionBounds = self.collectionview.bounds
                    let contentOffset = CGFloat(floor(self.collectionview.contentOffset.x + collectionBounds.size.width))
                    self.moveCollectionToFrame(contentOffset: contentOffset)
                    let testName : [String:Bool] = ["Name": false]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: testName)
                    leftArrowFlag = true
                    righArrowFlag = false
                }else {return}
        
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionview.contentOffset.y ,width : self.collectionview.frame.width,height : self.collectionview.frame.height)
        self.collectionview.scrollRectToVisible(frame, animated: true)
    }
}

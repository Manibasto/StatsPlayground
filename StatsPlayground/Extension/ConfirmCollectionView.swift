//
//  ConfirmTableView.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 01/03/19.
//  Copyright © 2019 AIT. All rights reserved.
//
import UIKit

extension ConfirmScreenController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func ButtonAttributes(Button: UIButton){
        
        Button.layer.borderColor = UIColor.cyan.cgColor
        Button.layer.borderWidth = 1.5
        Button.layer.cornerRadius = 5
        Button.layer.masksToBounds = true
        Button.layer.shadowColor = UIColor.black.cgColor
        Button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        Button.layer.shadowRadius = 10.0
        Button.layer.shadowPath = UIBezierPath(roundedRect:YesBtn.bounds, cornerRadius:YesBtn.layer.cornerRadius).cgPath
        Button.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        cell.TextLabel.text = items[indexPath.row]
        let data = self.items[indexPath.row]
        if data == GetString {
            cell.TextLabel.text = self.items[indexPath.row]
            cell.TextLabel.numberOfLines = 2
            cell.TextLabel.textColor = UIColor.white
            cell.TextLabel.lineBreakMode = .byTruncatingTail
            cell.TextLabel.minimumScaleFactor = 0.5
            cell.TextLabel.adjustsFontSizeToFitWidth = true
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 0
            cell.layer.shadowOpacity = 10
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        }else{
            cell.TextLabel.text = self.items[indexPath.row]
            cell.layer.borderColor =  UIColor.cyan.cgColor
            cell.layer.borderWidth = 1.5
            cell.TextLabel.numberOfLines = 2
            cell.TextLabel.textColor = UIColor.white
            cell.TextLabel.lineBreakMode = .byTruncatingTail
            cell.TextLabel.minimumScaleFactor = 0.5
            cell.TextLabel.adjustsFontSizeToFitWidth = true
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowOffset = CGSize(width: 4, height: 4)
            cell.layer.masksToBounds = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var sizeArea = CGSize()
        if (UIScreen.main.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            if self.view.frame.size.width < self.view.frame.size.height {
                let spacing = self.view.frame.size.width - 50
                let itemWidth = spacing / 3
                let itemHeight = CGFloat(70)
                sizeArea = CGSize(width: itemWidth, height: itemHeight)
            } else {
                let spacing = self.view.frame.size.width - 50
                let itemWidth = spacing / 3
                let itemHeight = CGFloat(60)
                sizeArea = CGSize(width: itemWidth, height: itemHeight)
            }
        }
        return sizeArea
    }
    
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
}

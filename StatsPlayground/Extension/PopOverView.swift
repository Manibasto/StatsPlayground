//
//  PopOverView.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 01/03/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

extension PopOverViewController : UICollectionViewDataSource{
    
    func ButtonAttributesConfirm(Button: UIButton){
        Button.layer.cornerRadius = 15
        Button.layer.shadowRadius = 2.0
        Button.layer.shadowColor = UIColor.green.cgColor
        Button.layer.shadowOffset = CGSize(width: -1.0, height: 3.0)
        Button.layer.shadowOpacity = 0.8
        Button.layer.masksToBounds = false
    }
    
    func ButtonAttributesAnother(Button: UIButton){
        Button.layer.cornerRadius = 15
        Button.layer.shadowRadius = 2.0
        Button.layer.shadowColor = UIColor.yellow.cgColor
        Button.layer.shadowOffset = CGSize(width: -1.0, height: 3.0)
        Button.layer.shadowOpacity = 0.8
        Button.layer.masksToBounds = false
    }
    
    func ButtonAttributesCancel(Button: UIButton){
        Button.layer.cornerRadius = 15
        Button.layer.shadowRadius = 2.0
        Button.layer.shadowColor = UIColor.red.cgColor
        Button.layer.shadowOffset = CGSize(width: -1.0, height: 3.0)
        Button.layer.shadowOpacity = 0.8
        Button.layer.masksToBounds = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        let data = self.items[indexPath.item]
        if data == UserDefaults.GetString {
            cell.TextLabel.text = self.items[indexPath.item]
            cell.layer.borderColor =  UIColor.gray.cgColor
            cell.layer.borderWidth = 1.5
            cell.TextLabel.numberOfLines = 2
            cell.TextLabel.textColor = UIColor.black
            cell.TextLabel.lineBreakMode = .byTruncatingTail
            cell.TextLabel.minimumScaleFactor = 0.5
            cell.TextLabel.adjustsFontSizeToFitWidth = true
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            
            let labelFont = UIFont(name: "Palatino-Italic", size: 16)
            cell.TextLabel.font = labelFont
            
            cell.contentView.backgroundColor = UIColor.green
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.clear.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 0
            cell.layer.shadowOpacity = 10
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        }else{
            cell.TextLabel.text = self.items[indexPath.item]
            cell.layer.borderColor =  UIColor.gray.cgColor
            cell.layer.borderWidth = 1.5
            cell.backgroundColor = UIColor.lightGray
            cell.TextLabel.numberOfLines = 2
            cell.TextLabel.textColor = UIColor.white
            cell.TextLabel.lineBreakMode = .byTruncatingTail
            cell.TextLabel.minimumScaleFactor = 0.5
            cell.TextLabel.adjustsFontSizeToFitWidth = true
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            
            cell.contentView.layer.borderColor = UIColor.gray.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowOffset = CGSize(width: 4, height: 4)
            cell.layer.masksToBounds = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getcoutry = items[indexPath.row]
        passString = getcoutry
        let cell: UICollectionViewCell? = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.black
        
        confirm.isHidden = false
        confirmation.isHidden = false
        another.isHidden = false
        cancel.isHidden = false
        
        let str = "Confirm that you are purchasing \(passString) for $1.99:"
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        let string = NSMutableAttributedString(string: trimmedString)
        string.setColorForText("\(passString)", with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        string.setColorForText("$1.99", with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        confirm.attributedText = string
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell: UICollectionViewCell? = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
        
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

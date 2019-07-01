//
//  ViewControllerView.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 01/03/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        cell.TextLabel.text = self.items[indexPath.item]
        cell.layer.borderColor = UIColor.cyan.cgColor
        cell.layer.borderWidth = 1.5
        cell.TextLabel.numberOfLines = 2
        cell.TextLabel.textColor = UIColor.white
        cell.TextLabel.lineBreakMode = .byTruncatingTail
        cell.TextLabel.minimumScaleFactor = 0.5
        cell.TextLabel.adjustsFontSizeToFitWidth = true
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.masksToBounds = false
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var sizeArea = CGSize()
        if (UIScreen.main.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            if self.view.frame.size.width < self.view.frame.size.height {
                let spacing = self.view.frame.size.width - 50
                let itemWidth = spacing / 3
                let itemHeight = CGFloat(60)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getcoutry = items[indexPath.row]
        passString = getcoutry
        performSegue(withIdentifier: "pass", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pass" {
            let destViewController = segue.destination as! ConfirmScreenController
            destViewController.GetString = passString
        }
    }
    
    func activityIndicator(_ title: String) {
        
        stringLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        stringLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        stringLabel.text = title
        stringLabel.font = .systemFont(ofSize: 14, weight: .medium)
        stringLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - stringLabel.frame.width/2, y: view.frame.midY - stringLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(stringLabel)
        view.addSubview(effectView)
    }
    

}

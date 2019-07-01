//
//  CustomButtonandLabel.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 20/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit


class CustomButtonandlabel{
    
    func LabelAttributes(Label: UILabel){
        Label.layer.borderColor = UIColor.darkGray.cgColor
        Label.layer.borderWidth = 0.75
        Label.layer.cornerRadius = 3
        Label.layer.masksToBounds = true
        Label.textColor = UIColor.black
        Label.backgroundColor = UIColor.lightGray
    }
    
    func SelectedLabelAttributes(Label: UILabel){
        Label.layer.borderColor = UIColor.darkGray.cgColor
        Label.layer.borderWidth = 0.75
        Label.layer.cornerRadius = 3
        Label.layer.masksToBounds = true
        Label.textColor = UIColor.black
        Label.backgroundColor = UIColor.green
    }
    
    func ButtonAttributes(Button: UIButton){
        Button.backgroundColor = UIColor.yellow
        Button.setTitleColor(UIColor.red, for: .normal)
        Button.layer.cornerRadius = 7
        Button.layer.shadowColor = UIColor.red.cgColor
        Button.layer.shadowRadius = 2.0
        Button.layer.shadowOpacity = 0.8
        Button.layer.shadowOffset = CGSize(width: -1, height: 3)
        Button.layer.masksToBounds = false
    }
}

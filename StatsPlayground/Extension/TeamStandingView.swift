//
//  ChartView.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 01/03/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit
import Charts

extension ScrollViewController{
//
//    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
//        blurredEffectView.isHidden = true
//        visualEffectView.isHidden = true
//    }
//
//    func BlurEffect(){
//        blurEffect = UIBlurEffect(style: .dark)
//        blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = view.bounds
//        view.addSubview(blurredEffectView)
//
//    }
    
    func CallPopOver() {
//        self.BlurEffect()
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "PopOverViewController") as? PopOverViewController
        popupVC?.preferredContentSize = CGSize(width: view.frame.width, height: view.frame.height - 200)
        popupVC?.modalPresentationStyle = UIModalPresentationStyle.popover
        popupVC?.popoverPresentationController?.delegate = self ;
        popupVC?.popoverPresentationController?.sourceView = self.view
        popupVC?.popoverPresentationController?.sourceRect = CGRect(x:self.view.bounds.midX, y: self.view.bounds.midY,width: 0,height: 0)
        popupVC?.popoverPresentationController?.backgroundColor = UIColor.clear
        popupVC?.view.layer.borderColor = UIColor.clear.cgColor
        popupVC?.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        self.present(popupVC!, animated: true, completion: nil)
    }
    
//    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
//        blurredEffectView.removeFromSuperview()
//        return true
//    }
    
//    func LabelAttributes(Label: UILabel){
//        Label.layer.borderColor = UIColor.darkGray.cgColor
//        Label.layer.borderWidth = 0.75
//        Label.layer.cornerRadius = 3
//        Label.layer.masksToBounds = true
//        Label.textColor = UIColor.black
//        Label.backgroundColor = UIColor.lightGray
//    }
//
//    func SelectedLabelAttributes(Label: UILabel){
//        Label.layer.borderColor = UIColor.darkGray.cgColor
//        Label.layer.borderWidth = 0.75
//        Label.layer.cornerRadius = 3
//        Label.layer.masksToBounds = true
//        Label.textColor = UIColor.black
//        Label.backgroundColor = UIColor.green
//    }
//
//    func ButtonAttributes(Button: UIButton){
//        Button.backgroundColor = UIColor.yellow
//        Button.setTitleColor(UIColor.red, for: .normal)
//
//        Button.layer.shadowColor = UIColor.red.cgColor
//        Button.layer.shadowRadius = 2.0
//        Button.layer.shadowOpacity = 0.8
//        Button.layer.shadowOffset = CGSize(width: -1, height: 3)
//        Button.layer.masksToBounds = false
//    }
}


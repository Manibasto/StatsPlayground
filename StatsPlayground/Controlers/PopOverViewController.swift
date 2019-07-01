//
//  PopOverViewController.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 13/12/18.
//  Copyright © 2018 AIT. All rights reserved.
import UIKit

class PopOverViewController: UIViewController, UICollectionViewDelegate {
    //MARK: - Declarations
//    let BgImage = UIImage(named: "Bgimag")
    let reuseIdentifier = "Cell"
    var items : [String] = []
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var passString = String()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    //MARK: - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var confirmation: UIButton!
    @IBOutlet weak var another: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var confirm: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirm.isHidden = true
        confirmation.isHidden = true
        another.isHidden = true
        cancel.isHidden = true
        
        activityIndicator("Please Wait")
        //setting a background image for the popover
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = BgImage
//        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        self.view.backgroundColor = UIColor.white
        self.collection.backgroundColor = UIColor.white
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        //constructing a layout for collection view
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.itemSize = CGSize(width: collection.frame.size.width/4, height: collection.frame.size.height/12)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        collection.collectionViewLayout = layout
        collection.delegate = self
        collection.dataSource = self
        //requesting service to display teams in collection view
        Networking.networking.requestForTeamData { (success, result, error) in
            if success == true{
                self.items = result
                self.effectView.removeFromSuperview()
                self.collection.reloadData()
            }
        }
        ButtonAttributesConfirm(Button: confirmation)
        ButtonAttributesAnother(Button: another)
        ButtonAttributesCancel(Button: cancel)
    }
    //MARK: - IBAction
    @IBAction func dismiss(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        self.view.removeFromSuperview()
    }
    @IBAction func different(_ sender: Any) {
        
        confirm.isHidden = true
        confirmation.isHidden = true
        another.isHidden = true
        cancel.isHidden = true
        
    }
    @IBAction func backtoApp(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 10/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//
import UIKit
import Alamofire

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Declarations
    var items : [String] = []
    var team : [String] = []
    var win: [String] = []
//    var divisionWinnerName = [String]()
    let reuseIdentifier = "Cell"
    var screenSize        : CGRect!
    var screenWidth       : CGFloat!
    var screenHeight      : CGFloat!
    var BgImage           = UIImage(named: "FoodBallBg")
    var passString        = String()
    var activityIndicator = UIActivityIndicatorView()
    var stringLabel       = UILabel()
    let effectView        = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    //    var TeamName = [String]()
    //    var Win = [String]()
    var selectedYear       = ["2014", "2015", "2016", "2017", "2018"]
    var Win = [[String]]()
    let group = DispatchGroup()
    var TeamName: [String] = []
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        findTeamDetails()
        self.title = "Select your favorite pro football team below to start."
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font:  UIFont(name: "Kohinoor Bangla", size: 24)!]
        self.navigationController?.navigationBar.setBackgroundImage(BgImage,for: .default)
        
        //displaying a background image for the controller
        let bgImage = UIImageView()
        bgImage.image = BgImage
        bgImage.contentMode = .scaleAspectFill
        self.collectionView?.backgroundView = bgImage
        activityIndicator("Please Wait")
        
        //constructing a layout for collecion view
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.itemSize = CGSize(width: screenWidth/5, height: screenWidth/15)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        collectionView!.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //requesting service to show the team in collection view
        Networking.networking.requestForTeamData { (success, result, error) in
            if success == true{
                self.items = result
                self.effectView.removeFromSuperview()
                self.collectionView.reloadData()
            }
            else {
                print("No Internet Connection")
            }
        }
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 64, height: 64)
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 20
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
//    func findTeamDetails(){
//        for a in self.selectedYear{
//            let runLoop = CFRunLoopGetCurrent()
//            Networking.networking.requestForDivWinner(year: a, conferencename: "National", divisionname: "South") { (success, div, error) in
//                if success == true {
//                    self.divisionWinnerName.append(div)
//                    CFRunLoopStop(runLoop)
//                }else {
//                    self.showConfirmAlert(title: "Alert", message: "Please Check Your Internet Connection", buttonTitle: "OK", buttonStyle: .default, confirmAction: { [weak self] (action) in
//                        self?.navigationController?.popToRootViewController(animated: true)
//                    })
//                }
//            }
//            CFRunLoopRun()
//        }
//        print(divisionWinnerName)
//    }
}

extension ViewController{
    
    func arrayValues(){
        print(TeamName)
        print(TeamName.count)
//        for i in TeamName{
//            team = i
//        }
//        for j in Win{
//            win = j
//        }
//        print(team.count)
//        print(win.count)
        
    }
    
}

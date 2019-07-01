//
//  TeamStandingConreoller.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 10/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class ConfirmScreenController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var Collectionview: UICollectionView!
    @IBOutlet weak var YesBtn: UIButton!
    @IBOutlet weak var NoBtn: UIButton!
    @IBOutlet weak var LabelText: UILabel!
    
    //MARK: - Declarations
    let reuseIdentifier = "Cell"
    var items : [String] = []
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    let BgImage = UIImage(named: "Bgimag")
    var GetString = String()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var league = [String]()
    var conference = [String]()
    var wildCard = [String]()
    var divisionName = String()
    var conferenceName = String()
    var playOff = [String]()
    let group = DispatchGroup()
    var SBW = [String]()
    var SBL = [String]()
    var selectedYear = ["2014", "2015", "2016", "2017", "2018"]
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        let main_string = "Confirm that the team you selected is \(GetString) to enter the App:"
        let string_to_color = GetString
        let range = (main_string as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:main_string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow , range: range)
        
        LabelText.text = main_string
        LabelText.attributedText = attributedString
        activityIndicator("Please Wait")
        
        Collectionview.delegate = self
        Collectionview.dataSource = self
        //requesting service to display the team in collection view
        Networking.networking.requestForTeamData { (success, result, error) in
            if success == true{
                self.items = result
                self.effectView.removeFromSuperview()
                self.Collectionview.reloadData()
            }
        }
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //displaying a background image for the controller
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = BgImage
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        ButtonAttributes(Button: YesBtn)
        ButtonAttributes(Button: NoBtn)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        let bgImage = UIImageView()
        bgImage.image = BgImage
        bgImage.contentMode = .scaleAspectFill
        self.Collectionview?.backgroundView = bgImage
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        //constructing a layout for the collection view
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.itemSize = CGSize(width: screenWidth/5, height: screenWidth/15)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        Collectionview!.collectionViewLayout = layout
    }
    
    @IBAction func YesBtn(_ sender: Any) { 
        UserDefaults.GetString = GetString
        getTeamDetails(GetString)
    }
    
    @IBAction func NoBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}


extension ConfirmScreenController {
    
    func getTeamDetails(_ TeamName: String){
        YesBtn.setTitle("", for: .normal)
        YesBtn.loadingIndicator(show: true)
        self.group.enter()
        Networking.networking.requestForTeamWinning(Name: TeamName) { (success, team, year, div, league, conf, wc, divname, confname,playOff, error)  in
            if success == true{
                TeamDetails.shared.division = div
                TeamDetails.shared.league = league
                TeamDetails.shared.conference = conf
                TeamDetails.shared.wildCard = wc
                TeamDetails.shared.divisionName = divname
                TeamDetails.shared.conferenceName = confname
                TeamDetails.shared.playOff = playOff
                TeamDetails.shared.teamName = team
                self.group.leave()
            }else {
                self.YesBtn.setTitle("Yes, take me to the App", for: .normal)
                self.YesBtn.loadingIndicator(show: false)
                self.showConfirmAlert(title: "", message: "Sorry, we can't connect right now. Please check your internet connection and try again.", buttonTitle: "Ok", buttonStyle: .default) { [weak self] (action) in
                    
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        self.group.notify(queue: DispatchQueue.main, execute: {
            print(TeamDetails.shared.division as Any)
            print(TeamDetails.shared.league as Any)
            print(TeamDetails.shared.conference as Any)
            print(TeamDetails.shared.playOff as Any)
            print(TeamDetails.shared.wildCard as Any)
            self.getWinningDetails()
        })
    }
    
    func getWinningDetails(){
        DispatchQueue.main.async {
            for a in self.selectedYear{
                self.group.enter()
                Networking.networking.requestForTeamPosition(year: a) { (success, sbw, sbl, error) in
                    if success == true{
                        self.SBW.append(sbw)
                        self.SBL.append(sbl)
                    }else {
                        self.showConfirmAlert(title: "Alert", message: "Please Check Your Internet Connection", buttonTitle: "OK", buttonStyle: .default, confirmAction: { [weak self] (action) in
                            self?.navigationController?.popToRootViewController(animated: true)
                            self?.group.leave()
                        })
                    }
                    self.group.leave()
                }
            }
            self.group.notify(queue: DispatchQueue.main, execute: {
                self.YesBtn.loadingIndicator(show: false)
                self.YesBtn.setTitle("Yes, take me to the App", for: .normal)
                TeamDetails.shared.SBwinner = self.SBW
                TeamDetails.shared.SBloser = self.SBL
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
                    if let navigator = self.navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            })
        }
    }
}


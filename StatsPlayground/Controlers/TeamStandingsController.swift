////
////  TeamStandingsController.swift
////  StatsPlayground
////  Created by Anil Kumar on 10/12/18.
////  Copyright © 2018 AIT. All rights reserved.
//import UIKit
//import Charts
//import Alamofire
//import SwiftCharts
//
//class TeamStandingsController: DemoBaseViewController, ViewControllerActivity, UIPopoverPresentationControllerDelegate, CalendarDelgate, UICollectionViewDataSource, UICollectionViewDelegate{
//    //MARK: -  Declarations
//    var loadingView: UIVisualEffectView?
//    var blurEffect = UIBlurEffect()
//    var blurredEffectView = UIVisualEffectView()
//    var visualEffectView   = UIVisualEffectView()
//    var TeamName = String()
//    var selectedYear = [String]()
//    var SBwinner = [String]()
//    var SBloser = [String]()
//    var divisionWinner = [String]()
//    let group = DispatchGroup()
//    var league = [String]()
//    var divisionWinnerName = [String]()
//    var conference = [String]()
//    var wildCard = [String]()
//    var divisionName = String()
//    var conferenceName = String()
//    var playOff = [String]()
//    var year = [2009, 2010, 2011, 2012, 2013]
//    var team = ["NE", "NYJ", "BUF","MIA"]
//    //    let BgImage = UIImage(named: "StandlingBg")
//    let deadlineTime = DispatchTime.now() + .seconds(4)
//    var calendarPicker: CalendarPicker?
//    var cellIdentifier = "cellreuse"
//    var calendarArray = [String]()
//    var righArrowFlag: Bool = true
//    private var didLayout: Bool = false
//    private var chart: Chart?
//
//    //MARK:- IBOutlet
//    @IBOutlet weak var CountryName: UILabel!
//    @IBOutlet weak var team_standing: UILabel!
//    @IBOutlet weak var show_winning: UILabel!
//    @IBOutlet weak var showing_Divisions_Standings: UILabel!
//    @IBOutlet weak var dropdown: DropDown!
//    @IBOutlet weak var ScoreBoard: UITableView!
//    @IBOutlet weak var GetMoreTeam: UIButton!
//    @IBOutlet weak var GetMoreYears: UIButton!
//    @IBOutlet weak var chartView: UIView!
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        if !self.didLayout {
//            self.didLayout = true
//            for i in year{
//                for j in 0..<(team.count){
//                    let value = Int.random(in: 1 ... 15)
//                    self.initChart(i, value, team[j])
//                }
//            }
//        }
//    }
//
//    //MARK:- viewDidLoad
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        self.ScoreBoard.backgroundColor = UIColor.lightGray
////        self.chartView.backgroundColor = UIColor.lightGray
//        self.chartView.layer.borderWidth = 0.5
//        self.chartView.layer.borderColor = UIColor.white.cgColor
////        self.view.backgroundColor = UIColor.white
//        self.view.bringSubviewToFront(GetMoreYears)
//        self.GetMoreYears.layer.cornerRadius = 7
//        self.GetMoreTeam.layer.cornerRadius = 7
//        dropdown.text = "Teams"
//        dropdown.textColor = UIColor.white
//        rotated()
//
//        TeamName = UserDefaults.GetString
//        self.ScoreBoard.dataSource = self
//        //requesting the service in the main thread
//        NotificationCenter.default.addObserver(self, selector: #selector(self.labelData(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
//        self.calendarArray = getCalendar().arrayOfDates()
//        DispatchQueue.global().async(execute: {
//            DispatchQueue.main.sync {
//                for i in self.calendarArray{
//                    self.selectedYear.append(i)
//                }
//                //print(self.selectedYear)
//                self.group.enter()
//                Networking.networking.requestForTeamWinning(Name: self.TeamName) { (success, year, div, league, conf, wc, divname, confname,playOff, error)  in
//                    self.divisionWinner = div
//                    self.league = league
//                    self.conference = conf
//                    self.wildCard = wc
//                    self.divisionName = divname
//                    self.conferenceName = confname
//                    self.playOff = playOff
//
//                }
//            }
//        })
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)){
//            for a in self.selectedYear{
//                self.group.enter()
//                Networking.networking.requestForTeamPosition(year: a) { (success, sbw, sbl, error) in
//                    self.SBwinner.append(sbw)
//                    self.SBloser.append(sbl)
//                    self.group.leave()
//                }
//            }
//            for a in self.selectedYear{
//                self.group.enter()
//                Networking.networking.requestForDivWinner(year: a, conferencename: self.conferenceName, divisionname: self.divisionName) { (success, div, error) in
//                    self.divisionWinnerName.append(div)
//                    self.group.leave()
//                }
//            }
//            self.group.notify(queue: DispatchQueue.main, execute: {
//                self.ScoreBoard.reloadData()
//            })
//        }
//        ScoreBoard.tableFooterView = UIView(frame: .zero)
//        ScoreBoard.isScrollEnabled = true
//        self.navigationController?.navigationBar.isHidden = true
//        ScoreBoard.layer.borderColor = UIColor.white.cgColor
//        ScoreBoard.layer.borderWidth = 0.5
//        self.view.bringSubviewToFront(GetMoreTeam)
//    }
//    @objc func labelData(_ notification: NSNotification){
//        righArrowFlag = notification.userInfo?["Name"] as! Bool
//        self.ScoreBoard.reloadData()
//    }
//
//    func getCalendar() -> CalendarPicker {
//        if calendarPicker == nil {
//            calendarPicker = CalendarPicker()
//            calendarPicker?.delegate = self
//        }
//        return calendarPicker!
//    }
//
//    private func initChart(_ xValue: Int,_ yValue: Int, _ label1: String) {
//        // map model data to chart points
//        let chartPoints: [ChartPoint] = [(xValue,yValue)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
//
//        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
//        let values = [
//            ChartAxisValueInt(0, labelSettings: labelSettings),
//            ChartAxisValueInt(2, labelSettings: labelSettings),
//            ChartAxisValueInt(4, labelSettings: labelSettings),
//            ChartAxisValueInt(6, labelSettings: labelSettings),
//            ChartAxisValueInt(8, labelSettings: labelSettings),
//            ChartAxisValueInt(10, labelSettings: labelSettings),
//            ChartAxisValueInt(12, labelSettings: labelSettings),
//            ChartAxisValueInt(14, labelSettings: labelSettings),
//            ChartAxisValueInt(16, labelSettings: labelSettings),
//            ]
//        let values1 = [
//            ChartAxisValueInt(2008, labelSettings: labelSettings),
//            ChartAxisValueInt(2009, labelSettings: labelSettings),
//            ChartAxisValueInt(2010, labelSettings: labelSettings),
//            ChartAxisValueInt(2011, labelSettings: labelSettings),
//            ChartAxisValueInt(2012, labelSettings: labelSettings),
//            ChartAxisValueInt(2013, labelSettings: labelSettings),
//            ChartAxisValueInt(2014, labelSettings: labelSettings),
//            ]
//
//        let labels = ChartAxisLabel(text: "Wins", settings: labelSettings.defaultVertical())
//        let labels1 = ChartAxisLabel(text: "", settings: labelSettings)
//
//        let yModel = ChartAxisModel(axisValues: values, axisTitleLabel: labels)
//
//        let xModel = ChartAxisModel(axisValues: values1, axisTitleLabel: labels1)
//
//        let chartFrame = ExamplesDefaults.chartFrame(view.bounds)
//
//        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
//
//        // generate axes layers and calculate chart inner frame, based on the axis models
//        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
//        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
//
//        // create layer with guidelines
//        let guidelinesLayerSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.white, linesWidth: ExamplesDefaults.guidelinesWidth)
//        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
//
//        // view generator - this is a function that creates a view for each chartpoint
//        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
//            let viewSize: CGFloat = Env.iPad ? 30 : 20
//            let center = chartPointModel.screenLoc
//            let label = UILabel(frame: CGRect(x: center.x - viewSize / 2, y: center.y - viewSize / 2, width: viewSize, height: viewSize))
//            if label1 == "NE"{
//                label.backgroundColor = UIColor.green
//                label.layer.shadowColor = UIColor.purple.cgColor
//            }else{
//                label.backgroundColor = UIColor.white
//                label.layer.shadowColor = UIColor.white.cgColor
//            }
//            label.layer.borderWidth = 0.5
//            label.adjustsFontSizeToFitWidth = true
//            label.layer.borderColor = UIColor.black.cgColor
//            label.textAlignment = NSTextAlignment.center
//            label.text = label1
//            label.layer.shadowOpacity = 1
//            label.layer.shadowOffset = CGSize(width: -1, height: 1)
//            label.layer.shadowRadius = 3
//            label.layer.masksToBounds = false
//            label.font = ExamplesDefaults.labelFont
//            return label
//        }
//
//        // create layer that uses viewGenerator to display chartpoints
//        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: viewGenerator, mode: .translate)
//
//        // create chart instance with frame and layers
//        let chart = Chart(
//            frame: chartFrame,
//            innerFrame: innerFrame,
//            settings: chartSettings,
//            layers: [
//                xAxisLayer,
//                yAxisLayer,
//                guidelinesLayer,
//                chartPointsLayer
//            ]
//        )
//        view.addSubview(chart.view)
//        self.chart = chart
//    }
//
//    func rotated() {
//        for view in self.chartView.subviews {
//            view.removeFromSuperview()
//        }
//    }
//
//    func moveCollectionToFrame(contentOffset : CGFloat) {
//        let cell = ScoreBoard.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//        let frame: CGRect = CGRect(x : contentOffset ,y : cell.collectionview.contentOffset.y ,width : cell.collectionview.frame.width,height : cell.collectionview.frame.height)
//        cell.collectionview.scrollRectToVisible(frame, animated: true)
//    }
//
//    //MARK:- viewWillAppear
//    override func viewWillAppear(_ animated: Bool) {
//        //        setting a background image for the controller
//        //        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        //        backgroundImage.image = BgImage
//        //        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
//        //        self.view.insertSubview(backgroundImage, at: 0)
//        CountryName.text = UserDefaults.GetString.uppercased()
//        CountryName.textColor = UIColor.purple
//        CountryName.adjustsFontSizeToFitWidth = true
//        team_standing.textColor = UIColor.white
//
//        LabelAttributes(Label: show_winning)
//
//        SelectedLabelAttributes(Label: showing_Divisions_Standings)
//        ButtonAttributes(Button: GetMoreTeam)
//        ButtonAttributes(Button: GetMoreYears)
//
//        dropdown.optionArray = ["Washington", "New York Giants", "New England", UserDefaults.GetString]
//        dropdown.optionIds = [1,23,54,22]
//        dropdown.arrow.backgroundColor = UIColor.white
//        dropdown.borderWidth = 0.5
//        dropdown.borderColor = UIColor.black
//        self.view.bringSubviewToFront(dropdown)
//
//        dropdown.didSelect{(selectedText , index ,id) in
//            self.dropdown.text = "\(selectedText)"
//        }
//        self.ScoreBoard.separatorStyle = .singleLine
//        self.ScoreBoard.separatorColor = UIColor.white
//        self.ScoreBoard.backgroundColor = UIColor.clear
//
//    }
//    //MARK: - IBAction
//    @IBAction func GetMoreTeams(_ sender: Any) {
//        CallPopOver()
//    }
//
//}
//extension TeamStandingsController {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 9
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//            cell.isUserInteractionEnabled = true
////            cell.backgroundColor = UIColor.white
//            cell.collectionview.dataSource = self
//            cell.collectionview.delegate = self
//            cell.collectionview.isScrollEnabled = true
//            cell.collectionview.isUserInteractionEnabled = true
//            cell.collectionview.isPagingEnabled = true
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 0.45
//            return cell
//        }else if indexPath.row == 1{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell2
//            cell.isUserInteractionEnabled = false
////            cell.backgroundColor = UIColor.clear
//            cell.activityindicator.startAnimating()
//            cell.activityindicator.color = UIColor.gray
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 0.45
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//                if (self.righArrowFlag == true){
//                    cell.activityindicator.stopAnimating()
//                    cell.activityindicator.isHidden = true
//                    cell.year1.text = self.SBwinner[0]
//                    cell.year2.text = self.SBwinner[1]
//                    cell.year3.text = self.SBwinner[2]
//                    cell.year4.text = self.SBwinner[3]
//                    cell.year5.text = self.SBwinner[4]
//                }else {
//                    cell.activityindicator.stopAnimating()
//                    cell.activityindicator.isHidden = true
//                    cell.year1.text = self.SBwinner[1]
//                    cell.year2.text = self.SBwinner[2]
//                    cell.year3.text = self.SBwinner[3]
//                    cell.year4.text = self.SBwinner[4]
//                    cell.year5.text = self.SBwinner[5]
//                }
//            }
//            return cell
//        }else if indexPath.row == 2{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TableViewCell3
//            cell.isUserInteractionEnabled = false
//            cell.backgroundColor = UIColor.clear
//            cell.activityindicator.startAnimating()
//            cell.activityindicator.color = UIColor.gray
//            cell.layer.borderWidth = 0.45
//            cell.layer.borderColor = UIColor.black.cgColor
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//                if (self.righArrowFlag == true){
//                    cell.activityindicator.stopAnimating()
//                    cell.activityindicator.isHidden = true
//                    cell.loserYear1.text = self.SBloser[0]
//                    cell.loserYear2.text = self.SBloser[1]
//                    cell.loserYear3.text = self.SBloser[2]
//                    cell.loserYear4.text = self.SBloser[3]
//                    cell.loserYear5.text = self.SBloser[4]
//                }else {
//                    cell.activityindicator.stopAnimating()
//                    cell.activityindicator.isHidden = true
//                    cell.loserYear1.text = self.SBloser[1]
//                    cell.loserYear2.text = self.SBloser[2]
//                    cell.loserYear3.text = self.SBloser[3]
//                    cell.loserYear4.text = self.SBloser[4]
//                    cell.loserYear5.text = self.SBloser[5]
//                }
//            }
//            return cell
//        }else if indexPath.row == 3{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! TableViewCell4
//            cell.isUserInteractionEnabled = false
//            cell.backgroundColor = UIColor.clear
//            cell.activityindicator.isHidden = false
//            cell.activityindicator.startAnimating()
//            cell.activityindicator.color = UIColor.gray
//            cell.layer.borderWidth = 0.45
//            cell.layer.borderColor = UIColor.black.cgColor
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(6)) {
//                if (self.righArrowFlag == true){
//                    cell.activityindicator.stopAnimating()
//                    cell.activityindicator.isHidden = true
//                    cell.divYear1.text = self.divisionWinnerName[0]
//                    cell.divYear2.text = self.divisionWinnerName[1]
//                    cell.divYear3.text = self.divisionWinnerName[2]
//                    cell.divYear4.text = self.divisionWinnerName[3]
//                    cell.divYear5.text = self.divisionWinnerName[4]
//                }else {
//                    cell.activityindicator.stopAnimating()
//                    cell.activityindicator.isHidden = true
//                    cell.divYear1.text = self.divisionWinnerName[1]
//                    cell.divYear2.text = self.divisionWinnerName[2]
//                    cell.divYear3.text = self.divisionWinnerName[3]
//                    cell.divYear4.text = self.divisionWinnerName[4]
//                    cell.divYear5.text = self.divisionWinnerName[5]
//                }
//            }
//            return cell
//        }else if indexPath.row == 4{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! TableViewCell5
//            cell.isUserInteractionEnabled = false
////            cell.backgroundColor = UIColor.white
//            cell.layer.borderWidth = 0.45
//            cell.layer.borderColor = UIColor.black.cgColor
//            let str1 = "Playoffs"
//            let trimmedString1 = str1.trimmingCharacters(in: .whitespacesAndNewlines)
//            let string1 = NSMutableAttributedString(string: trimmedString1)
//            string1.setUnderlineWith(nil, with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
//            cell.playoff.attributedText = string1
//            cell.playoff2.attributedText = string1
//
//            let str = "Win\\Loss"
//            let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
//            let string = NSMutableAttributedString(string: trimmedString)
//            string.setColorForText("Win", with: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
//            string.setColorForText("Loss", with: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
//            cell.win.attributedText = string
//            cell.win2.attributedText = string
//
//            return cell
//        }else if indexPath.row == 5{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath) as! TableViewCell6
//            cell.isUserInteractionEnabled = false
//            cell.backgroundColor = UIColor.clear
//            cell.activityindicator.startAnimating()
//            cell.activityindicator.color = UIColor.gray
//            cell.layer.borderWidth = 0.45
//            cell.layer.borderColor = UIColor.black.cgColor
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//                DispatchQueue.main.async {
//                    if (self.righArrowFlag == true){
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if self.league[5] == "0"{
//                            cell.img1.image = UIImage(named: "redStar")
//                        }else if (self.league[5] == "0" && self.conference[5] == "0"){
//                            cell.img1.backgroundColor = UIColor.clear
//                        }else if self.league[5] == "1" {
//                            cell.img1.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[4] == "0"{
//                            cell.img2.image = UIImage(named: "redStar")
//                        }else if (self.league[4] == "0" && self.conference[4] == "0"){
//                            cell.img1.backgroundColor = UIColor.clear
//                        }else if self.league[4] == "1" {
//                            cell.img1.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[3] == "0"{
//                            cell.img3.image = UIImage(named: "redStar")
//                        }else if (self.league[3] == "0" && self.conference[3] == "0"){
//                            cell.img3.backgroundColor = UIColor.clear
//                        }else if self.league[3] == "1" {
//                            cell.img3.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[2] == "0"{
//                            cell.img4.image = UIImage(named: "redStar")
//                        }else if (self.league[2] == "0" && self.conference[2] == "0"){
//                            cell.img4.backgroundColor = UIColor.clear
//                        }else if self.league[2] == "1" {
//                            cell.img4.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[1] == "0"{
//                            cell.img5.image = UIImage(named: "redStar")
//                        }else if (self.league[1] == "0" && self.conference[1] == "0"){
//                            cell.img5.backgroundColor = UIColor.clear
//                        }else if self.league[1] == "1" {
//                            cell.img5.image = UIImage(named: "greenStar")
//                        }
//                    }else{
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if self.league[4] == "0"{
//                            cell.img1.image = UIImage(named: "redStar")
//                        }else if (self.league[4] == "0" && self.conference[4] == "0"){
//                            cell.img1.backgroundColor = UIColor.clear
//                        }else if self.league[4] == "1" {
//                            cell.img1.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[3] == "0"{
//                            cell.img2.image = UIImage(named: "redStar")
//                        }else if (self.league[3] == "0" && self.conference[3] == "0"){
//                            cell.img1.backgroundColor = UIColor.clear
//                        }else if self.league[3] == "1" {
//                            cell.img1.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[2] == "0"{
//                            cell.img3.image = UIImage(named: "redStar")
//                        }else if (self.league[2] == "0" && self.conference[2] == "0"){
//                            cell.img3.backgroundColor = UIColor.clear
//                        }else if self.league[2] == "1" {
//                            cell.img3.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[1] == "0"{
//                            cell.img4.image = UIImage(named: "redStar")
//                        }else if (self.league[1] == "0" && self.conference[1] == "0"){
//                            cell.img4.backgroundColor = UIColor.clear
//                        }else if self.league[1] == "1" {
//                            cell.img4.image = UIImage(named: "greenStar")
//                        }
//                        if self.league[0] == "0"{
//                            cell.img5.image = UIImage(named: "redStar")
//                        }else if (self.league[0] == "0" && self.conference[0] == "0"){
//                            cell.img5.backgroundColor = UIColor.clear
//                        }else if self.league[0] == "1" {
//                            cell.img5.image = UIImage(named: "greenStar")
//                        }
//                    }
//                }
//            }
//            return cell
//        }else if indexPath.row == 6{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell6", for: indexPath) as! TableViewCell7
//            cell.isUserInteractionEnabled = false
//            cell.backgroundColor = UIColor.clear
//            cell.activityindicator.startAnimating()
//            cell.activityindicator.color = UIColor.gray
//            cell.layer.borderWidth = 0.45
//            cell.layer.borderColor = UIColor.black.cgColor
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//                DispatchQueue.main.async {
//                    if (self.righArrowFlag == true){
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if self.conference[5] == "0"{
//                            cell.img1.image = UIImage(named: "redDiamond")
//                        }else if self.conference[5] == "1"{
//                            cell.img1.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[5] == "0" && self.conference[5] == "0"){
//                            cell.img1.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[4] == "0"{
//                            cell.img2.image = UIImage(named: "redDiamond")
//                        }else if self.conference[4] == "1"{
//                            cell.img2.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[4] == "0" && self.conference[4] == "0"){
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[3] == "0"{
//                            cell.img3.image = UIImage(named: "redDiamond")
//                        }else if self.conference[3] == "1"{
//                            cell.img3.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[3] == "0" && self.conference[3] == "0"){
//                            cell.img3.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[2] == "0"{
//                            cell.img4.image = UIImage(named: "redDiamond")
//                        }else if self.conference[2] == "1"{
//                            cell.img4.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[2] == "0" && self.conference[2] == "0"){
//                            cell.img4.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[1] == "0"{
//                            cell.img5.image = UIImage(named: "redDiamond")
//                        }else if self.conference[1] == "1"{
//                            cell.img5.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[1] == "0" && self.conference[1] == "0"){
//                            cell.img5.backgroundColor = UIColor.clear
//                        }
//                    }else {
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if self.conference[4] == "0"{
//                            cell.img1.image = UIImage(named: "redDiamond")
//                        }else if self.conference[4] == "1"{
//                            cell.img1.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[4] == "0" && self.conference[4] == "0"){
//                            cell.img1.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[3] == "0"{
//                            cell.img2.image = UIImage(named: "redDiamond")
//                        }else if self.conference[3] == "1"{
//                            cell.img2.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[3] == "0" && self.conference[3] == "0"){
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[2] == "0"{
//                            cell.img3.image = UIImage(named: "redDiamond")
//                        }else if self.conference[2] == "1"{
//                            cell.img3.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[2] == "0" && self.conference[2] == "0"){
//                            cell.img3.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[1] == "0"{
//                            cell.img4.image = UIImage(named: "redDiamond")
//                        }else if self.conference[1] == "1"{
//                            cell.img4.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[1] == "0" && self.conference[1] == "0"){
//                            cell.img4.backgroundColor = UIColor.clear
//                        }
//                        if self.conference[0] == "0"{
//                            cell.img5.image = UIImage(named: "redDiamond")
//                        }else if self.conference[0] == "1"{
//                            cell.img5.image = UIImage(named: "greenDiamond")
//                        }else if(self.divisionWinner[0] == "0" && self.conference[0] == "0"){
//                            cell.img5.backgroundColor = UIColor.clear
//                        }
//                    }
//                }
//            }
//            return cell
//        }else if indexPath.row == 7{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath) as! TableViewCell8
//            cell.isUserInteractionEnabled = false
//            cell.backgroundColor = UIColor.clear
//            cell.activityindicator.startAnimating()
//            cell.activityindicator.color = UIColor.gray
//            cell.layer.borderWidth = 0.45
//            cell.layer.borderColor = UIColor.black.cgColor
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//                DispatchQueue.main.async {
//                    if (self.righArrowFlag == true){
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if (self.divisionWinner[5] == "0" && (self.wildCard[5] == "1" || self.playOff[5] <= "1")){
//                            cell.img1.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[5] == "1"{
//                            cell.img1.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[5] == "0"{
//                            cell.img1.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[4] == "0" && (self.wildCard[4] == "1" || self.playOff[4] <= "1")){
//                            cell.img2.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[4] == "1"{
//                            cell.img2.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[4] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[3] == "0" && (self.wildCard[3] == "1" || self.playOff[3] <= "1")){
//                            cell.img3.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[3] == "1"{
//                            cell.img3.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[3] == "0"{
//                            cell.img3.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[2] == "0" && (self.wildCard[2] == "1" || self.playOff[2] <= "1")){
//                            cell.img4.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[2] == "1"{
//                            cell.img4.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[2] == "0"{
//                            cell.img4.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[1] == "0" && (self.wildCard[1] == "1" || self.playOff[1] <= "1")){
//                            cell.img5.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[1] == "1"{
//                            cell.img5.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[1] == "0"{
//                            cell.img5.backgroundColor = UIColor.clear
//                        }
//                    }else {
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if (self.divisionWinner[4] == "0" && (self.wildCard[4] == "1" || self.playOff[4] <= "1")){
//                            cell.img1.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[4] == "1"{
//                            cell.img1.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[4] == "0"{
//                            cell.img1.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[3] == "0" && (self.wildCard[3] == "1" || self.playOff[3] <= "1")){
//                            cell.img2.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[3] == "1"{
//                            cell.img2.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[3] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[2] == "0" && (self.wildCard[2] == "1" || self.playOff[2] <= "1")){
//                            cell.img3.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[2] == "1"{
//                            cell.img3.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[2] == "0"{
//                            cell.img3.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[1] == "0" && (self.wildCard[1] == "1" || self.playOff[1] <= "1")){
//                            cell.img4.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[1] == "1"{
//                            cell.img4.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[1] == "0"{
//                            cell.img4.backgroundColor = UIColor.clear
//                        }
//                        if (self.divisionWinner[0] == "0" && (self.wildCard[0] == "1" || self.playOff[0] <= "1")){
//                            cell.img5.image = UIImage(named: "redSquare")
//                        }else if self.divisionWinner[0] == "1"{
//                            cell.img5.image = UIImage(named: "greenSquare")
//                        }else if self.playOff[0] == "0"{
//                            cell.img5.backgroundColor = UIColor.clear
//                        }
//                    }
//                }
//            }
//            return cell
//        }else if indexPath.row == 8{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell8", for: indexPath) as! TableViewCell9
//            cell.isUserInteractionEnabled = false
//            cell.backgroundColor = UIColor.clear
//            cell.activityindicator.startAnimating()
//            cell.activityindicator.color = UIColor.gray
//            cell.layer.borderWidth = 0.45
//            cell.layer.borderColor = UIColor.black.cgColor
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//                DispatchQueue.main.async {
//                    if (self.righArrowFlag == true){
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if self.wildCard[5] == "1"{
//                            cell.img1.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[5] == "0" && self.playOff[5] > "2"){
//                            cell.img1.image = UIImage(named: "redCircle")
//                        }else if self.playOff[5] == "0"{
//                            cell.img1.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[4] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[4] == "0" && self.playOff[4] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[4] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[3] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[3] == "0" && self.playOff[3] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[3] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[2] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[2] == "0" && self.playOff[2] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[2] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[1] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[1] == "0" && self.playOff[1] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[1] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                    }else {
//                        cell.activityindicator.stopAnimating()
//                        cell.activityindicator.isHidden = true
//                        if self.wildCard[4] == "1"{
//                            cell.img1.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[4] == "0" && self.playOff[4] > "2"){
//                            cell.img1.image = UIImage(named: "redCircle")
//                        }else if self.playOff[4] == "0"{
//                            cell.img1.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[3] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[3] == "0" && self.playOff[3] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[3] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[2] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[2] == "0" && self.playOff[2] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[2] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[1] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[1] == "0" && self.playOff[1] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[1] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                        if self.wildCard[0] == "1"{
//                            cell.img2.image = UIImage(named: "greenCircle")
//                        }else if (self.wildCard[0] == "0" && self.playOff[0] > "2"){
//                            cell.img2.image = UIImage(named: "redCircle")
//                        }else if self.playOff[0] == "0"{
//                            cell.img2.backgroundColor = UIColor.clear
//                        }
//                    }
//                }
//            }
//            return cell
//        }
//        return UITableViewCell()
//    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (calendarArray.count)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! YearCollectionViewCell
//        cell.dateLabel.text = self.calendarArray[indexPath.row]
//        cell.dateLabel.adjustsFontSizeToFitWidth = true
////        cell.backgroundColor = UIColor.clear
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! YearCollectionViewCell
//        cell.dateLabel!.textColor = UIColor.white
//    }
//}
//
//

//
//  ScrollViewController.swift
//  tableViewDemo
//
//  Created by Anil Kumar on 19/03/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit
import SwiftCharts

class ScrollViewController: UIViewController, CalendarDelgate, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var scrollView   : UIScrollView!
    @IBOutlet weak var table        : UITableView!
    @IBOutlet weak var dropDown     : DropDown!
    @IBOutlet weak var countryName  : UILabel!
    @IBOutlet weak var teamStandings: UILabel!
    @IBOutlet weak var showTeamWins : UILabel!
    @IBOutlet weak var showDivision : UILabel!
    @IBOutlet weak var getMoreTeams : UIButton!
    @IBOutlet weak var teamChart    : UIView!
    
    private var didLayout  : Bool = false
    private var chart      : Chart?
    let group              = DispatchGroup()
    var calendarArray      = [String]()
    var divisionWinnerName = [String]()
    var TeamName           = [[String]]()
    var Win                = [[String]]()
    var team : [String]    = []
    var win  : [String]    = []
    var custom             = CustomButtonandlabel()
    var year               = [5, 6, 7, 8, 9]
    var team1              = ["NE", "NYJ", "BUF","MIA"]
    var selectedYear       = ["2014", "2015", "2016", "2017", "2018"]
    var calendarPicker     : CalendarPicker?
    var orientation        : Bool = true
    var pageViewController : UIPageViewController?
    var num                = 0
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        self.calendarArray          = getCalendar().arrayOfDates()
        table.layer.borderWidth     = 0.7
        table.layer.borderColor     = UIColor.black.cgColor
        table.backgroundColor       = UIColor(red: 0.122, green: 0.129, blue: 0.141, alpha: 1.0)
        table.tableFooterView       = UIView(frame: .zero)
        teamChart.layer.borderWidth = 0.7
        teamChart.layer.borderColor = UIColor.black.cgColor
        teamChart.backgroundColor   = UIColor(red: 0.122, green: 0.129, blue: 0.141, alpha: 1.0)
        table.dataSource            = self
        table.delegate              = self
        findTeamDetails()
        table.isScrollEnabled = false
    }
    
    func getContentViewController(withIndex index: Int) -> SecondaryViewController{
        
        let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondaryViewController") as! SecondaryViewController
        return contentVC
    }
    
    
    func findTeamDetails(){
        for a in self.selectedYear{
            let runLoop = CFRunLoopGetCurrent()
            Networking.networking.requestForDivWinner(year: a, conferencename: "National", divisionname: "South") { (success, div, error) in
                if success == true {
                    self.divisionWinnerName.append(div)
                    CFRunLoopStop(runLoop)
                }else {
                    self.showConfirmAlert(title: "Alert", message: "Please Check Your Internet Connection", buttonTitle: "OK", buttonStyle: .default, confirmAction: { [weak self] (action) in
                        self?.navigationController?.popToRootViewController(animated: true)
                    })
                }
            }
            CFRunLoopRun()
        }
        print(divisionWinnerName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !self.didLayout {
            self.didLayout = true
            for i in selectedYear{
                self.group.enter()
                Networking.networking.requestForTeamPositionByDivision(year: i, conferenceName: TeamDetails.shared.conferenceName!, divisionName: TeamDetails.shared.divisionName!) { (success, team, win, error) in
                    if success == true{
                        self.TeamName.append(team)
                        self.Win.append(win)
                        self.group.leave()
                        
                    }
                }
            }
            self.group.notify(queue: DispatchQueue.main, execute: {
                self.arrayValues()
                
            })
        }
    }
    
    private func initChart(_ xValue: Int,_ yValue: Int, _ label1: String) {
        // map model data to chart points
        let chartPoints: [ChartPoint] = [(xValue,yValue)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        let values = [
            ChartAxisValueInt(0, labelSettings: labelSettings),
            ChartAxisValueInt(2, labelSettings: labelSettings),
            ChartAxisValueInt(4, labelSettings: labelSettings),
            ChartAxisValueInt(6, labelSettings: labelSettings),
            ChartAxisValueInt(8, labelSettings: labelSettings),
            ChartAxisValueInt(10, labelSettings: labelSettings),
            ChartAxisValueInt(12, labelSettings: labelSettings),
            ChartAxisValueInt(14, labelSettings: labelSettings),
            ChartAxisValueInt(16, labelSettings: labelSettings),
            ]
        
        let values2 = [
            ChartAxisValueString("", order: 1, labelSettings: labelSettings),
            ChartAxisValueString("2011", order: 2, labelSettings: labelSettings),
            ChartAxisValueString("2012", order: 3, labelSettings: labelSettings),
            ChartAxisValueString("2013", order: 4, labelSettings: labelSettings),
            ChartAxisValueString("2014", order: 5, labelSettings: labelSettings),
            ChartAxisValueString("2015", order: 6, labelSettings: labelSettings),
            ChartAxisValueString("2016", order: 7, labelSettings: labelSettings),
            ChartAxisValueString("2017", order: 8, labelSettings: labelSettings),
            ChartAxisValueString("2018", order: 9, labelSettings: labelSettings),
            ChartAxisValueString("", order: 10, labelSettings: labelSettings),
            ]
        
        let labels        = ChartAxisLabel(text: "Wins", settings: labelSettings.defaultVertical())
        
        let labels1       = ChartAxisLabel(text: "", settings: labelSettings)
        
        let yModel        = ChartAxisModel(axisValues: values, axisTitleLabel: labels)
        
        let xModel        = ChartAxisModel(axisValues: values2, axisTitleLabel: labels1)
        
        let chartFrame    = ExamplesDefaults.chartFrame(view.bounds)
        
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        // generate axes layers and calculate chart inner frame, based on the axis models
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        // create layer with guidelines
        let guidelinesLayerSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.white, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
        
        // view generator - this is a function that creates a view for each chartpoint
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let viewSize: CGFloat = Env.iPad ? 30 : 20
            let center = chartPointModel.screenLoc
            let label = UILabel(frame: CGRect(x: center.x - viewSize / 2, y: center.y - viewSize / 2, width: viewSize, height: viewSize))
            if label1 == TeamDetails.shared.teamName{
                label.backgroundColor = UIColor.green
                label.layer.shadowColor = UIColor.purple.cgColor
            }else{
                label.backgroundColor = UIColor.white
                label.layer.shadowColor = UIColor.white.cgColor
            }
            label.layer.borderWidth = 0.5
            label.adjustsFontSizeToFitWidth = true
            label.layer.borderColor = UIColor.black.cgColor
            label.textAlignment = NSTextAlignment.center
            label.text = label1
            label.layer.shadowOpacity = 1
            label.layer.shadowOffset = CGSize(width: -1, height: 1)
            label.layer.shadowRadius = 3
            label.layer.masksToBounds = false
            label.font = ExamplesDefaults.labelFont
            return label
        }
        
        // create layer that uses viewGenerator to display chartpoints
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: viewGenerator, mode: .translate)
        
        // create chart instance with frame and layers
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLayer
            ]
        )
        view.addSubview(chart.view)
        self.chart = chart
    }
    
    func rotated() {
        for view in self.teamChart.subviews {
            view.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        countryName.text = UserDefaults.GetString.uppercased()
        custom.LabelAttributes(Label: showTeamWins)
        custom.SelectedLabelAttributes(Label: showDivision)
        custom.ButtonAttributes(Button: getMoreTeams)
        dropDown.text = "Teams"
        dropDown.textColor = UIColor.white
        dropDown.optionArray = [UserDefaults.GetString]
        dropDown.optionIds = [1,23,54,22]
        dropDown.arrow.backgroundColor = UIColor.white
        dropDown.borderWidth = 0.5
        dropDown.borderColor = UIColor.lightGray
        dropDown.didSelect{(selectedText , index ,id) in
            self.dropDown.text = "\(selectedText)"
        }
        self.view.bringSubviewToFront(dropDown)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if UIDevice.current.orientation.isPortrait{
            orientation = true
            self.table.reloadData()
            print("Portrait")
        }else {
            orientation = false
            self.table.reloadData()
            print("Landscape")
        }
    }
    
    func getCalendar() -> CalendarPicker {
        if calendarPicker == nil {
            calendarPicker = CalendarPicker()
            calendarPicker?.delegate = self
        }
        return calendarPicker!
    }
    
    
    func arrayValues(){
        for i in TeamName{
            team = i
        }
        for j in Win{
            win = j
        }
        for year in year{
            for _ in 0..<(team1.count){
                self.initChart(year, Int(win[num])!, team[num])
                num = num + 1
            }
        }
    }
    
    
    func registerTableViewCell(){
        
        let firstcell           = UINib(nibName: "CollectionTableCell", bundle: nil)
        self.table.register(firstcell, forCellReuseIdentifier: "CollectionTableCell")
        let secondcell          = UINib(nibName: "SBWinnerViewCell", bundle: nil)
        self.table.register(secondcell, forCellReuseIdentifier: "SBWinnerViewCell")
        let thirdcell           = UINib(nibName: "LandscapeSBWinnerCell", bundle: nil)
        self.table.register(thirdcell, forCellReuseIdentifier: "LandscapeSBWinnerCell")
        let fourthcell          = UINib(nibName: "SBLoserViewCell", bundle: nil)
        self.table.register(fourthcell, forCellReuseIdentifier: "SBLoserViewCell")
        let fifthcell           = UINib(nibName: "LandscapeSBLoserCell", bundle: nil)
        self.table.register(fifthcell, forCellReuseIdentifier: "LandscapeSBLoserCell")
        let sixthcell           = UINib(nibName: "DivWinnerViewCell", bundle: nil)
        self.table.register(sixthcell, forCellReuseIdentifier: "DivWinnerViewCell")
        let seventhcell         = UINib(nibName: "LandscapeDivWinnerCell", bundle: nil)
        self.table.register(seventhcell, forCellReuseIdentifier: "LandscapeDivWinnerCell")
        let eigthcell           = UINib(nibName: "PlayOffViewCell", bundle: nil)
        self.table.register(eigthcell, forCellReuseIdentifier: "PlayOffViewCell")
        let ninethcell          = UINib(nibName: "LeagueViewCell", bundle: nil)
        self.table.register(ninethcell, forCellReuseIdentifier: "LeagueViewCell")
        let tenthcell           = UINib(nibName: "ConferenceViewCell", bundle: nil)
        self.table.register(tenthcell, forCellReuseIdentifier: "ConferenceViewCell")
        let eleventhcell        = UINib(nibName: "DivisionViewCell", bundle: nil)
        self.table.register(eleventhcell, forCellReuseIdentifier: "DivisionViewCell")
        let twelfthcell         = UINib(nibName: "WildCardViewCell", bundle: nil)
        self.table.register(twelfthcell, forCellReuseIdentifier: "WildCardViewCell")
        let landscapeleague     = UINib(nibName: "LandscapeLeagueCell", bundle: nil)
        self.table.register(landscapeleague, forCellReuseIdentifier: "LandscapeLeagueCell")
        let landscapeconference = UINib(nibName: "LandscapeConferenceCell", bundle: nil)
        self.table.register(landscapeconference, forCellReuseIdentifier: "LandscapeConferenceCell")
        let landscapedivision   = UINib(nibName: "LandscapeDivisionCell", bundle: nil)
        self.table.register(landscapedivision, forCellReuseIdentifier: "LandscapeDivisionCell")
        let landscapewildcard   = UINib(nibName: "LandscapeWildCardCell", bundle: nil)
        self.table.register(landscapewildcard, forCellReuseIdentifier: "LandscapeWildCardCell")
        let getMoreYears   = UINib(nibName: "GetMoreYearsCell", bundle: nil)
        self.table.register(getMoreYears, forCellReuseIdentifier: "GetMoreYearsCell")
    }
    @IBAction func getMoreTeams(_ sender: Any) {
        CallPopOver()
    }
}

extension ScrollViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableCell", for: indexPath) as? CollectionTableCell
            cell?.collectionView.dataSource = self
            cell?.collectionView.delegate = self
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandscapeSBWinnerCell", for: indexPath) as? LandscapeSBWinnerCell
            cell?.selectionStyle = .none
            cell?.leftLabel.text = "SBWinner"
            cell?.rightLabel.text = "SBWinner"
            return cell!
        }else  if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandscapeSBLoserCell", for: indexPath) as? LandscapeSBLoserCell
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandscapeDivWinnerCell", for: indexPath) as? LandscapeDivWinnerCell
            cell?.activityIndicator.color = UIColor.black
            cell?.activityIndicator.startAnimating()
            cell?.selectionStyle = .none
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
                cell?.activityIndicator.stopAnimating()
                cell?.activityIndicator.isHidden = true
                cell?.Lyear4.text = self.divisionWinnerName[0]
                cell?.Lyear5.text = self.divisionWinnerName[1]
                cell?.Lyear6.text = self.divisionWinnerName[2]
                cell?.Lyear7.text = self.divisionWinnerName[3]
                cell?.Lyear8.text = self.divisionWinnerName[4]
            }
            return cell!
        }else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayOffViewCell", for: indexPath) as? PlayOffViewCell
            cell?.selectionStyle = .none
            let str1 = "Playoffs"
            let trimmedString1 = str1.trimmingCharacters(in: .whitespacesAndNewlines)
            let string1 = NSMutableAttributedString(string: trimmedString1)
            string1.setUnderlineWith(nil, with: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            cell?.leftLabel1.attributedText = string1
            cell?.rightLabel1.attributedText = string1
            
            let str = "Win\\Loss"
            let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
            let string = NSMutableAttributedString(string: trimmedString)
            string.setColorForText("Win", with: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
            string.setColorForText("Loss", with: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
            cell?.leftLabel2.attributedText = string
            cell?.rightLabel2.attributedText = string
            return cell!
        }else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandscapeLeagueCell", for: indexPath) as? LandscapeLeagueCell
            cell?.selectionStyle = .none
            if (TeamDetails.shared.league![4] == "0" && TeamDetails.shared.conference![4] == "1"){
                cell?.leagueWin1.image = UIImage(named: "redStar")
            }else if (TeamDetails.shared.league![4] == "0" && TeamDetails.shared.conference![4] == "0"){
                cell?.leagueWin1.backgroundColor = UIColor.clear
            }else if TeamDetails.shared.league![4] == "1" {
                cell?.leagueWin1.image = UIImage(named: "greenStar")
            }
            if (TeamDetails.shared.league![3] == "0" && TeamDetails.shared.conference![3] == "1"){
                cell?.leagueWin2.image = UIImage(named: "redStar")
            }else if (TeamDetails.shared.league![3] == "0" && TeamDetails.shared.conference![3] == "0"){
                cell?.leagueWin2.backgroundColor = UIColor.clear
            }else if TeamDetails.shared.league![3] == "1" {
                cell?.leagueWin2.image = UIImage(named: "greenStar")
            }
            if (TeamDetails.shared.league![2] == "0" && TeamDetails.shared.conference![2] == "1"){
                cell?.leagueWin3.image = UIImage(named: "redStar")
            }else if (TeamDetails.shared.league![2] == "0" && TeamDetails.shared.conference![2] == "0"){
                cell?.leagueWin3.backgroundColor = UIColor.clear
            }else if TeamDetails.shared.league![2] == "1" {
                cell?.leagueWin3.image = UIImage(named: "greenStar")
            }
            if (TeamDetails.shared.league![1] == "0" && TeamDetails.shared.conference![1] == "1"){
                cell?.leagueWin4.image = UIImage(named: "redStar")
            }else if (TeamDetails.shared.league![1] == "0" && TeamDetails.shared.conference![1] == "0"){
                cell?.leagueWin4.backgroundColor = UIColor.clear
            }else if TeamDetails.shared.league![1] == "1" {
                cell?.leagueWin4.image = UIImage(named: "greenStar")
            }
            if (TeamDetails.shared.league![0] == "0" && TeamDetails.shared.conference![0] == "1"){
                cell?.leagueWin5.image = UIImage(named: "redStar")
            }else if (TeamDetails.shared.league![0] == "0" && TeamDetails.shared.conference![0] == "0"){
                cell?.leagueWin5.backgroundColor = UIColor.clear
            }else if TeamDetails.shared.league![0] == "1" {
                cell?.leagueWin5.image = UIImage(named: "greenStar")
            }
            
            return cell!
        }else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandscapeConferenceCell", for: indexPath) as? LandscapeConferenceCell
            cell?.selectionStyle = .none
            if (TeamDetails.shared.division![4] == "1" && TeamDetails.shared.conference![4] == "0"){
                cell?.conferenceWin1.image = UIImage(named: "redDiamond")
            }else if TeamDetails.shared.conference![4] == "1"{
                cell?.conferenceWin1.image = UIImage(named: "greenDiamond")
            }else if(TeamDetails.shared.division![4] == "0" && TeamDetails.shared.conference![4] == "0"){
                cell?.conferenceWin1.backgroundColor = UIColor.clear
            }
            
            if (TeamDetails.shared.division![3] == "1" && TeamDetails.shared.conference![3] == "0"){
                cell?.conferenceWin2.image = UIImage(named: "redDiamond")
            }else if TeamDetails.shared.conference![3] == "1"{
                cell?.conferenceWin2.image = UIImage(named: "greenDiamond")
            }else if(TeamDetails.shared.division![3] == "0" && TeamDetails.shared.conference![3] == "0"){
                cell?.conferenceWin2.backgroundColor = UIColor.clear
            }
            
            if (TeamDetails.shared.division![2] == "1" && TeamDetails.shared.conference![2] == "0"){
                cell?.conferenceWin3.image = UIImage(named: "redDiamond")
            }else if TeamDetails.shared.conference![2] == "1"{
                cell?.conferenceWin3.image = UIImage(named: "greenDiamond")
            }else if(TeamDetails.shared.division![2] == "0" && TeamDetails.shared.conference![2] == "0"){
                cell?.conferenceWin3.backgroundColor = UIColor.clear
            }
            
            if (TeamDetails.shared.division![1] == "1" && TeamDetails.shared.conference![1] == "0"){
                cell?.conferenceWin4.image = UIImage(named: "redDiamond")
            }else if TeamDetails.shared.conference![1] == "1"{
                cell?.conferenceWin4.image = UIImage(named: "greenDiamond")
            }else if(TeamDetails.shared.division![1] == "0" && TeamDetails.shared.conference![1] == "0"){
                cell?.conferenceWin4.backgroundColor = UIColor.clear
            }
            
            if (TeamDetails.shared.division![0] == "1" && TeamDetails.shared.conference![0] == "0"){
                cell?.conferenceWin5.image = UIImage(named: "redDiamond")
            }else if TeamDetails.shared.conference![0] == "1"{
                cell?.conferenceWin5.image = UIImage(named: "greenDiamond")
            }else if(TeamDetails.shared.division![0] == "0" && TeamDetails.shared.conference![0] == "0"){
                cell?.conferenceWin5.backgroundColor = UIColor.clear
            }
            return cell!
        }else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandscapeDivisionCell", for: indexPath) as? LandscapeDivisionCell
            cell?.selectionStyle = .none
            if (TeamDetails.shared.division![4] == "0" && (TeamDetails.shared.wildCard![4] == "1" || (TeamDetails.shared.playOff![4] == "1" || TeamDetails.shared.playOff![4] == "2"))){
                cell?.divisionWin1.image = UIImage(named: "redSquare")
            }else if TeamDetails.shared.division![4] == "1"{
                cell?.divisionWin1.image = UIImage(named: "greenSquare")
            }else if TeamDetails.shared.playOff![4] == "0"{
                cell?.divisionWin1.backgroundColor = UIColor.clear
            }
            if (TeamDetails.shared.division![3] == "0" && (TeamDetails.shared.wildCard![3] == "1" || (TeamDetails.shared.playOff![3] == "1" || TeamDetails.shared.playOff![3] == "2"))){
                cell?.divisionWin2.image = UIImage(named: "redSquare")
            }else if TeamDetails.shared.division![3] == "1"{
                cell?.divisionWin2.image = UIImage(named: "greenSquare")
            }else if TeamDetails.shared.playOff![3] == "0"{
                cell?.divisionWin2.backgroundColor = UIColor.clear
            }
            if (TeamDetails.shared.division![2] == "0" && (TeamDetails.shared.wildCard![2] == "1" || (TeamDetails.shared.playOff![2] == "1" || TeamDetails.shared.playOff![2] == "2"))){
                cell?.divisionWin3.image = UIImage(named: "redSquare")
            }else if TeamDetails.shared.division![2] == "1"{
                cell?.divisionWin3.image = UIImage(named: "greenSquare")
            }else if TeamDetails.shared.playOff![2] == "0"{
                cell?.divisionWin3.backgroundColor = UIColor.clear
            }
            if (TeamDetails.shared.division![1] == "0" && (TeamDetails.shared.wildCard![1] == "1" || (TeamDetails.shared.playOff![1] == "1" || TeamDetails.shared.playOff![1] == "2"))){
                cell?.divisionWin4.image = UIImage(named: "redSquare")
            }else if TeamDetails.shared.division![1] == "1"{
                cell?.divisionWin4.image = UIImage(named: "greenSquare")
            }else if TeamDetails.shared.playOff![1] == "0"{
                cell?.divisionWin4.backgroundColor = UIColor.clear
            }
            if (TeamDetails.shared.division![0] == "0" && (TeamDetails.shared.wildCard![0] == "1" || (TeamDetails.shared.playOff![0] == "1" || TeamDetails.shared.playOff![0] == "2"))){
                cell?.divisionWin5.image = UIImage(named: "redSquare")
            }else if TeamDetails.shared.division![0] == "1"{
                cell?.divisionWin5.image = UIImage(named: "greenSquare")
            }else if TeamDetails.shared.playOff![0] == "0"{
                cell?.divisionWin5.backgroundColor = UIColor.clear
            }
            return cell!
        }else if indexPath.row == 8{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandscapeWildCardCell", for: indexPath) as? LandscapeWildCardCell
            cell?.selectionStyle = .none
            if TeamDetails.shared.wildCard![4] == "1"{
                cell?.wildCardWin1.image = UIImage(named: "greenCircle")
            }else if (TeamDetails.shared.wildCard![4] == "0" && TeamDetails.shared.playOff![4] > "2"){
                cell?.wildCardWin1.image = UIImage(named: "redCircle")
            }else if TeamDetails.shared.playOff![4] == "0"{
                cell?.wildCardWin1.backgroundColor = UIColor.clear
            }
            if TeamDetails.shared.wildCard![3] == "1"{
                cell?.wildCardWin2.image = UIImage(named: "greenCircle")
            }else if (TeamDetails.shared.wildCard![3] == "0" && TeamDetails.shared.playOff![3] > "2"){
                cell?.wildCardWin2.image = UIImage(named: "redCircle")
            }else if TeamDetails.shared.playOff![3] == "0"{
                cell?.wildCardWin2.backgroundColor = UIColor.clear
            }
            if TeamDetails.shared.wildCard![2] == "1"{
                cell?.wildCardWin3.image = UIImage(named: "greenCircle")
            }else if (TeamDetails.shared.wildCard![2] == "0" && TeamDetails.shared.playOff![2] > "2"){
                cell?.wildCardWin3.image = UIImage(named: "redCircle")
            }else if TeamDetails.shared.playOff![2] == "0"{
                cell?.wildCardWin3.backgroundColor = UIColor.clear
            }
            if TeamDetails.shared.wildCard![1] == "1"{
                cell?.wildCardWin4.image = UIImage(named: "greenCircle")
            }else if (TeamDetails.shared.wildCard![1] == "0" && TeamDetails.shared.playOff![1] > "2"){
                cell?.wildCardWin4.image = UIImage(named: "redCircle")
            }else if TeamDetails.shared.playOff![1] == "0"{
                cell?.wildCardWin4.backgroundColor = UIColor.clear
            }
            if TeamDetails.shared.wildCard![0] == "1"{
                cell?.wildCardWin5.image = UIImage(named: "greenCircle")
            }else if (TeamDetails.shared.wildCard![0] == "0" && TeamDetails.shared.playOff![0] > "2"){
                cell?.wildCardWin5.image = UIImage(named: "redCircle")
            }else if TeamDetails.shared.playOff![0] == "0"{
                cell?.wildCardWin5.backgroundColor = UIColor.clear
            }
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GetMoreYearsCell", for: indexPath) as? GetMoreYearsCell
            custom.ButtonAttributes(Button: (cell?.getMoreYearsButton)!)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 4{
            return 50
        }else if indexPath.row == 9{
            return 57
        }else {
            return 30
        }
    }
}

extension ScrollViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (calendarArray.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearViewCell", for: indexPath) as! YearViewCell
        cell.yearLabel.text = self.calendarArray[indexPath.row]
        cell.yearLabel.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearViewCell", for: indexPath) as! YearViewCell
        cell.yearLabel.textColor = UIColor.black
    }
}

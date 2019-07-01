//
//  Networking.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 26/02/19.
//  Copyright © 2019 AIT. All rights reserved.
//
import Alamofire

class Networking: NSObject {
    //MARK:- Declarations
    var year = [String]()
    var Conf = [String]()
    var League = [String]()
    var WC = [String]()
    var Div = [String]()
    var divname = String()
    var confname = String()
    var playOff = [String]()
    var Team:[String] = []
    var Wins:[String] = []
    var TeamName:[String] = []
    var Win:[String] = []
    var team = String()
    static var networking = Networking()
    
    class Connectivity {
        class func isConnectedToInternet() ->Bool {
            return NetworkReachabilityManager()!.isReachable //define to check whether the network is connected or not
        }
    }
    //MARK: - requestForTeamData
    func requestForTeamData(completionHandler: @escaping (_ success: Bool, _ result: [String], _ error: String) -> Void){ //Service to get response for the Team Names
        
        items.removeAll()
        if Connectivity.isConnectedToInternet() {
            Alamofire.request("http://aitechdemos.com/sites/NFL/public/api/team_names", method: .post, parameters: [:],encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                switch (response.result){
                case .success(_):
                    if let result: [String:Any] = response.result.value as? [String:Any]{
                        let teamlist = result["TeamList"] as! NSArray
                        for i in teamlist{
                            items.append(i as! String)
                        }
                        completionHandler(true, items, "" )
                    }
                case .failure(_):
                    print("failure")
                    completionHandler(false, [""], "error")
                }
            }
        }else{
            print(" No Internet Connection")
        }
    }
    //MARK: - requestForTeamWinning
    func requestForTeamWinning(Name :String ,completionHandler: @escaping (_ success: Bool, _ Team: String,_ Year: [String],_ Div: [String],_ League: [String],_ Conf: [String],_ WC: [String],_ divname: String,_ confname: String,_ playOff: [String], _ error: String) -> Void){ //Service to get response for the team details
        
        if Connectivity.isConnectedToInternet() {
            let urlString = "http://aitechdemos.com/sites/NFL/public/api/team_details?TeamName=\(Name)"
            let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            Alamofire.request(encodedUrl!, method: .post, parameters: ["":""],encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                switch (response.result){
                case .success(_):
                    if let result: [String:Any] = response.result.value as? [String:Any]{
                        let details = result["details"] as! [[String:Any]]
                        for detail in details{
                            let a = detail["Year"] as! String
                            let b = detail["LeagueChampionshipWinner"] as! String
                            let c = detail["ConferenceChampionship"] as! String
                            let d = detail["DivisionWinner"] as! String
                            let e = detail["WildCardWinner"] as! String
                            let f = detail["PlayoffSeed"] as! String
                            self.team = detail["Team"] as! String
                            self.divname = detail["DivisionName"] as! String
                            self.confname = detail["ConferenceName"] as! String
                            self.year.append(a)
                            self.League.append(b)
                            self.Conf.append(c)
                            self.Div.append(d)
                            self.WC.append(e)
                            self.playOff.append(f)
                        }
                        completionHandler(true,self.team, self.year, self.Div, self.League, self.Conf, self.WC,self.divname,self.confname,self.playOff,"" )
                    }
                case .failure(_):
                    print("failure")
                    completionHandler(false,"",[""],[""],[""],[""],[""],"","",[""], "error")
                }
            }
        }else{
            print("No Internet Connection")
        }
    }
    //MARK: - requestForDivWinner
    func requestForDivWinner(year: String, conferencename: String, divisionname: String ,completionHandler: @escaping (_ success: Bool, _ Div: String,_ error: String) -> Void){ //Service to get response for the Division Winner
        
        if Connectivity.isConnectedToInternet() {
            Alamofire.request("http://aitechdemos.com/sites/NFL/public/api/division-winner?Year=\(year)&ConferenceName=\(conferencename)&DivisionName=\(divisionname)", method: .post).responseJSON { response in
                switch (response.result){
                case .success(_):
                    if let result: [String:Any] = response.result.value as? [String:Any]{
                        for _ in result{
                            sbw = result["DivisionWinner"] as! String
                        }
                        completionHandler(true, sbw,  "" )
                    }
                case .failure(_):
                    print("failure")
                    completionHandler(false, "", "error")
                }
            }
        }else{
            print("No Internet Connection")
        }
    }
    //MARK: - requestForTeamPosition
    func requestForTeamPosition(year: String ,completionHandler: @escaping (_ success: Bool, _ SBW: String,_ SBL: String, _ error: String) -> Void){ //Service to get response for the SBWinner and SBLoser
        if Connectivity.isConnectedToInternet() {
            Alamofire.request("http://aitechdemos.com/sites/NFL/public/api/sb-status?Year=\(year)", method: .post).responseJSON { response in
                switch (response.result){
                case .success(_):
                    if let result: [String:Any] = response.result.value as? [String:Any]{
                        for _ in result{
                            sbw = result["SBWinner"] as! String
                            sbl = result["SBLoser"] as! String
                        }
                        completionHandler(true, sbw, sbl,  "" )
                    }
                case .failure(_):
                    print(response)
                    print("failure")
                    completionHandler(false, "", "", "error")
                }
            }
        }else{
            print("No Internet Connection")
        }
    }
    
    func requestForTeamWins(year: String, completionHandler: @escaping (_ success: Bool, _ Team: [String], _ Wins: [String], _ error: String) -> Void){
        Team.removeAll()
        Wins.removeAll()
        if Connectivity.isConnectedToInternet() {
            Alamofire.request("http://aitechdemos.com/sites/NFL/public/api/team-win-details?Year=\(year)", method: .post).responseJSON { response in
                switch (response.result){
                case .success(_):
                    if let result: [String:Any] = response.result.value as? [String:Any]{
                        let details = result["TeamWinDetails"] as! [[String:Any]]
                        for detail in details{
                            let a = detail["Team"] as! String
                            let b = detail["W"] as! String
                            self.Team.append(a)
                            self.Wins.append(b)
                        }
                        completionHandler(true, self.Team, self.Wins, "")
                    }
                    print("success")
                case .failure(_):
                    completionHandler(false, [""], [""], "error")
                    print("failure")
                    
                }
            }
        }
    }
    
    func requestForTeamPositionByDivision(year: String, conferenceName: String, divisionName: String, completionHandler: @escaping (_ success: Bool, _ teamName: [String], _ Wins: [String], _ error: String)-> Void){
        TeamName.removeAll()
        Win.removeAll()
        if Connectivity.isConnectedToInternet() {
            Alamofire.request("http://aitechdemos.com/sites/NFL/public/api/team-names-by-divname?Year=\(year)&ConferenceName=\(conferenceName)&DivisionName=\(divisionName)", method: .post).responseJSON { response in
                switch (response.result){
                case .success(_):
                    if let result: [String:Any] = response.result.value as? [String:Any]{
                        let details = result["TeamWinDetails"] as! [[String:Any]]
                        for detail in details{
                            let a = detail["Team"] as! String
                            let b = detail["W"] as! String
                            self.TeamName.append(a)
                            self.Win.append(b)
                        }
                        completionHandler(true, self.TeamName, self.Win, "")
                    }
                case .failure(_):
                    completionHandler(false, [""], [""], "Error")
                }
            }
        }
    }
}

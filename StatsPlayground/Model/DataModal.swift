//
//  DataModal.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 04/04/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import Foundation


class TeamDetails{
    static let shared = TeamDetails()
    
    private init() {}
    
    var divisionName  : String?
    var conferenceName: String?
    var teamName      : String?
    var division      : [String]?
    var league        : [String]?
    var conference    : [String]?
    var wildCard      : [String]?
    var playOff       : [String]?
    var SBwinner      : [String]?
    var SBloser       : [String]?
}

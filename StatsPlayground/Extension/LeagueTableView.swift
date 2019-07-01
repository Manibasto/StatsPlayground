//
//  File.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 28/02/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit
import Charts

//MARK: - NSMutableAttributedString
extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
    func setUnderlineWith(_ textToFind:String?, with color: UIColor){
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.underlineStyle, value:NSUnderlineStyle.thick.rawValue, range: range!)
            addAttribute(NSAttributedString.Key.underlineColor, value:color , range: range!)
        }
    }
}

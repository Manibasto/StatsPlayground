//
//  Extension.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 04/04/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit


extension UIButton {
    func loadingIndicator(show: Bool) {
        let tag = 808404
        if show {
            isEnabled = false
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.color = UIColor.black
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            isEnabled = true
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}

extension UIViewController{
    func showConfirmAlert(title: String?, message: String?, buttonTitle: String, buttonStyle: UIAlertAction.Style, confirmAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: buttonStyle, handler:confirmAction))
        present(alert, animated: true, completion: nil)
    }
}

//
//  MonthView.swift
//  BCalendar
//
//  Created by Vida Rashidi on 2019-11-15.
//  Copyright © 2019 Project. All rights reserved.
//

import UIKit

protocol MonthViewDelegate: class {
    func didChangeMonth()
}

class MonthView: UIView  {
    var monthsArray = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var indexCurrMonth = 0
    var currYear: Int = 0
    var delegate: MonthViewDelegate?
    


@objc func buttonRgtLftAction (sender : UIButton) {
    if sender == btnRgt {
        indexCurrMonth += 1
        if indexCurrMonth > 11 {
            indexCurrMonth = 0
            currYear += 1
            
        }
    } else {
            indexCurrMonth -= 1
            if indexCurrMonth < 0 {
                indexCurrMonth = 11
                currYear -= 1
            }
        }
        
    }
}


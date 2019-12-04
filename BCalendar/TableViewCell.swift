//
//  TableViewCell.swift
//  BCalendar
//
//  Created by Vida Rashidi on 2019-12-04.
//  Copyright © 2019 Project. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    
    var event:Event!{
        didSet{
            
            let eventDate = "\(event.eventday!)" + "-" + "\(event.eventmonth!)" + "-" + "\(event.eventyear!)"
            
            labelDate.text = eventDate
            labelDescription.text = event.eventdescripion
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

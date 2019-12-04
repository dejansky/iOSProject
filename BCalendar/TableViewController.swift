//
//  TableViewController.swift
//  BCalendar
//
//  Created by Vida Rashidi on 2019-12-04.
//  Copyright © 2019 Project. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var event = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        event = DBHelper.shareInstance.getData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBHelper.shareInstance.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.labelDate.text = event[indexPath.row].eventday
        cell.labelDescription.text = event[indexPath.row].eventdescripion
        
        return cell
    }
    
    
    
    
    
    
}

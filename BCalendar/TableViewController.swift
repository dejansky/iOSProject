import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var event = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        event = DBHelper.shareInstance.getData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let eventDate = "\(event[indexPath.row].eventday!)" + "-" + "\(event[indexPath.row].eventmonth!)" + "-" + "\(event[indexPath.row].eventyear!)"
        
        cell.event = event[indexPath.row] //The values to set it to in the tableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            event = DBHelper.shareInstance.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath] , with: .automatic) //The animation when deleting a cell is chosen by table view. Chooses what suits the best
            
        }
    }
    
}

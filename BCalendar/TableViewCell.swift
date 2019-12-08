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

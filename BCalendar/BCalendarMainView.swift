import UIKit



class BCalendarMainView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    
    @IBOutlet weak var calendarDays: UICollectionView!
    @IBOutlet weak var currentMonthLabel: UILabel!

    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var monthEndDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonth = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[currMonth]
        
        currentMonthLabel.text = "\(currentMonth) \(currYear)"
    }
    

   
    @IBAction func nextMonth(_ sender: Any) {
    }
    
    @IBAction func prevMonth(_ sender: Any) {
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthEndDays[currMonth]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroudColor = UIColor.clear
        cell.DateLabel
    }


}

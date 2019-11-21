import UIKit

class BCalendarMainView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //Variables, seperate file?
    let currentDate = Date()
    let calendar = Calendar.current
    
    let currentDay = Calendar.Component(.day, from:)
    
 
    
    @IBOutlet weak var calendarDays: UICollectionView!
    @IBOutlet weak var currentMonth: UILabel!

    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let monthEndDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[]
    }
    

   
    @IBAction func nextMonth(_ sender: Any) {
    }
    
    @IBAction func prevMonth(_ sender: Any) {
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }


}

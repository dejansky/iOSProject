import UIKit

//Variables, seperate file?
let currentDate = Date()
let userCalendar = Calendar.current

let currentDay = userCalendar.component(.day, from: currentDate) //hämta date från användarens kalender
let currentWeekDay = userCalendar.component(.weekday, from: currentDate)
let currentMonth = userCalendar.component(.month, from: currentDate)




class BCalendarMainView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    
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

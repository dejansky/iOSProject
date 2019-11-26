import UIKit



class BCalendarMainView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    
    @IBOutlet weak var calendarDays: UICollectionView!
    @IBOutlet weak var currentMonthLabel: UILabel!

    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var monthEndDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonth = String()
    
    var NumberOfEmptyBox = Int()
    
    var NextNumberOfEmptyBox = Int()
    
    var PreviousNumberOfEmptyBox = 0
    
    var Direction = 0
    
    var PositionIndex = 0
    
    var LeapYearCounter = 0
    
    var DayCounter = 0
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonth = months[currMonth] //Fetch and store data from Date.currMonth
        currentMonthLabel.text = "\(currentMonth) \(currYear)" //Display the month label with combination of current month and year
        
        if currWeekDay == 0 {
            currWeekDay = 7
        }
        GetStartDayDatePosition()
    }
    

   
    @IBAction func nextMonth(_ sender: Any) {
        
        switch currentMonth {
        case "Dec": // In case the currentMont is December applythe following rules
            currMonth = 0 // Set the current month to 0
            currYear += 1 // Add 1 to the current year property in Date.currYear
            Direction = 1 // Defining the direction of wich the GetStartDayDatePositio should follow
            
            GetStartDayDatePosition() //Cilling the func
            
            currentMonth = months[currMonth] //
            currentMonthLabel.text = "\(currentMonth) \(currYear)"
            calendarDays.reloadData()
            
        default:
            Direction = 1
            
            GetStartDayDatePosition()
            
            currMonth += 1
            
            currentMonth = months[currMonth]
            currentMonthLabel.text = "\(currentMonth) \(currYear)"
            calendarDays.reloadData()
            
        }
    }
    
    @IBAction func prevMonth(_ sender: Any) {
        
        switch currentMonth {
        case "Jan":
            currMonth = 11
            currYear -= 1
            Direction = -1
            
            GetStartDayDatePosition()
            
            currentMonth = months[currMonth]
            currentMonthLabel.text = "\(currentMonth) \(currYear)"
            calendarDays.reloadData()
        default:
            
            currMonth -= 1
            Direction = -1
            
            GetStartDayDatePosition()
            
            currentMonth = months[currMonth]
            currentMonthLabel.text = "\(currentMonth) \(currYear)"
            calendarDays.reloadData()
        }
        
    }
    
    func GetStartDayDatePosition() {
        switch Direction {
        case 0:
            NumberOfEmptyBox = currWeekDay
            DayCounter = currDay
            while DayCounter > 0 {
                NumberOfEmptyBox = NumberOfEmptyBox - 1
                DayCounter = DayCounter - 1
                if NumberOfEmptyBox == 0 {
                    NumberOfEmptyBox = 7
                }
            }
            if NumberOfEmptyBox == 7 {
                NumberOfEmptyBox = 0
            }
            PositionIndex = NumberOfEmptyBox
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + monthEndDays[currMonth]) % 7
            PositionIndex = NextNumberOfEmptyBox
        case -1:
            PreviousNumberOfEmptyBox = (7 - (monthEndDays[currMonth] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction {
        case 0:
            return monthEndDays[currMonth] + NumberOfEmptyBox
        case 1...:
            return monthEndDays[currMonth] + NextNumberOfEmptyBox
        case -1:
            return monthEndDays[currMonth] + PreviousNumberOfEmptyBox
            
        default:
            fatalError()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch Direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        if currentMonth == months[currMonth] && currYear == userCalendar.component(.year, from: currentDate) && indexPath.row + 1 == currDay{
            cell.backgroundColor = UIColor.red 
        }
        
        
        return cell
    }


}

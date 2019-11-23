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
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[currMonth]
        
        currentMonthLabel.text = "\(currentMonth) \(currYear)"
    }
    

   
    @IBAction func nextMonth(_ sender: Any) {
        switch currentMonth {
        case "Dec":
            currMonth = 0
            currYear += 1
            Direction = 1
            
            GetStartDayDatePosition()
            
            currentMonth = months[currMonth]
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
            switch currDay {
            case 1...7:
                NumberOfEmptyBox = currWeekDay - currDay
            case 8...14:
                NumberOfEmptyBox = currWeekDay - currDay - 7
            case 15...21:
                NumberOfEmptyBox = currWeekDay - currDay - 14
            case 22...28:
                NumberOfEmptyBox = currWeekDay - currDay - 21
            case 29...31:
                NumberOfEmptyBox = currWeekDay - currDay - 28
            default:
                break
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
        
        return cell
    }


}

import UIKit
import Kingfisher


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
    var DayCounter = 0
    
    var LeapYearList = [2012,2016,2020,2024,2028,2032]
    
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var ConditionLabel: UILabel!
    @IBOutlet weak var DegreesLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        // MARK: - DateView
        super.viewDidLoad()
        currentMonth = months[currMonth]
        currentMonthLabel.text = "\(currentMonth) \(currYear)"
        
        if currWeekDay == 0 {
            currWeekDay = 7
        }
        GetStartDayDatePosition()
        
        // MARK: - WeatherView API
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=2702977&APPID=91b573073a4edc370f7a687f0f5c60fe") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any] else {return}
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp)
                    }
                    
                } catch { print("Error fetching data...") }
            }
        }
        task.resume()
    }
    
    
    // MARK: - Weather Display
    func setWeather(weather: String?, description: String?, temp: Int ) {
        ConditionLabel.text = description ?? "..."
        DegreesLabel.text = "\(KelvinToCelcius(temp: temp)) °C"
        CityNameLabel.text = "Jönköping"
    }
    
    // MARK: - Klevin to Celsius
    func KelvinToCelcius(temp: Int) -> Int{
        let temp = temp - 273
        return temp
        
    }
    
    func isLeapYear(thisYear: Int) -> Bool {
        let thisYearHere = thisYear
        for i in LeapYearList {
            if thisYearHere == i{
                return true
            }
        }
        return false
    }
    // MARK: - Date
    
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
            
            if isLeapYear(thisYear: currYear) == true{
                monthEndDays[1] = 29
            }
            else{
                monthEndDays[1] = 28
            }
            
            GetStartDayDatePosition()
            currMonth += 1
            
            currentMonth = months[currMonth]
            currentMonthLabel.text = "\(currentMonth) \(currYear)"
            
            
            
            calendarDays.reloadData()
            
        }
    }
    
    
    // MARK: - Button Previous
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
            
            if isLeapYear(thisYear: currYear) == true{
                monthEndDays[1] = 29
            }
            else{
                monthEndDays[1] = 28
            }
            
            GetStartDayDatePosition()
            
            currentMonth = months[currMonth]
            currentMonthLabel.text = "\(currentMonth) \(currYear)"
            
            
            
            calendarDays.reloadData()
            
            
        }
        
    }
    
    // MARK: - GetStartDatePosition()
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
    
    
    // MARK: - collectionView
    
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
    
    // MARK: - collectionView Cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = UIColor.black
        
        
        
        let events = DBHelper.shareInstance.getData()
        for event in events{
            if event.eventday == cell.DateLabel.text &&
            event.eventmonth == currentMonthLabel.text{
                cell.backgroundColor = UIColor.green
                //Bug: vilket index ska användas för att nå rätt dag?
            }
            
            }
        
        
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
        
        
        if currentMonth == months[userCalendar.component(.month, from: currentDate)-1] && currYear == userCalendar.component(.year, from: currentDate) && indexPath.row + 1 == currDay + NumberOfEmptyBox {
            cell.backgroundColor = UIColor.red
        }
        
        
        return cell
    }
    
    
    
}

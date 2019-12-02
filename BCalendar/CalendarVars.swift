import Foundation



let currentDate = Date()
let userCalendar = Calendar.current

let currDay = userCalendar.component(.day, from: currentDate) //hämta date från användarens kalender
var currWeekDay = userCalendar.component(.weekday, from: currentDate) - 1
var currMonth = userCalendar.component(.month, from: currentDate) - 1 
var currYear = userCalendar.component(.year, from: currentDate)

var events = DBHelper.shareInstance.getData()



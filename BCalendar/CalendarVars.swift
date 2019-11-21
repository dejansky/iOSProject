import Foundation



let currentDate = Date()
let userCalendar = Calendar.current

let currDay = userCalendar.component(.day, from: currentDate) //hämta date från användarens kalender
let currWeekDay = userCalendar.component(.weekday, from: currentDate)
let currMonth = userCalendar.component(.month, from: currentDate) - 1
let currYear = userCalendar.component(.year, from: currentDate)

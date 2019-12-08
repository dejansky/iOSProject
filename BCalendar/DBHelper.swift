import Foundation
import CoreData
import UIKit

//MARK: - CRUD Operations

class DBHelper{
    static var shareInstance = DBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveData(object:[String:String]){
        let thisEvent =
            NSEntityDescription.insertNewObject(forEntityName: "Event", into: context!) as! Event
        
        thisEvent.eventday = object["eventday"]
        thisEvent.eventyear = object["eventyear"]
        thisEvent.eventmonth = object["eventmonth"]
        thisEvent.eventdescripion = object["eventdescription"]
        
        do{
            try context?.save()
        }catch{
            print("No data to save")
        }
    }
    
    func getData() -> [Event]{
        var event = [Event]()
        let fetchRequest = NSFetchRequest <NSManagedObject> (entityName: "Event")
        do{
            event = try context?.fetch(fetchRequest) as! [Event]
        }catch {
            print ("Data cannot be fetched ")
        }
        return event
    }
    
    func deleteData(index:Int) -> [Event]{
        var eventArray = getData()
        context?.delete(eventArray[index])
        eventArray.remove(at: index)
        do {
            try context?.save()
        }
        catch{
            print("Cannot delete data")
        }
        return eventArray
    }
    
}

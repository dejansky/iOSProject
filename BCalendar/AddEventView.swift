
import UIKit

class AddEventView: UIViewController {
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    @IBOutlet weak var DateTimeField: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    
    @IBOutlet weak var bttnCreateEvent: UIButton!
    
    //MARK: - Seperate the date
    func dataSeperator() -> (eventday:String, eventmonth:String, eventyear:String){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let eventday = formatter.string(from: DateTimePicker.date)
        formatter.dateFormat = "MM"
        let eventmonth = formatter.string(from: DateTimePicker.date)
        formatter.dateFormat = "yyyy"
        let eventyear = formatter.string(from: DateTimePicker.date)
        
        return (eventday, eventmonth, eventyear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DateTimeField.delegate = self
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        DateTimeField.text = formatter.string(from: DateTimePicker.date)
        //Format to strings
    }
    
    @IBAction func bttnCreateEvent(_ sender: Any) {
        
        let dict = ["eventday":dataSeperator().eventday, "eventmonth":dataSeperator().eventmonth as Any, "eventyear":dataSeperator().eventyear ,"eventdescription": eventDescription.text as Any] as [String : Any]
        
        DBHelper.shareInstance.saveData(object : dict as! [String:String])
        self.dismiss(animated: true)
    }
    
    @IBAction func SelectedDateTime (_ : AnyObject){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        DateTimeField.text = formatter.string(from: DateTimePicker.date)
    }
    
    
    //MARK: - Dismissing keyboards
    
    //Dismisses the keyboard when editing has finished
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        //self.view.endEditing(true)
        self.eventDescription.resignFirstResponder()
    }
}

//Dismisses the keyboard when editing has finished
extension AddEventView : UITextFieldDelegate {
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


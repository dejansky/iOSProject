
import UIKit

class AddEventView: UIViewController {

    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    @IBOutlet weak var DateTimeField: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DateTimeField.delegate = self
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        DateTimeField.text = formatter.string(from: DateTimePicker.date)
        //Format to strings
    }
    
    
    
    @IBAction func bttnCreateEvent(_ sender: Any) {
        let dict = ["eventdatetime": DateTimeField.text ,"eventdescription": eventDescription.text]
        DBHelper.shareInstance.saveEvent(object : dict as! [String:String])
    }
    
    @IBAction func SelectedDateTime (_ : AnyObject){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
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


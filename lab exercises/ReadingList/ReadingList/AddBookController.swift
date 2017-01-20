import UIKit

class AddBookController: UITableViewController
{
    var completion: ((Book) -> Void)?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    var book: Book {
        return Book(dictionary: [titleKey: titleField.text ?? "",
                                 yearKey: yearField.text ?? "",
                                 authorKey: [firstNameKey: firstNameField.text ?? "",
                                             lastNameKey: lastNameField.text ?? ""]])
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Done" {
            completion?(book)
        }
    }
}

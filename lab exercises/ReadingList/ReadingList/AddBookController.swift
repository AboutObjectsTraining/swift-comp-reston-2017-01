import UIKit

private let fNameKey = Author.firstNameKey
private let lNameKey = Author.lastNameKey

class AddBookController: UITableViewController
{
    var completion: ((Book) -> Void)?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    var book: Book {
        return Book(dictionary: [Book.titleKey: titleField.text.any,
                                 Book.yearKey: yearField.text.any,
                                 Book.authorKey: [fNameKey: firstNameField.text.any,
                                                  lNameKey: lastNameField.text.any]])
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Done" {
            completion?(book)
        }
    }
}

extension Optional
{
    var any: Any { return self ?? NSNull() }
}


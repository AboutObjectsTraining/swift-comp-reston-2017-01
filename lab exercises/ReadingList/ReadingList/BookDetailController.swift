import UIKit

class BookDetailController: UITableViewController
{
    var book: Book?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var authorImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateViews()
    }
    
    func populateViews() {
        titleLabel.text = book?.title
        yearLabel.text = book?.year
        firstNameLabel.text = book?.author?.firstName
        lastNameLabel.text = book?.author?.lastName
        
        authorImageView.image = UIImage.image(named: book?.author?.lastName ?? "")
    }
    
    @IBAction func cancelEditing(segue: UIStoryboardSegue) { }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editBookController = segue.realDestination as? EditBookController else {
            fatalError("Unable to downcast destination as \(EditBookController.self)")
        }
        editBookController.book = book
    }
}

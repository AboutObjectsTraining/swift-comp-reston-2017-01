import UIKit

class ReadingListController: UITableViewController
{
    var readingListStore: ReadingListStore?
    var readingList: ReadingList?
    
    override func viewDidLoad() {
        readingListStore = ReadingListStore("BooksAndAuthors")
        // TODO: move to a concurrent queue
        readingList = readingListStore?.fetchReadingList()
        print(readingList ?? "Unable to load reading list.")
    }
    
    func save() {
        guard let readingList = readingList else { return }
        readingListStore?.saveReadingList(readingList)
    }
    
    @IBAction func doneEditing(segue: UIStoryboardSegue) {
        save()
        tableView.reloadData()
    }
    
    @IBAction func doneAdding(segue: UIStoryboardSegue) {
        save()
        tableView.reloadData()
    }
    
    @IBAction func cancelEditing(segue: UIStoryboardSegue) { }
    @IBAction func cancelAdding(segue: UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "Add":
            if let addController = segue.realDestination as? AddBookController {
                addController.completion = { book in
                    self.readingList?.books.insert(book, at: 0)
                }
            }
        case "Edit":
            if let bookDetailController = segue.destination as? BookDetailController,
                let indexPath = tableView.indexPathForSelectedRow {
                bookDetailController.book = readingList?.books[indexPath.row]
            }
        default: break
        }
    }
}


// MARK: - UITableViewDataSource

extension ReadingListController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingList?.books.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") else {
            fatalError("Unable to dequeue cell. Make sure the reuse identifier is set in the storybard.")
        }
        
        let book = readingList?.books[indexPath.row]
        cell.textLabel?.text = book?.title
        cell.detailTextLabel?.text = "\(book?.year ?? "N/A")  \(book?.author?.fullName ?? "Unknown")"
        cell.imageView?.image = UIImage.image(named: book?.author?.lastName ?? "")
        
        return cell
    }
}


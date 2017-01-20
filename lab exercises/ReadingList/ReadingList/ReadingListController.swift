import UIKit

class ReadingListController: UITableViewController
{
    var readingListStore: ReadingListStore?
    var readingList: ReadingList?
    
    override func viewDidLoad() {
        loadReadingList()
        configureNavigationItem()
    }
    
    func configureNavigationItem() {
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func loadReadingList() {
        readingListStore = ReadingListStore("BooksAndAuthors")
        
        DispatchQueue.global().async {
            self.readingList = self.readingListStore?.fetchReadingList()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let readingList = self.readingList else { return }
            self.readingListStore?.saveReadingList(readingList)
        }
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
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        guard let book = readingList?.books[sourceIndexPath.row] else { return }
        readingList?.books.remove(at: sourceIndexPath.row)
        readingList?.books.insert(book, at: destinationIndexPath.row)
        save()
        
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        guard editingStyle == .delete else { return }
        readingList?.books.remove(at: indexPath.row)
        save()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
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


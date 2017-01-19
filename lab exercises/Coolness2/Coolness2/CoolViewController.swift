import UIKit

class CoolViewController: UIViewController
{
    @IBOutlet var contentView: UIView?
    @IBOutlet var textField: UITextField!
    
    @IBAction func addCoolViewCell() {
        let newCell = CoolViewCell()
        newCell.text = textField.text
//        newCell.sizeToFit()
        contentView?.addSubview(newCell)
    }
}

extension CoolViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



// MARK: View Loading
extension CoolViewController
{
    static let coolViewCellNib = UINib(nibName: "CoolStuff", bundle: nil)
    
    func loadView4() {
        CoolViewController.coolViewCellNib.instantiate(withOwner: self, options: nil)
    }
    
    func loadView3() {
        Bundle.main.loadNibNamed("CoolStuff", owner: self, options: nil)
    }
    
    func loadView2() {
        guard let topLevelObjs = Bundle.main.loadNibNamed("CoolStuff", owner: nil, options: nil),
            let backgroundView = topLevelObjs.first as? UIView else { return }
        view = backgroundView
    }
    
    func loadView1() {
        view = UIView(frame: UIScreen.main.bounds)
        
        let (accessoryRect, contentRect) = UIScreen.main.bounds.divided(atDistance: 90, from: .minYEdge)
        contentView = UIView(frame: contentRect)
        let accessoryView = UIView(frame: accessoryRect)
        
        let subview1 = CoolViewCell(frame: CGRect(x: 20, y: 30, width: 80, height: 30))
        let subview2 = CoolViewCell(frame: CGRect(x: 40, y: 80, width: 80, height: 30))
        
        contentView?.clipsToBounds = true
        
        view.addSubview(accessoryView)
        view.addSubview(contentView!)
        contentView?.addSubview(subview1)
        contentView?.addSubview(subview2)
        
        // Controls
        
        textField = UITextField(frame: CGRect(x: 8, y: 40, width: 240, height: 30))
        accessoryView.addSubview(textField)
        
        textField.placeholder = "Enter some text"
        textField.borderStyle = .roundedRect
        
        textField.delegate = self
        
        
        let button = UIButton(type: .system)
        accessoryView.addSubview(button)
        
        button.setTitle("Add", for: .normal)
        button.sizeToFit()
        button.frame = button.frame.offsetBy(dx: 260, dy: 40)
        
        button.addTarget(self, action: #selector(addCoolViewCell), for: .touchUpInside)
        
        
        // Cool View Cells
        
        subview1.text = "CoolViewCells Rock!"
        subview2.text = "Now on the App Store!"
        
        subview1.sizeToFit()
        subview2.sizeToFit()
        
        view.backgroundColor = UIColor.brown
        accessoryView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        contentView?.backgroundColor = UIColor(white: 1, alpha: 0.7)
        subview1.backgroundColor = UIColor.purple
        subview2.backgroundColor = UIColor.orange
    }
}

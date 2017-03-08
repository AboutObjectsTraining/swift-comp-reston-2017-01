import UIKit

class CoolViewCell: UIView
{
    var text: String?
    
    var highlighted: Bool = false {
        didSet {
            alpha = highlighted ? 0.5 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        let tapRecognizer1 = UITapGestureRecognizer(target: self,
                                                    action: #selector(bounce(tapRecognizer:)))
        tapRecognizer1.numberOfTapsRequired = 1
        addGestureRecognizer(tapRecognizer1)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        addGestureRecognizer(panRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: nil)
        recognizer.setTranslation(CGPoint.zero, in: nil)
        frame.origin.x += translation.x
        frame.origin.y += translation.y
        
        highlighted =
            recognizer.state != .ended &&
            recognizer.state != .cancelled &&
            recognizer.state != .failed
    }
}

// MARK: Animation

extension CoolViewCell
{
    func bounce(tapRecognizer: UITapGestureRecognizer) {
        print("In \(#function)...")
        animateBounce(size: CGSize(width: 120, height: 240))
    }
    
    func configureBounce(size: CGSize) {
        UIView.setAnimationRepeatCount(3.5)
        UIView.setAnimationRepeatAutoreverses(true)
        // self.frame = self.frame.offsetBy(dx: size.width, dy: size.height)
        let translation = CGAffineTransform(translationX: size.width, y: size.height)
        self.transform = translation.rotated(by: CGFloat(M_PI_2))
    }
    
    func animateBounceCompletion(size: CGSize)
    {
        UIView.animate(withDuration: 1.0) {
            self.transform = CGAffineTransform.identity
            // self.frame = self.frame.offsetBy(dx: -size.width, dy: -size.height)
        }
    }
    
    func animateBounce(size: CGSize)
    {
        UIView.animate(
            withDuration: 1.0,
            animations: { self.configureBounce(size: size) },
            completion: { _ in self.animateBounceCompletion(size: size) })
    }
}


// MARK: Drawing

extension CoolViewCell
{
    static let defaultPadding = CGFloat(8)
    class var xPad: CGFloat { return defaultPadding }
    var yPadding: CGFloat { return 8 }
    var xPadding: CGFloat { return 8 }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let text = text else { return size }
        var newSize = (text as NSString).size(attributes:  type(of:self).defaultAttributes)
        newSize.width += xPadding * 2
        newSize.height += yPadding * 2
        return newSize
    }
    
    class var defaultAttributes: [String: Any] {
        return [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),
                NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func draw(_ rect: CGRect) {
        guard let text = text else { return }
        (text as NSString).draw(at: CGPoint(x: xPadding, y: yPadding), withAttributes: type(of: self).defaultAttributes)
    }
}

// MARK: - UIResponder Methods

extension CoolViewCell
{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        superview?.bringSubview(toFront: self)
        highlighted = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let currLocation = touch.location(in: nil)
//        let prevLocation = touch.previousLocation(in: nil)
//        
//        frame.origin.x += currLocation.x - prevLocation.x
//        frame.origin.y += currLocation.y - prevLocation.y
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }
}

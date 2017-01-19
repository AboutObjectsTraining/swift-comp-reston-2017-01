import UIKit

@IBDesignable
class CoolViewCell: UIView
{
    @IBInspectable var text: String? {
        didSet { self.sizeToFit() }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    var highlighted: Bool = false {
        didSet {
            alpha = highlighted ? 0.5 : 1.0
        }
    }
    
    func configureLayer() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func configureRecognizers() {
        let tapRecognizer1 = UITapGestureRecognizer(target: self,
                                                    action: #selector(bounce(tapRecognizer:)))
        tapRecognizer1.numberOfTapsRequired = 2
        addGestureRecognizer(tapRecognizer1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
        configureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayer()
        configureRecognizers()
    }
}

// MARK: Animation

extension CoolViewCell
{
    func bounce(tapRecognizer: UITapGestureRecognizer) {
        print("In bounce...")
        animateBounce(size: CGSize(width: 120, height: 240))
    }
    
    func configureBounce(size: CGSize) {
        UIView.setAnimationRepeatCount(3.5)
        UIView.setAnimationRepeatAutoreverses(true)
        self.frame = self.frame.offsetBy(dx: size.width, dy: size.height)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
    }
    
    func animateBounceCompletion(size: CGSize)
    {
        UIView.animate(withDuration: 1.0) {
            self.transform = CGAffineTransform.identity
            self.frame = self.frame.offsetBy(dx: -size.width, dy: -size.height)
        }
    }
    
    func animateBounce(size: CGSize)
    {
        UIView.animate(
            withDuration: 1.0,
            animations: { self.configureBounce(size: size) },
            completion: { finished in self.animateBounceCompletion(size: size) })
    }
}


// MARK: Drawing

extension CoolViewCell
{
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
        guard let touch = touches.first else { return }
        let currLocation = touch.location(in: nil)
        let prevLocation = touch.previousLocation(in: nil)
        
        frame.origin.x += currLocation.x - prevLocation.x
        frame.origin.y += currLocation.y - prevLocation.y
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }
}

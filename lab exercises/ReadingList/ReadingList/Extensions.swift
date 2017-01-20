import UIKit

extension UIImage
{
    class func image(named name: String) -> UIImage? {
        if let newImage = UIImage(named: name) { return newImage }
        return UIImage(named: "NoImage")
    }
}

extension UIStoryboardSegue
{
    var realDestination: UIViewController {
        if let navController = destination as? UINavigationController,
            let destinationController = navController.childViewControllers.first {
            return destinationController
        }
        
        return destination
    }
}

//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

open class ModelObject: NSObject
{
    // TODO: Ideally, keys would be a class variable, but that feature
    // isn't yet supported in the current version of Swift.
    //
    //     class let keys = []
    //
    class func keys() -> [String]
    {
        return []
    }
    
    public required init(dictionary: [String: Any])
    {
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    open func dictionaryRepresentation() -> [String: Any]
    {
        return self.dictionaryWithValues(forKeys: type(of: self).keys()) as [String : Any]
    }
}

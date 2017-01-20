//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

let titleKey = "title"
let yearKey = "year"
let authorKey = "author"

let unknown = "unknown"

open class Book: ModelObject
{
    open var title: String?
    open var year: String?
    open var author: Author?
    
    open override var description: String {
        return "\(title), \(year), \(author?.description ?? unknown)"
    }
    
    override class func keys() -> [String]
    {
        return [titleKey, yearKey, authorKey]
    }
    
    public required init(dictionary: [String : Any])
    {
        var bookInfo = dictionary
        if let authorInfo = dictionary[authorKey] as? [String: Any] {
            bookInfo[authorKey] = Author(dictionary: authorInfo)
        }
        
        super.init(dictionary: bookInfo)
    }
    
    open override func dictionaryRepresentation() -> [String: Any]
    {
        var dict = super.dictionaryRepresentation()
        if let author = dict[authorKey] as? Author {
            dict[authorKey] = author.dictionaryRepresentation() as Any?
        }
        
        return dict
    }
}


//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

let TitleKey = "title"
let YearKey = "year"
let AuthorKey = "author"

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
        return [TitleKey, YearKey, AuthorKey]
    }
    
    public required init(dictionary: [String : Any])
    {
        var bookInfo = dictionary
        if let authorInfo = dictionary[AuthorKey] as? [String: Any] {
            bookInfo[AuthorKey] = Author(dictionary: authorInfo)
        }
        
        super.init(dictionary: bookInfo)
    }
    
    open override func dictionaryRepresentation() -> [String: Any]
    {
        var dict = super.dictionaryRepresentation()
        if let author = dict[AuthorKey] as? Author {
            dict[AuthorKey] = author.dictionaryRepresentation() as Any?
        }
        
        return dict
    }
}


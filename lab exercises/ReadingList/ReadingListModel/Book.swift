//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

open class Book: ModelObject
{
    public static let titleKey = "title"
    public static let yearKey = "year"
    public static let authorKey = "author"
    
    open var title: String?
    open var year: String?
    open var author: Author?
    
    open override var description: String {
        return "title: \(title ?? "nil"), year: \(year ?? "nil"), author: \(author?.description ?? "nil")"
    }
    
    open override class var keys: [String] {
        return [titleKey, yearKey, authorKey]
    }
    
    public required init(dictionary: [String : Any]) {
        var bookInfo = dictionary
        if let authorInfo = dictionary[Book.authorKey] as? [String: Any] {
            bookInfo[Book.authorKey] = Author(dictionary: authorInfo)
        }
        super.init(dictionary: bookInfo)
    }
    
    open override func dictionaryRepresentation() -> [String: Any] {
        var dict = super.dictionaryRepresentation()
        if let author = dict[Book.authorKey] as? Author {
            dict[Book.authorKey] = author.dictionaryRepresentation() as Any?
        }
        return dict
    }
}


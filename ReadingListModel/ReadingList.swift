//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

let BooksKey = "books"

protocol PropertyKeys
{
    var all: [String] { get }
}

open class ReadingList: ModelObject
{    
    open var title = ""
    open var books = [Book]()
    
    open override var description: String {
        var s = "Title: \(title)\nCount: \(books.count)\nBooks:\n------\n"
        for (index, book) in books.enumerated() {
            s += "\(index + 1). \(book)\n"
        }
        return s
    }
    
    override class func keys() -> [String]
    {
        return [TitleKey, BooksKey]
    }
    
    open override func setValue(_ value: Any?, forKey key: String)
    {
        var mappedValue: Any?
        if key == BooksKey, let dicts = value as? [[String: Any]] {
            mappedValue = dicts.map { Book(dictionary: $0) }
        }
        
        super.setValue(mappedValue ?? value, forKey: key)
    }
    
    open override func dictionaryRepresentation() -> [String: Any]
    {
        var dict = super.dictionaryRepresentation()

        if let books = dict[BooksKey] as? [ModelObject] {
            dict[BooksKey] = books.map { $0.dictionaryRepresentation() }
        }
        
        return dict
    }
}

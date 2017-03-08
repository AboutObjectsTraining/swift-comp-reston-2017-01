//
//  ReadingListTests.swift
//  ReadingListTests
//
//  Created by Student on 1/18/17.
//  Copyright © 2017 Student. All rights reserved.
//
import Foundation
import XCTest

@testable import ReadingList

class ReadingListTests: XCTestCase {
    
    func testDictionaryWithNSNull() {
        let bookDict: [String: Any] = [Book.titleKey: "My Title",
                                       Book.yearKey: NSNull(),
                                       Book.authorKey: [Author.firstNameKey: NSNull(),
                                                        Author.lastNameKey: "Homer"]]
        print(bookDict)
        let book = Book(dictionary: bookDict)
        print(book)
    }
    
    func testAuthorName() {
        let unnamedAuthor = Author(dictionary: [:])
        let firstNameOnly = Author(dictionary: [Author.firstNameKey: "Fred"])
        let lastNameOnly = Author(dictionary: [Author.lastNameKey: "Smith"])
        let namedAuthor = Author(dictionary: [Author.firstNameKey: "Fred", Author.lastNameKey: "Smith"])
        XCTAssertEqual(Author.unknown, unnamedAuthor.fullName)
        XCTAssertEqual("Fred", firstNameOnly.fullName)
        XCTAssertEqual("Smith", lastNameOnly.fullName)
        XCTAssertEqual("Fred Smith", namedAuthor.fullName)
    }
    

    func testBookDictionary() {
        let bookInfo: [String: Any?] = [Book.titleKey: "My Title", Book.yearKey: nil]
        
        let foo = bookInfo.filter { key, value in
            return value != nil
        }
        print(foo)
        
        let dict = bookInfo.flatMap { (dict: (key: String, value: Any?)) in
            return dict.value == nil ? nil : (dict.key, dict.value)
        }
        print(dict)
    }
    
}


//extension Dictionary where Key: String, Value: Optional<Any>
//{
//    var flattened: [String: Any] {
//        return [:]
//    }
//}

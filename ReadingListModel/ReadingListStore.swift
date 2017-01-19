//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import Foundation

let documentsURLs = FileManager.default.urls(
    for: FileManager.SearchPathDirectory.documentDirectory, in:
    FileManager.SearchPathDomainMask.userDomainMask)


// MARK: - File Utilities

func fileURLForDocument(_ name: String, type: String) -> URL
{
    precondition(!documentsURLs.isEmpty, "Documents directory must exist.")
    
    let fileURL = documentsURLs.first!
    return fileURL.appendingPathComponent(name).appendingPathExtension(type)
}


// MARK: - ReadingListStore

open class ReadingListStore : NSObject
{
    let storeType = "plist"
    let storeName: String
    let documentURL: URL
    
    public init(_ storeName: String)
    {
        self.storeName = storeName
        documentURL = fileURLForDocument(storeName, type: storeType)
        super.init()
    }
    
    open func fetchReadingList() -> ReadingList
    {
        if FileManager.default.fileExists(atPath: documentURL.path),
            let dict = NSDictionary(contentsOf: documentURL) as? [String: AnyObject]  {
                return ReadingList(dictionary: dict)
        }
        
        let bundle = Bundle(for: ReadingListStore.self)
        guard let URL = bundle.url(forResource: storeName, withExtension: storeType) else {
            fatalError("Unable to locate \(storeName) in app bundle")
        }
        guard let dict = NSDictionary(contentsOf: URL) as? [String: AnyObject] else {
            fatalError("Unable to load \(storeName) with bundle URL \(URL)")
        }
        return ReadingList(dictionary: dict)
    }
    
    open func saveReadingList(_ readingList: ReadingList)
    {
        let dict = readingList.dictionaryRepresentation() as NSDictionary
        dict.write(to: documentURL, atomically: true)
    }
}

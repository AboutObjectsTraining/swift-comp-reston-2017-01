//
// Copyright (C) 2014 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import Foundation

open class Author: ModelObject
{
    public static let firstNameKey = "firstName"
    public static let lastNameKey = "lastName"
    public static let unknown = "Unknown"
    
    open var firstName: String?
    open var lastName: String?
    
    open var fullName: String {
        switch (firstName, lastName) {
        case (nil, nil):          return Author.unknown
        case let (nil, last?):    return last
        case let (first?, nil):   return first
        case let (first?, last?): return first + " " + last
        }
    }
    
    open override var description: String {
        return "\(fullName)"
    }
    
    open override class var keys: [String] {
        return [firstNameKey, lastNameKey]
    }
}

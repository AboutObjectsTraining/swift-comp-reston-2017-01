// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import Foundation

// Implementation of Equatable protocol
//
func ==(lhs: Friendable, rhs: Friendable) -> Bool {
    return lhs.friendID == rhs.friendID
}
func !=(lhs: Friendable, rhs: Friendable) -> Bool {
    return lhs.friendID != rhs.friendID
}

// MARK: - Likeable Protocol

/// Provides methods and properties that determine likeability
protocol Likeable
{
    // MARK: Property Declaration
    var numberOfLikes: Int { get }
    
    // MARK: Method Declarations
    func like()
    func unlike()
}

// MARK: - Friendable Protocol
protocol Friendable
{
    // MARK: Property Declarations
    var friendID: Int { get }
    var friends: [Friendable] { get }
    
    // MARK: Method Declarations
    func friend(_ newFriend: Friendable)
    func unfriend(_ oldFriend: Friendable)
}

// MARK: - Person Class
class Person: Friendable, CustomDebugStringConvertible
{
    // MARK: Person Properties
    var firstName: String
    var lastName: String
    
    // MARK: Likeable Properties
    var numberOfLikes = 0
    
    // MARK: Friendable Properties
    var friendID = 0
    var friends: [Friendable] = []
    
    // MARK: CustomDebugStringConvertible Properties
    var debugDescription: String {
        return "\(firstName) \(lastName), +\(numberOfLikes)"
    }
    
    // MARK: - Initializers
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

// MARK: - Person's Likeable Methods
extension Person: Likeable
{
    func like() {
        numberOfLikes += 1
    }
    
    func unlike() {
        guard numberOfLikes > 0 else { return }
        numberOfLikes -= 1
    }
}

// MARK: - Person's Friendable Methods
extension Person
{
    convenience init(_ firstName: String, _ lastName: String, _ friendID: Int) {
        self.init(firstName: firstName, lastName: lastName)
        self.friendID = friendID
    }
    
    func friend(_ newFriend: Friendable) {
        friends.append(newFriend)
    }
    
    func unfriend(_ oldFriend: Friendable) {
        friends = friends.filter { $0 != oldFriend }
    }
    
    func unfriend2(_ oldFriend: Friendable) {
        let index = friends.index { oldFriend == $0 }
        if index != nil {
            friends.remove(at: index!)
        }
    }
}

















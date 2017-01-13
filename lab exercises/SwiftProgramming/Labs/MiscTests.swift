import XCTest

class MiscTests: XCTestCase
{
    override func setUp() { print("") }
    override func tearDown() { print("") }
    
    enum Color {
        case blue
        case red(String, Int)
    }
    
    
    func testAssociatedValue() {
        
        let foo: Any? = "Hello"
        let bar: Optional<Any> = nil
        
        if let myFoo = foo,
            let myBar = bar,
            let fooString = myFoo as? String,
            fooString.hasPrefix("He")
        {
            print("\(myFoo)")
            print(myBar)
        }
        
        print("\(foo)")
        print(bar)
        
////        let myColor = Color.red("Hey", 42)
//        
//        let nuttin = Optional()
//        let sumptin = Optional("Hey")
//        
//        print(nuttin)
//        print(sumptin)
//        
////        let none = Optional.none
    }
    
    func testStrings()
    {
        let emojiText = "Hello World! 😊 🌍 "
        print(emojiText.characters.count)
    }

    func testCreateDog()
    {
        let rover = Dog()
        rover.isPet = true;
        rover.name = "Rover"
        rover.barkText = "Bow, wow!"
        
        print(rover.description())
        
        print("Address is \(Unmanaged.passUnretained(rover).toOpaque()) ")
        
        print(rover.numberOfLegs)
    }

    var path: String { return Bundle(for: type(of: self)).path(forResource: "Info", ofType: ".plist")! }
    
    func testFileHandle()
    {
        do {
            try showFile(atPath: path)
        }
        catch FileError.nonexistent(let message) { // unwraps associated value
            print(message)
        }
        catch is FileError {
            print("Some other file error occurred.")
        }
        catch {
            print("Unexpected error.")
        }
        
        print("End of test")
    }
    
    struct ContactInfo {
        var phones: [String: String]
        
        // method that takes a single argument of type (String, String) -> Bool
        //
        func phones(matching: (String, String) -> Bool) -> [String: String] {
            var matchedPhones = [String: String]()
            for (key, value) in phones {
                if matching(key, value) {
                    matchedPhones[key] = value
                }
            }
            return matchedPhones
        }
    }
    
    let somePhones = ["home": "202-123-4567", "work": "516-456-7890",
                      "mobile": "914-789-1234", "other:": "914-456-7890"]
    
    let daytimeKeys = Set(["work", "mobile"])

    func testMatchingPhones()
    {
        let contact = ContactInfo(phones: somePhones)
        
        // Calling with trailing closure syntax
        //
        let phonesMatchingAreaCodes = contact.phones { _, value in
            value.hasPrefix("914")
        }
        print(phonesMatchingAreaCodes)

        // When the only param is a trailing closure, parameter list can be ommitted entirely
        //
        let daytimePhones = contact.phones { key, _ in
            key == "work" || key == "mobile"
        }
        print(daytimePhones)
        
        
        let areaCode = "914"
        
        // Capturing state from local context
        //
        let phonesMatchingCapturedValue = contact.phones { _, value in
            value.hasPrefix(areaCode)
        }
        
        print(phonesMatchingCapturedValue)
        
        // Capturing `self`
        //
        let daytimePhonesWithCapturedValue = contact.phones { [unowned self] key, _ in
            self.daytimeKeys.contains(key)
        }
        print(daytimePhonesWithCapturedValue)
    }
}

enum FileError: Error {
    case unknown
    case nonexistent(String) // Note: associated value
}

func showFile(atPath path: String) throws {
    guard let fileHandle = FileHandle(forReadingAtPath: path) else {
        // throws error with associated value
        throw FileError.nonexistent("No file at path \(path)")
    }
    
    defer {
        fileHandle.closeFile()
        print("Closed fileHandle \(fileHandle)")
    }
    
    let data = fileHandle.readDataToEndOfFile()
    FileHandle.standardOutput.write(data)
}


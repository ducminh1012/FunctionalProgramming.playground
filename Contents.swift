import Foundation

enum RideCategory: String {
    case family
    case kids
    case thrill
    case scary
    case relaxing
    case water
}

typealias Minutes = Double
struct Ride {
    let name: String
    let categories: Set<RideCategory>
    let waitTime: Minutes
}

var x = 3
// other stuff...
x = 4

let parkRides = [
    Ride(name: "Raging Rapids", categories: [.family, .thrill, .water], waitTime: 45.0),
    Ride(name: "Crazy Funhouse", categories: [.family], waitTime: 10.0),
    Ride(name: "Spinning Tea Cups", categories: [.kids], waitTime: 15.0),
    Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0),
    Ride(name: "Thunder Coaster", categories: [.family, .thrill], waitTime: 60.0),
    Ride(name: "Grand Carousel", categories: [.family, .kids], waitTime: 15.0),
    Ride(name: "Bumper Boats", categories: [.family, .water], waitTime: 25.0),
    Ride(name: "Mountain Railroad", categories: [.family, .relaxing], waitTime: 0.0)
]

//func sortedNames(of rides: [Ride]) -> [String] {
//    var sortedRides = rides
//    var key: Ride
//
//    // 1
//    for i in (0..<sortedRides.count) {
//        key = sortedRides[i]
//
//        // 2
//        for j in stride(from: i, to: -1, by: -1) {
//            if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
//                sortedRides.remove(at: j + 1)
//                sortedRides.insert(key, at: j)
//            }
//        }
//    }
//
//
//    // 3
//    var sortedNames = [String]()
//    for ride in sortedRides {
//        sortedNames.append(ride.name)
//    }
//
//    return sortedNames
//}

func waitTimeIsShort(ride: Ride) -> Bool {
    return ride.waitTime < 15.0
}

var shortWaitTimeRides = parkRides.filter(waitTimeIsShort)
print(shortWaitTimeRides)

extension RideCategory: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}

extension Ride: CustomStringConvertible {
    var description: String {
        return "⚡️Ride(name: \"\(name)\", waitTime: \(waitTime), categories: \(categories))"
    }
}

func sortedNames(of rides: [Ride]) -> [String] {
    let rideNames = parkRides.map { $0.name }
    return rideNames.sorted(by: <)
}

print(sortedNames(of: parkRides))

func ridesWithWaitTimeUnder(_ waitTime: Minutes, from rides: [Ride]) -> [Ride] {
    return rides.filter { $0.waitTime < waitTime }
}

extension Ride: Comparable {
    static func <(lhs: Ride, rhs: Ride) -> Bool {
        return lhs.waitTime < rhs.waitTime
    }
    
    static func ==(lhs: Ride, rhs: Ride) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Array where Element: Comparable {
    func quickSorted() -> [Element] {
        if self.count > 1 {
            let (pivot, remaining) = (self[0], dropFirst())
            let lhs = remaining.filter { $0 <= pivot }
            let rhs = remaining.filter { $0 > pivot }
            return lhs.quickSorted() as [Element] + [pivot] + rhs.quickSorted()
        }
        return self
    }
}

// Imperative algorithm
var ridesOfInterest: [Ride] = []
for ride in parkRides where ride.waitTime < 20 {
    for category in ride.categories where category == .family {
        ridesOfInterest.append(ride)
        break
    }
}

var sortedRidesOfInterest = ridesOfInterest.quickSorted()
print(sortedRidesOfInterest)

// Declarative - Functional
sortedRidesOfInterest = parkRides.filter { $0.categories.contains(.family) && $0.waitTime < 20 }.sorted(by: <)

print(sortedRidesOfInterest)

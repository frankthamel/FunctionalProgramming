//: Playground - noun: a place where people can play

import UIKit

enum RideCategory : String {
    case family
    case kids
    case thrill
    case scary
    case relaxing
    case water
}

typealias Minutes = Double

struct Ride {
    let name : String
    let categories : Set<RideCategory>
    let waitTime : Minutes
}


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

var parkRides : [Ride] = []
    parkRides.append(Ride(name: "Raging Rapids", categories: [.family, .thrill, .water], waitTime: 45.0))
    parkRides.append(Ride(name: "Crazy Funhouse", categories: [.family], waitTime: 10.0))
    parkRides.append(Ride(name: "Spinning Tea Cups", categories: [.kids], waitTime: 15.0))
    parkRides.append(Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0))
    parkRides.append(Ride(name: "Thunder Coaster", categories: [.family, .thrill], waitTime: 60.0))
    parkRides.append(Ride(name: "Grand Carousel", categories: [.family, .kids], waitTime: 15.0))
    parkRides.append(Ride(name: "Bumper Boats", categories: [.family, .water], waitTime: 25.0))
    parkRides.append(Ride(name: "Mountain Railroad", categories: [.family, .relaxing], waitTime: 0.0))


func sortedNames(of rides: [Ride]) -> [String] {
    var sortedRides = rides
    var key: Ride
    
    // 1
    for i in (0..<sortedRides.count) {
        key = sortedRides[i]
        
        // 2
        for j in stride(from: i, to: -1, by: -1) {
            if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
                sortedRides.remove(at: j + 1)
                sortedRides.insert(key, at: j)
            }
        }
    }
    
    
    // 3
    var sortedNames = [String]()
    for ride in sortedRides {
        sortedNames.append(ride.name)
    }
    
    return sortedNames
}

sortedNames(of: parkRides)

/////////// filter : passing function as a variable
func waitTimeIsShort(ride: Ride) -> Bool {
    return ride.waitTime <= 15.0
}

var shortWaitTimeRides = parkRides.filter(waitTimeIsShort)



////////// filter : set function as a traling closure

shortWaitTimeRides = parkRides.filter { $0.waitTime < 30.0 }
print(shortWaitTimeRides)




// map
let rideNames = parkRides.map{$0.name}.sorted(by: <)
print(rideNames)


// reduce
let totalWaitTime = parkRides.reduce(0.0){ (total , ride) in
    total + ride.waitTime
}
print(totalWaitTime)


// parcial functions
func filter(for category: RideCategory) -> ([Ride]) -> [Ride] {
    return { (rides: [Ride]) in
        rides.filter { $0.categories.contains(category) }
    }
}
let kidRideFilter = filter(for: .kids)
print(kidRideFilter(parkRides))

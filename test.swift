

import Foundation

protocol Ordered { 
    func precedes(other: Self) -> Bool
}

// func binarySearch<T: Ordered>(sortedKeys: [T], forKey: T) -> Int { 
//     return 0
// }

// // extension Ordered where Self: Comparable {
// //     func precedes(other: Self) -> Bool { return self < other }
// // }

// extension Comparable {
//     func precedes(other: Self) -> Bool { return self < other }
// }

// extension Int: Ordered {}
// let test = Double(3.14).precedes(other: Double(9.7))


// let position = binarySearch(sortedKeys: [1, 2, 3], forKey: 2)


// func binarySearch<C: CollectionType where >() {

// }
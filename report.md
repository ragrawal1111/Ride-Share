Assignment 5: Developing a Class-Based Ride Sharing System
Rajiv Agrawal
Advanced Programming Languages (MSCS-632-A01)
Jay Thom
February 15, 2026

Introduction
This assignment implements a class-based ride sharing system in C++ and GNU Smalltalk to demonstrate three core object-oriented programming (OOP) principles: encapsulation, inheritance, and polymorphism. The system models rides, drivers, and riders, and it executes a small demo to show how these objects collaborate. The C++ and Smalltalk versions follow the same domain design so the differences are primarily in language features and syntax.

Encapsulation
Encapsulation is used to keep internal state private and provide controlled access through methods. In C++, the `Ride` class stores `rideId_`, `pickup_`, `dropoff_`, and `distanceMiles_` as private data members, and exposes read-only access using getter methods such as `getRideId()` and `getDistanceMiles()`. The `Driver` and `Rider` classes keep their collections of rides (`assignedRides_` and `requestedRides_`) private, and the only way to modify those collections is through methods such as `addRide()` and `requestRide()`. This prevents external code from directly mutating the collections and enforces consistent behavior.

In GNU Smalltalk, instance variables are private by default, which naturally enforces encapsulation. The `Driver` class maintains `assignedRides` and the `Rider` class maintains `requestedRides` as internal collections. The collections are only modified by the public methods `addRide:` and `requestRide:`. The `Ride` class stores its core fields and provides a `printRideDetails` method so other objects do not need direct access to the instance variables.

Inheritance
Inheritance organizes shared behavior into the base `Ride` class and specialized behavior in subclasses. In C++, `StandardRide` and `PremiumRide` inherit from `Ride` and reuse the base fields and the `rideDetails()` template while overriding the `fare()` method. The base class is declared abstract by making `fare()` a pure virtual function (`virtual double fare() const = 0`), which ensures every concrete ride subclass must define its own pricing rules.

In GNU Smalltalk, `StandardRide` and `PremiumRide` subclass `Ride` and override the `fare` method. The base `Ride` class provides initialization and output behavior while declaring `fare` as a `subclassResponsibility`, forcing subclasses to implement the pricing logic. This keeps shared features in one place and reduces code duplication.

Polymorphism
Polymorphism is demonstrated by storing different ride types in a single collection and calling the same method on each element. In C++, a `std::vector<std::shared_ptr<Ride>>` contains both `StandardRide` and `PremiumRide` objects. The program loops through the vector and calls `rideDetails()`, which in turn calls the overridden `fare()` method appropriate for each ride type. This produces different fare calculations without changing the calling code.

In GNU Smalltalk, an array containing a `StandardRide` and a `PremiumRide` is iterated with `do:`. Each ride responds to the same `printRideDetails` message, and the runtime dispatches to the correct `fare` implementation. This shows how dynamic dispatch allows different objects to share the same interface while executing specialized behavior.

Conclusion
Both implementations demonstrate encapsulation, inheritance, and polymorphism using the same ride sharing domain. C++ enforces encapsulation through access specifiers (`private`, `public`) and uses virtual methods for polymorphism. GNU Smalltalk enforces encapsulation through private instance variables and relies on message dispatch for polymorphism. The resulting systems are structurally similar and provide consistent output, while highlighting how each language expresses the same OOP concepts.

References
Stroustrup, B. (2013). The C++ programming language (4th ed.). Addison-Wesley.
Goldberg, A., & Robson, D. (1989). Smalltalk-80: The language. Addison-Wesley.

GitHub Link
https://github.com/your-username/your-repo

---

Sample Output — C++

```
--- Ride Details (Polymorphic Calls) ---
Ride Type: Standard
Ride ID: 101
Pickup: Campus Library
Dropoff: Downtown Plaza
Distance: 4.20 miles
Fare: $7.75

Ride Type: Premium
Ride ID: 202
Pickup: Tech Park
Dropoff: Airport Terminal
Distance: 12.80 miles
Fare: $33.80


--- Driver Info ---
Driver ID: 11
Name: Jordan Lee
Rating: 4.9
Assigned rides: 2


--- Driver Ride History ---

Ride Type: Standard
Ride ID: 101
Pickup: Campus Library
Dropoff: Downtown Plaza
Distance: 4.20 miles
Fare: $7.75

Ride Type: Premium
Ride ID: 202
Pickup: Tech Park
Dropoff: Airport Terminal
Distance: 12.80 miles
Fare: $33.80


--- Rider Ride History ---
Rider ID: 501
Name: Avery Patel

Ride Type: Standard
Ride ID: 101
Pickup: Campus Library
Dropoff: Downtown Plaza
Distance: 4.20 miles
Fare: $7.75
```

Sample Output — GNU Smalltalk

```
--- Ride Details (Polymorphic Calls) ---
Ride Type: Standard
Ride ID: 101
Pickup: Campus Library
Dropoff: Downtown Plaza
Distance: 4.20 miles
Fare: $7.75

Ride Type: Premium
Ride ID: 202
Pickup: Tech Park
Dropoff: Airport Terminal
Distance: 12.80 miles
Fare: $33.80

--- Driver Info ---
Driver ID: 11
Name: Jordan Lee
Rating: 4.9
Assigned rides: 2

--- Driver Ride History ---
Ride Type: Standard
Ride ID: 101
Pickup: Campus Library
Dropoff: Downtown Plaza
Distance: 4.20 miles
Fare: $7.75

Ride Type: Premium
Ride ID: 202
Pickup: Tech Park
Dropoff: Airport Terminal
Distance: 12.80 miles
Fare: $33.80

--- Rider Ride History ---
Rider ID: 501
Name: Avery Patel

Ride Type: Standard
Ride ID: 101
Pickup: Campus Library
Dropoff: Downtown Plaza
Distance: 4.20 miles
Fare: $7.75
```

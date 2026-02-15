"====================================================================
 Ride Sharing System — GNU Smalltalk implementation
 Demonstrates: Encapsulation, Inheritance, Polymorphism
======================================================================"

"----------- Base Ride class (abstract) -----------"
Object subclass: Ride [
    | rideId pickup dropoff distanceMiles |

    Ride class >> withId: anId pickup: pickupLocation dropoff: dropoffLocation distance: miles [
        ^ self new
            initializeWithId: anId
            pickup: pickupLocation
            dropoff: dropoffLocation
            distance: miles
    ]

    initializeWithId: anId pickup: pickupLocation dropoff: dropoffLocation distance: miles [
        rideId := anId.
        pickup := pickupLocation.
        dropoff := dropoffLocation.
        distanceMiles := miles.
    ]

    rideTypeName [
        ^ 'Ride'
    ]

    fare [
        self subclassResponsibility
    ]

    "Helper to format a decimal number as a string with 2 decimal places."
    formatNumber: aNumber [
        | intPart fracPart fracStr |
        intPart := aNumber truncated.
        fracPart := ((aNumber - intPart) abs * 100) rounded.
        fracPart >= 100 ifTrue: [
            intPart := intPart + 1.
            fracPart := 0.
        ].
        fracStr := fracPart printString.
        fracPart < 10 ifTrue: [ fracStr := '0', fracStr ].
        ^ intPart printString, '.', fracStr
    ]

    printRideDetails [
        | out |
        out := FileStream stdout.
        out nextPutAll: 'Ride Type: '; nextPutAll: self rideTypeName; nl.
        out nextPutAll: 'Ride ID: '; nextPutAll: rideId printString; nl.
        out nextPutAll: 'Pickup: '; nextPutAll: pickup; nl.
        out nextPutAll: 'Dropoff: '; nextPutAll: dropoff; nl.
        out nextPutAll: 'Distance: '; nextPutAll: (self formatNumber: distanceMiles); nextPutAll: ' miles'; nl.
        out nextPutAll: 'Fare: $'; nextPutAll: (self formatNumber: self fare); nl.
    ]
]

"----------- StandardRide subclass -----------"
Ride subclass: StandardRide [
    rideTypeName [
        ^ 'Standard'
    ]

    fare [
        | baseFare perMile |
        baseFare := 2.50.
        perMile := 1.25.
        ^ baseFare + (perMile * distanceMiles)
    ]
]

"----------- PremiumRide subclass -----------"
Ride subclass: PremiumRide [
    rideTypeName [
        ^ 'Premium'
    ]

    fare [
        | baseFare perMile |
        baseFare := 5.00.
        perMile := 2.25.
        ^ baseFare + (perMile * distanceMiles)
    ]
]

"----------- Driver class (encapsulation: assignedRides is private) -----------"
Object subclass: Driver [
    | driverId name rating assignedRides |

    Driver class >> withId: anId name: driverName rating: aRating [
        ^ self new
            initializeWithId: anId
            name: driverName
            rating: aRating
    ]

    initializeWithId: anId name: driverName rating: aRating [
        driverId := anId.
        name := driverName.
        rating := aRating.
        assignedRides := OrderedCollection new.
    ]

    addRide: aRide [
        assignedRides add: aRide.
    ]

    "Helper to format rating with 1 decimal place."
    formatRating [
        | intPart fracPart |
        intPart := rating truncated.
        fracPart := ((rating - intPart) abs * 10) rounded.
        fracPart >= 10 ifTrue: [
            intPart := intPart + 1.
            fracPart := 0.
        ].
        ^ intPart printString, '.', fracPart printString
    ]

    printDriverInfo [
        | out |
        out := FileStream stdout.
        out nextPutAll: 'Driver ID: '; nextPutAll: driverId printString; nl.
        out nextPutAll: 'Name: '; nextPutAll: name; nl.
        out nextPutAll: 'Rating: '; nextPutAll: self formatRating; nl.
        out nextPutAll: 'Assigned rides: '; nextPutAll: assignedRides size printString; nl.
    ]

    printRideHistory [
        | out |
        out := FileStream stdout.
        assignedRides isEmpty
            ifTrue: [ out nextPutAll: 'No rides assigned.'; nl ]
            ifFalse: [
                assignedRides do: [:ride |
                    ride printRideDetails.
                    out nl ] ].
    ]
]

"----------- Rider class -----------"
Object subclass: Rider [
    | riderId name requestedRides |

    Rider class >> withId: anId name: riderName [
        ^ self new
            initializeWithId: anId
            name: riderName
    ]

    initializeWithId: anId name: riderName [
        riderId := anId.
        name := riderName.
        requestedRides := OrderedCollection new.
    ]

    requestRide: aRide [
        requestedRides add: aRide.
    ]

    viewRides [
        | out |
        out := FileStream stdout.
        out nextPutAll: 'Rider ID: '; nextPutAll: riderId printString; nl.
        out nextPutAll: 'Name: '; nextPutAll: name; nl.
        requestedRides isEmpty
            ifTrue: [ out nextPutAll: 'No rides requested.'; nl ]
            ifFalse: [
                requestedRides do: [:ride |
                    out nl.
                    ride printRideDetails ] ].
    ]
]

"----------- Demo runner -----------"
Object subclass: RideSharingDemo [
    RideSharingDemo class >> run [
        | ride1 ride2 rides driver rider out |
        out := FileStream stdout.

        ride1 := StandardRide withId: 101 pickup: 'Campus Library' dropoff: 'Downtown Plaza' distance: 4.2.
        ride2 := PremiumRide withId: 202 pickup: 'Tech Park' dropoff: 'Airport Terminal' distance: 12.8.

        rides := { ride1. ride2 }.

        out nextPutAll: '--- Ride Details (Polymorphic Calls) ---'; nl.
        rides do: [:ride |
            ride printRideDetails.
            out nl.
        ].

        driver := Driver withId: 11 name: 'Jordan Lee' rating: 4.9.
        driver addRide: ride1.
        driver addRide: ride2.

        out nextPutAll: '--- Driver Info ---'; nl.
        driver printDriverInfo.
        out nl.

        out nextPutAll: '--- Driver Ride History ---'; nl.
        driver printRideHistory.

        rider := Rider withId: 501 name: 'Avery Patel'.
        rider requestRide: ride1.

        out nextPutAll: '--- Rider Ride History ---'; nl.
        rider viewRides.
    ]
]

"Auto-run the demo"
RideSharingDemo run.

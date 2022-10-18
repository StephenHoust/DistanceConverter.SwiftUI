//
//  Enums.swift
//  DistanceConversion
//
//  Created by Stephen Houst on 10/18/22.
//

enum measurementSystem: String, CaseIterable, Identifiable {
    case imperial   = "Imperial (US)"
    case metric     = "Metric (World)"
    
    var id: measurementSystem { self }
}

enum distanceUnits: String, CaseIterable, Identifiable {
    case inches
    case feet
    case yards
    case miles
    case millimeters
    case centimeters
    case meters
    case kilometers
    
    var id: distanceUnits { self }
    static let metric: [distanceUnits] = [.millimeters, .centimeters, .meters, .kilometers]
    static let imperial: [distanceUnits] = [.inches, .feet, .yards, .miles]
}

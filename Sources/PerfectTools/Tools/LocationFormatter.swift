//
//  LocationFormatter.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

public final class LocationFormatter: NSObject {
    public static func format(_ distance: String?, with distanceUnit: String?) -> String? {
        if let unit = distanceUnit, let distance = distance {
            return distance + " " + unit
        }
        return nil
    }
}

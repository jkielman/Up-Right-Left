//
//  CLLocationHelpers.swift
//  
//
//  Created by Jeff Kielman on 2016-06-03.
//
//

import CoreLocation

private func degreesToRadians(degrees: Double) -> Double {
    return degrees * M_PI / 180.0
}

private func radiansToDegrees(radians: Double) -> Double {
    return radians * 180.0 / M_PI
}

extension CLLocation {
    
    func minimumDistanceToLocation(location: CLLocation, withRadius radius: CLLocationDistance) -> CLLocationDistance {
        let distance = self.distanceFromLocation(location)
        return max(distance - radius, 0.0)
    }
    
    // From http://stackoverflow.com/questions/3925942/cllocation-category-for-calculating-bearing-w-haversine-function
    func bearingToLocation(destLocation: CLLocation) -> CLLocationDirection {
        let lat1 = degreesToRadians(self.coordinate.latitude)
        let lon1 = degreesToRadians(self.coordinate.longitude)
        
        let lat2 = degreesToRadians(destLocation.coordinate.latitude)
        let lon2 = degreesToRadians(destLocation.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        
        var radiansBearing = atan2(y, x)
        
        if radiansBearing < 0.0 {
            radiansBearing += 2.0 * M_PI
        }
        
        return radiansToDegrees(radiansBearing)
    }
    
}




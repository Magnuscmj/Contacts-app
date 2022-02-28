//
//  CustomAnnotation.swift
//  Contact-app
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coor: CLLocationCoordinate2D)
    {
        coordinate = coor
    }
}

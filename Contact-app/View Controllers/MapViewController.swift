//
//  MapViewController.swift
//  Contact-app
//
import UIKit
import MapKit
import Contacts

class MapViewController: UIViewController {
    
    var contactStruct: ContactStruct!
    var showAddress = ""

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(showAddress)
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(showAddress) { [weak self] placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)
                
                if var region = self?.mapView.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta /= 30.0
                    region.span.latitudeDelta /= 30.0
                    self?.mapView.setRegion(region, animated: true)
                    self?.mapView.addAnnotation(mark)
                }
            }
        }
    }
}



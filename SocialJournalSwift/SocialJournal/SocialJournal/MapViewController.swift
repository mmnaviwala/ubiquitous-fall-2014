//
//  MapViewController.swift
//  SocialJournal
//
//  Created by Matt Phillips on 11/20/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        var location = CLLocationCoordinate2D(latitude: 16.40, longitude: -86.34)
            
        var span = MKCoordinateSpanMake(0.5, 0.5)
        var region = MKCoordinateRegion(center: location, span: span)
            
        self.mapView.setRegion(region, animated: true)
            
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Roatan"
        annotation.subtitle = "Honduras"
            
        self.mapView.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
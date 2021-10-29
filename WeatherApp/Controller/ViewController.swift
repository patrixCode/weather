//
//  ViewController.swift
//  WeatherApp
//
//  Created by Patrik Seben on 20/07/2021.
//
import CoreLocation
import MapKit
import UIKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
        
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        let region = MKCoordinateRegion(center: coordinate, span:span)
        
       
        mapView.setRegion(region, animated: true)
    }

    @IBAction func LocationPressed(_ sender: UIButton) {
       
        manager.startUpdatingLocation()
        
        
    }
}




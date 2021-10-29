//
//  SearchController.swift
//  WeatherApp
//
//  Created by Patrik Seben on 20/07/2021.
//


import UIKit
import CoreLocation

class SearchViewController: UIViewController {
   
    @IBOutlet weak var ConditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        
}

    
    @IBAction func MyPositionPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
}


extension SearchViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Search"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
    }
}

extension SearchViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.ConditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
    }
    func didFailWhitError(error: Error) {
        print(error)
        
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

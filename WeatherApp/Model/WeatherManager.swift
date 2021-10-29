//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Patrik Seben on 21/07/2021.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWhitError(error: Error)
    
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=62ee1cef6c7755b197fce09688ba3c2c&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(whit: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    performRequest(whit: urlString)
    }
    
    func performRequest(whit urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWhitError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            
            task.resume()            }

}
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            
        } catch {
            delegate?.didFailWhitError(error: error)
            return nil
        }
}
    
    }


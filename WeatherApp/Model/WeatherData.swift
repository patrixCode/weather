//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Patrik Seben on 21/07/2021.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    
}

struct Weather: Codable {
    let description: String
    let id: Int
}

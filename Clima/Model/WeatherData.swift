//
//  WeatherData.swift
//  Clima
//
//  Created by Goldmedal on 30/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//  Completed by Abhang Mane @ Goldmedal

import Foundation

struct WeatherData: Codable{
    let name:String
    let main:Main
    let weather: [Weather]
    
    struct Main: Codable{
        let temp:Double
    }
    
    struct Weather:Codable{
        let id: Int
    }
}

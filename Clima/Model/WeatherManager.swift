//
//  WeatherManager.swift
//  Clima
//
//  Created by Goldmedal on 30/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//  Completed by Abhang Mane @ Goldmedal

import Foundation
import CoreLocation


//protocol for delegate
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weathermanager: WeatherManager,weather: WeatherModel)
    func didFailError(error: Error)
}


//structure for weathermanager which manages api url,session,request-response and JSON parsing
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=93b3c323bfe5bd91a09625d8f963e173&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    //fetch weather for this city name
    func fetchWeather(cityName:String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    //fetch weather for particular lattitude and longitude and delegate it to weather view contoller for displaying
    func fetchWeather(lattitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lattitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    //(with) here increases code readability
    func performRequest(with urlString:String){
        //1.Create URL
        if let url = URL(string: urlString){
            //2.Create URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            let task = session.dataTask(with: url) {(data,response,error) in
                if error != nil{
                    self.delegate?.didFailError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4.Start the task
            //resume because newly-initialized tasks begin in a suspended state, so we need to call this method to start the task.
            task.resume()
        }
    }
    
    
    //Function to parse the JSON fetched form the apiurl and decode returning the weather
    func parseJSON(_ weatherData:Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self,from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch{
            self.delegate?.didFailError(error: error)
            return nil
        }
        
    }
}

//
//  Api.swift
//  Contatos
//
//  Created by ios7649 on 06/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias ClimaResponse = (Clima?, URL?, Error?) -> Void

class Api {
    
    let BASE_API_URL = "http://api.openweathermap.org/data/2.5/weather"
    let BASE_IMG_URL = "http://openweathermap.org/img/w/"
    
    func getWeather(by contato: Contato, response: @escaping ClimaResponse){
        
        let param = [
            "lat": contato.latitude.description ,
            "lon": contato.longitude.description,
            "appid": "c8f3676014772da21be48d656373ae1c",
            "units": "metric"
        ]
        
        Alamofire.request(BASE_API_URL, parameters: param)
            .responseObject { (result: DataResponse<Clima>) in
                
                guard let clima = result.value else{
                    response(nil, nil, result.error)
                    return
                }
                
                let url = URL( string: self.BASE_IMG_URL + clima.weather[0].icon + ".png")
                    
                
                response(clima, url, nil);
        }
        
    }
    
    
}

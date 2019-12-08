//
//  apiKonfio.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import Foundation

public class apiKonfio{
    
    static let shared = apiKonfio(url: "https://api.myjson.com/bins/kp2e8")
    let session = URLSession.shared
    var url : String?
    
    init(url:String) {
        self.url = url
    }
    
    enum typeRequest: String
    {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func downloadData(completion: @escaping ((Int,NSDictionary) -> Void))
    {
        guard let requestUrl = URL(string:url!) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = typeRequest.get.rawValue
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if error == nil{
                    do{
                        let str = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:Any]]
                        let info = [
                            "data" : str
                        ] as NSDictionary
                        completion(httpResponse.statusCode,info)
                    }
                    catch {
                        completion(httpResponse.statusCode,["message":"Incorrect data format. 😿"])
                    }
                } else {
                    completion(httpResponse.statusCode,["message":"Data is unavailable"])
                }
            }else {
                completion(500,["message":"Server misses. 😿"])
            }
        }
        task.resume()
    }
    
    func cleanDogs(data : [[String:Any]],completion: @escaping (([dog]) -> Void))
    {
        var dogs = [dog]()
        for puppy in data
        {
            let jsonData = puppy.json.data(using: .utf8)!
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let uniqueDog = try! decoder.decode(dog.self, from: jsonData)
            dogs.append(uniqueDog)
        }
        completion(dogs)
    }
}

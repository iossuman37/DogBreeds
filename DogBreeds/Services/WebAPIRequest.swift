//
//  WebAPIRequest.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import Foundation

let session = URLSession(configuration: .default)

enum APIResponseError: Error {
  case invalidResponse
  case failedRequest
  case invalidData
  case success
}
//API Requests
class WebAPIRequest {
    private static var currentDataTask : URLSessionDataTask?
    
    private static let host = "dog.ceo"
    private static let listPath = "/api/breeds/list/all"
    private static let breedImagePath = "/api/breed/%BREED%/images"
    
    //MARK:- Fetch Breeds For search
    static func fetchBreedList<T:Decodable>(completion: @escaping (T?, APIResponseError) -> ()) {
        
        session.configuration.timeoutIntervalForResource = 180.0
        session.configuration.timeoutIntervalForRequest = 180.0
        session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        //URL Builder to fetch
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = listPath
        
        
        let url = urlBuilder.url!
        WebAPIRequest.fetchData(url: url, completion: completion)
    }
    
    //Fetch Data using URLSession
    static func fetchData<T:Decodable>(url : URL,completion : @escaping (T?, APIResponseError) -> ()) {
        
        currentDataTask =  session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else{
                completion(nil,.failedRequest)
                return
            }
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let data = data
            else {
                completion(nil,.invalidResponse)
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                completion(nil,.invalidData)
                return
            }
           
            completion(decodedResponse,.success)
        })
        currentDataTask?.resume()
    }
   
   
    //MARK:- Fetch Details For Breed
    static func fetchBreedDetails<T:Decodable>(breedName : String,completion: @escaping (T?, APIResponseError) -> ()) {
        
        session.configuration.timeoutIntervalForResource = 180.0
        session.configuration.timeoutIntervalForRequest = 180.0
        session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        //URL Builder to fetch 
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = breedImagePath.replacingOccurrences(of: "%BREED%", with: breedName)
        
        
        let url = urlBuilder.url!
        WebAPIRequest.fetchData(url: url, completion: completion)
    }
    //Cancel Current Task
    static func cancelCurrentTask(){
        currentDataTask?.cancel()
    }
    
}

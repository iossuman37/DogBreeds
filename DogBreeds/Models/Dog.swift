//
//  Dog.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import Foundation

//MARK:- Dog Model
struct DogList : Decodable {
    let breeds : [String : [String]]
    
    enum CodingKeys : String, CodingKey {
        case breeds = "message"
    }
}

struct BreedImageLinks : Decodable {
    let imageLinks : [String]
    
    enum CodingKeys : String, CodingKey {
        case imageLinks = "message"
    }
}

//
//  BreedViewModel.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import Foundation

protocol DataRequestModelDelegate: class {
  func onFetchCompleted()
  func onFetchFailed(with reason: String)
}

//MARK:- ViewModel
final class BreedViewModel {
    
    private var isFetching = false
    private var breeds : [String] = []
    private var dogBreeds : [String : [String]] = [:]
    private weak var delegate: DataRequestModelDelegate?

    init(delegate : DataRequestModelDelegate?) {
        self.delegate = delegate
    }
    
    var breedsCount: Int {
        return breeds.count
    }
    //Return breed at index
    func breed(at index : Int) -> String{
        return breeds[index]
    }
    
    //Get subBreedsList for Breed
    func subBreedsForBreed(breed : String) -> [String] {
        return self.dogBreeds[breed] ?? []
    }
    //Fetch Breeds 
    func fetchBreedsList() {
        guard !isFetching else {
            return
        }
        isFetching = true
       
        WebAPIRequest.fetchBreedList(completion: { (dogList : DogList?, errorMssg) in
            
            DispatchQueue.main.async {
                self.isFetching = false
                
                if errorMssg != .success {
                    print("error received",errorMssg )
                    self.delegate?.onFetchFailed(with: "Error in receiving data")
                }
                else if let breedsFetched = dogList{
                    self.breeds.append(contentsOf: breedsFetched.breeds.keys.sorted())
                    self.dogBreeds = breedsFetched.breeds
                    self.delegate?.onFetchCompleted()
                }
            }
            
        })
    }
    //Cancel Fetch Operation
    func cancelFetch(){
        WebAPIRequest.cancelCurrentTask()
        isFetching = false
    }
    
}


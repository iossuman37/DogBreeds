//
//  BreedDetailsViewModel.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import Foundation

final class BreedDetailsViewModel {
    private var breedName : String?
    let subBreeds = Box([])
    var isFetching = false
    
    func setSelectedBreed(breed : String) {
        self.breedName = breed
    }
    
    func selectedBreed() -> String {
        return self.breedName ?? ""
    }
    func getCountOfSubBreeds() -> Int {
        return subBreeds.value.count
    }
    
    func breedDetail(at index : Int) -> (String, String)? {
        if let detail = subBreeds.value[index] as? String, let url = URL(string: detail)  {
            let pathComponents = url.pathComponents
            let breedName = (pathComponents[pathComponents.count - 2].components(separatedBy: "-")).last!
            return (breedName, detail)
        }
        return nil
    }
    func fetchBreedDetails(){
        if let breedName = self.breedName {
            isFetching = true
            WebAPIRequest.fetchBreedDetails(breedName: breedName, completion: { (breedDetails : BreedImageLinks?, errorMssg) in
                
                
                if errorMssg != .success {
                    print("error received",errorMssg )
                    self.subBreeds.value = []
                }
                else if let details = breedDetails{
                    self.subBreeds.value = details.imageLinks
                }
                self.isFetching = false
            })
        }
    }
}

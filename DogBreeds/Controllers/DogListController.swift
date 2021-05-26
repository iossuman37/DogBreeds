//
//  DogListController.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import UIKit

class DogListController: UIViewController {
    
    private var breedViewModel : BreedViewModel!

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var breedsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    let errorMessage = "Error Occured while fetching. Please try later"
    let detailsSegue = "BreedDetails"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dog Breeds"
        breedViewModel = BreedViewModel.init(delegate: self)
        breedViewModel.fetchBreedsList()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let detailsVC = segue.destination as? BreedImagesController {
            if let indexPath  = sender as? IndexPath {
                detailsVC.breedDetailsViewModel.setSelectedBreed(breed: breedViewModel.breed(at: indexPath.row))
            }
        }
        
    }

}

extension DogListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedViewModel.breedsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BreedCell")
        }
        let breed = breedViewModel.breed(at: indexPath.row)
        cell?.textLabel?.text = breed.capitalized
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.text = breedViewModel.subBreedsForBreed(breed: breed).joined(separator: ",").capitalized
        cell?.accessoryType = .disclosureIndicator
        
        return cell ?? UITableViewCell()
    }
    
    
}

extension DogListController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: detailsSegue, sender: indexPath)
    }
}

extension DogListController : DataRequestModelDelegate {
    func onFetchCompleted() {
        self.loadingIndicator.stopAnimating()
        self.messageLbl.isHidden = true
        self.breedsTableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        self.loadingIndicator.stopAnimating()
        self.messageLbl.text = errorMessage
        self.messageLbl.isHidden = false
        self.breedsTableView.reloadData()
    }
}

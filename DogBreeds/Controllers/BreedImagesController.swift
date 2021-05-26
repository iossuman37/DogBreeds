//
//  BreedImagesController.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import UIKit

class BreedImagesController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var breedImagesCollection: UICollectionView!
    @IBOutlet weak var messageLbl: UILabel!
    
    public var breedDetailsViewModel = BreedDetailsViewModel()
    private let reusableIdentifier = "breedDetailCell"

    let errorMessage = "No Details found for the breed"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.breedDetailsViewModel.selectedBreed().capitalized
        
        
        breedDetailsViewModel.fetchBreedDetails()
        breedDetailsViewModel.subBreeds.bind { [weak self] breeds in
            if breeds.count > 0 {
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    self?.breedImagesCollection.reloadData()
                }
            }
            else if !(self?.breedDetailsViewModel.isFetching)!{
                DispatchQueue.main.async {
                    self?.messageLbl.text = self?.errorMessage
                    self?.messageLbl.isHidden = false
                    self?.loadingIndicator.stopAnimating()
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - CollectionView DataSource
extension BreedImagesController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.breedDetailsViewModel.getCountOfSubBreeds()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! BreedImageCell
        
        if let breedDetails = self.breedDetailsViewModel.breedDetail(at: indexPath.row) {
            cell.breedImageView.loadImageFromUrlString(path: breedDetails.1)
            cell.breedName.text = breedDetails.0.capitalized
        }
        
        return cell
    }
    
}
// MARK: - CollectionView Layout
extension BreedImagesController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:(self.view.bounds.width-30)/2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
}


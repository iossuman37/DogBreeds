# DogBreeds
Implemented using MVVM design pattern. 
DogListController displays fetched Dog breeds. Controller gets data via BreedViewModel

BreedViewModel initiates API call. WepAPIRequest class invokes API, decodes received JSON data, notifies to viewModel with API response via completion handler.

BreedViewModel assigns data to it's property and notifies controller via Protocol delegate that data is fetched and data can be used to render tableView Cells with fetched breed names .

To get notification from ViewModel for the status of the fetch, controller would need to implement protocol "DataRequestModelDelegate"

Implemented Tableview with default tableView Cell since it's simple text of Breed name and subBreeds

On selection of tableview Cell, a new screen will be pushed to navigation controller with collectionview of breeds that are fetched for the chosen Breed

BreedImagesController implments CollectionView DataSource to render images and breed names

Extended UIImageView to download image from imageUrl of the Breed Image. Implemented ImageCache to cache dowloaded image for faster download and render image on UI. 

Used Box data binding to implement listener on subBreeds property. Once the data is fetched from API, listener notifies controller and renders breeds on UI with image and name.



import UIKit

func newAlbumsControllerFactory() -> (VinylDetails) -> UIViewController {
    return vinylCollectionControllerFactory(viewModelFactory: newAlbumsViewModelFactory)
}

func newAlbumsViewModelFactory(_ details: VinylDetails) -> VinylCollectionViewModel {
    return VinylCollectionViewModel(title: "New albums", vinyls: details.recommended)
}

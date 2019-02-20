import UIKit

func vinylCollectionControllerFactory(
        viewModelFactory: @escaping (VinylDetails) -> VinylCollectionViewModel)
        -> (VinylDetails) -> VinylCollectionControlling {
    return { details in
        VinylCollectionController(viewModel: viewModelFactory(details))
    }
}

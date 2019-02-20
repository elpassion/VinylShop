import UIKit

func vinylCollectionControllerFactory(
        viewModelFactory: @escaping (VinylDetails) -> VinylCollectionViewModel)
        -> (VinylDetails) -> UIViewController {
    return { details in
        VinylCollectionController(viewModel: viewModelFactory(details))
    }
}

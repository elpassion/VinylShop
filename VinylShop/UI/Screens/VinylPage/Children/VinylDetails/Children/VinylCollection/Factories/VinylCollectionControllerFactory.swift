import UIKit

func vinylCollectionControllerFactory<Model>(
        viewModelFactory: @escaping (Model) -> VinylCollectionViewModel)
        -> (Model) -> VinylCollectionControlling {
    return { details in
        VinylCollectionController(viewModel: viewModelFactory(details))
    }
}

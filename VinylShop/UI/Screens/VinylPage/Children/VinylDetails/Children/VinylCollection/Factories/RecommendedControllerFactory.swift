import UIKit

func recommendedControllerFactory() -> (VinylDetails) -> VinylCollectionControlling {
    return vinylCollectionControllerFactory(viewModelFactory: recommendedViewModelFactory)
}

func recommendedViewModelFactory(_ details: VinylDetails) -> VinylCollectionViewModel {
    return VinylCollectionViewModel(title: "Recommended for you", vinyls: details.recommended)
}

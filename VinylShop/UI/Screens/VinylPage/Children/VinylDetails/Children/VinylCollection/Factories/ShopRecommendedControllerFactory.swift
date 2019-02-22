import UIKit

func shopRecommendedControllerFactory() -> (ShopDetails) -> VinylCollectionControlling {
    return vinylCollectionControllerFactory(viewModelFactory: shopRecommendedViewModelFactory)
}

func shopRecommendedViewModelFactory(_ details: ShopDetails) -> VinylCollectionViewModel {
    let ids = Set(details.recommendedIDs)
    let vinyls = details.vinyls.filter { ids.contains($0.id) }

    return VinylCollectionViewModel(title: "Recommended for you", vinyls: vinyls)
}

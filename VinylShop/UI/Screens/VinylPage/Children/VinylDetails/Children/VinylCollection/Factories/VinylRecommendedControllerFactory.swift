import UIKit

func vinylRecommendedControllerFactory() -> (Vinyl) -> VinylCollectionControlling {
    return vinylCollectionControllerFactory(viewModelFactory: vinylRecommendedViewModelFactory)
}

func vinylRecommendedViewModelFactory(_ vinyl: Vinyl) -> VinylCollectionViewModel {
    let repository = RecommendedVinylsRepository()
    let vinyls = repository.recommendedVinyls(forVinylWithID: vinyl.id)

    return VinylCollectionViewModel(title: "Recommended for you", vinyls: vinyls)
}

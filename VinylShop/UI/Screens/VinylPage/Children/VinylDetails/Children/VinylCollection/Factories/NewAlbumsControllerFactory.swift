import UIKit

func newAlbumsControllerFactory() -> (ShopDetails) -> VinylCollectionControlling {
    return vinylCollectionControllerFactory(viewModelFactory: newAlbumsViewModelFactory)
}

func newAlbumsViewModelFactory(_ details: ShopDetails) -> VinylCollectionViewModel {
    let ids = Set(details.newIDs)
    let vinyls = details.vinyls.filter { ids.contains($0.id )}

    return VinylCollectionViewModel(title: "New albums", vinyls: vinyls)
}

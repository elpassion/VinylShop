import UIKit

func makeMainTabs(with environment: Environment) -> [Tab] {
    return [home, search, shop(environment), collection, profile]
}

private var home: Tab {
    return Tab(controller: UIViewController(), title: "Home", isEnabled: false, initialState: .unselected)
}

private var search: Tab {
    return Tab(controller: UIViewController(), title: "Search", isEnabled: false, initialState: .unselected)
}

private var shop: (Environment) -> Tab {
    return { environment in
        Tab(controller: environment.navigationController, title: "Shop", isEnabled: true, initialState: .selected)
    }
}

private var collection: Tab {
    return Tab(controller: UIViewController(), title: "Collection", isEnabled: false, initialState: .unselected)
}

private var profile: Tab {
    return Tab(controller: UIViewController(), title: "Profile", isEnabled: false, initialState: .unselected)
}

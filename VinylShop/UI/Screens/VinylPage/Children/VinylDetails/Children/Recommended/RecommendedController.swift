import UIKit

class RecommendedController: UIViewController, UICollectionViewDataSource {

    init(vinyl: VinylDetails) {
        super.init(nibName: nil, bundle: nil)
    }

    var recommendedView: RecommendedView! {
        return view as? RecommendedView
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        view = RecommendedView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("collectionView(_:cellForItemAt:) has not been implemented")
    }

    // MARK: - Private

    private func setUpCollectionView() {
        recommendedView.collectionView.dataSource = self
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

import UIKit

class RecommendedController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    init(vinyl: VinylDetails, presenter: RecommendedPresenter = RecommendedPresenter()) {
        self.vinyl = vinyl
        self.presenter = presenter

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
        return vinyl.recommended.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.cell(
            for: indexPath,
            modeling: vinyl.recommended(at:),
            with: presenter.present(recommended:in:)
        )
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 114, height: 180)
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let presenter: RecommendedPresenter

    private func setUpCollectionView() {
        recommendedView.collectionView.dataSource = self
        recommendedView.collectionView.delegate = self
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

private extension VinylDetails {

    func recommended(at indexPath: IndexPath) -> RecommendedVinyl {
        return recommended[indexPath.row]
    }

}

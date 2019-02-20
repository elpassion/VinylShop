import UIKit

class GenresController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    init(vinyl: VinylDetails, presenter: GenrePresenter = GenrePresenter()) {
        self.vinyl = vinyl
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    var genresView: GenresView! {
        return view as? GenresView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = GenresView()
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
        return vinyl.genres.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.cell(
            for: indexPath,
            modeling: vinyl.genre(at:),
            with: presenter.present(genre:in:)
        )
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 110)
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let presenter: GenrePresenter

    private func setUpCollectionView() {
        genresView.collectionView.dataSource = self
        genresView.collectionView.delegate = self
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

extension VinylDetails {

    func genre(at indexPath: IndexPath) -> Genre {
        return genres[indexPath.row]
    }

}

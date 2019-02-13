import UIKit

class VinylDetailsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    init(vinyl: VinylDetails, presenter: VinylDetailsPresenter = VinylDetailsPresenter()) {
        self.vinyl = vinyl
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    var detailsView: VinylDetailsView! {
        return view as? VinylDetailsView
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        view = VinylDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrackList()
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vinyl.sides.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vinyl.sides[section].tracks.count + 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            return collectionView.cell(for: indexPath, modeling: vinyl.side(at:), with: presenter.present(side:in:))
        } else {
            return collectionView.cell(for: indexPath, modeling: vinyl.track(at:), with: presenter.present(track:in:))
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 54, height: 20)
        } else {
            return CGSize(width: 222, height: 50)
        }
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let presenter: VinylDetailsPresenter

    private func configureTrackList() {
        detailsView.trackListView.collectionView.dataSource = self
        detailsView.trackListView.collectionView.delegate = self
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

extension VinylDetails {

    func side(at indexPath: IndexPath) -> Side {
        return sides[indexPath.section]
    }

    func track(at indexPath: IndexPath) -> Track {
        return side(at: indexPath).tracks[indexPath.row - 1]
    }

}

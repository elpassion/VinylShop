import UIKit

class VinylTrackListController: UIViewController, UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout {

    init(vinyl: Vinyl, presenter: VinylDetailsPresenter = VinylDetailsPresenter()) {
        self.vinyl = vinyl
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    var trackListView: VinylTrackListView {
        return forceCast(view)
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = VinylTrackListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
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
            return CGSize(width: 222, height: 28)
        } else {
            return CGSize(width: 222, height: 50)
        }
    }

    // MARK: - Private

    private let vinyl: Vinyl
    private let presenter: VinylDetailsPresenter

    private func configureCollectionView() {
        trackListView.collectionView.dataSource = self
        trackListView.collectionView.delegate = self
        trackListView.collectionHeightConstraint?.constant = collectionHeight
    }

    private var collectionHeight: CGFloat {
        let sectionIndex = vinyl.longestSideIndex
        let tracks = vinyl.sides[sectionIndex].tracks.count

        return (0...tracks)
            .map { height(forItem: $0, inSection: sectionIndex) }
            .reduce(0, +)
    }

    private func height(forItem item: Int, inSection section: Int) -> CGFloat {
        let view = trackListView.collectionView
        let indexPath = IndexPath(item: item, section: section)
        let size = collectionView(view, layout: view.collectionViewLayout, sizeForItemAt: indexPath)
        return size.height
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

private extension Vinyl {

    func side(at indexPath: IndexPath) -> Side {
        return sides[indexPath.section]
    }

    func track(at indexPath: IndexPath) -> Track {
        return side(at: indexPath).tracks[indexPath.row - 1]
    }

    var longestSideIndex: Int {
        let index = sides
            .enumerated()
            .max { $0.element.tracks.count > $1.element.tracks.count }

        guard let longestSideIndex = index?.offset else {
            fatalError("Sides should never be empty")
        }

        return longestSideIndex
    }

}

import UIKit

class VinylDetailsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    init(sides: [Side]) {
        self.sides = sides
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
        return sides.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: VinylDetailsSideCell = collectionView.dequeue(cellFor: indexPath)
        cell.titleLabel.text = "Side \(sides[indexPath.section].name)"
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 54, height: 20)
    }

    // MARK: - Private

    private let sides: [Side]

    private func configureTrackList() {
        detailsView.trackListView.collectionView.dataSource = self
        detailsView.trackListView.collectionView.delegate = self
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

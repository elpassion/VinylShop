@testable import VinylShop
import Nimble
import Quick

class UICollectionView_DequeueSpec: QuickSpec {

    override func spec() {
        describe("UICollectionView+Dequeue") {
            var sut: UICollectionView!

            beforeEach {
                sut = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
                    |> register(VinylSideCell.self)
                    <> { $0.register(VinylSideCell.self, forCellWithReuseIdentifier: VinylTrackCell.reuseID) }
            }

            afterEach {
                sut = nil
            }

            describe("cell") {
                context("with registered cell") {
                    var cell: VinylSideCell!

                    beforeEach {
                        let modeling: (IndexPath) -> String = { indexPath in
                            indexPath.row == 1 ? "Hello" : "World"
                        }

                        let presenter: (String, VinylSideCell) -> Void = { model, cell in
                            cell.titleLabel.text = model
                        }

                        cell = sut.cell(for: IndexPath(row: 1, section: 1), modeling: modeling, with: presenter)
                    }

                    it("should dequeue it") {
                        expect(cell.titleLabel.text) == "Hello"
                    }
                }

                context("with misregistered cell") {
                    it("should crash") {
                        let modeling: (IndexPath) -> String = { _ in "" }
                        let presenter: (String, VinylTrackCell) -> Void = { _, _ in }

                        expect { _ = sut.cell(for: IndexPath(row: 0, section: 0), modeling: modeling, with: presenter) }.to(throwAssertion())
                    }
                }
            }
        }
    }

}

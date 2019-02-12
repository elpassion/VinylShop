import Anchorage
import UIKit

class VinylDetailsNotesView: UIView {

    private let titleLabel = UILabel(frame: .zero)
        |> font(.nunito(.extraBold), size: 12, color: .black000000)
        <> text("NOTES")

    private let notesLabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 14, color: .black000000)
        <> text(.notes, style: .notesStyle)
        <> multiline

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Configuration

    private func setUpSelf() {
        backgroundColor = Color.whiteFFFFFF.ui()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [titleLabel, notesLabel].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        titleLabel.topAnchor == topAnchor + 30
        titleLabel.leadingAnchor == leadingAnchor + 65

        notesLabel.topAnchor == titleLabel.bottomAnchor + 19
        notesLabel.leadingAnchor == titleLabel.leadingAnchor
        notesLabel.trailingAnchor == trailingAnchor - 38
        notesLabel.bottomAnchor == bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

private extension String {

    static var notes: String {
        return "Urban Outfitters & tour exclusive on translucent purple vinyl. " +
               "Comes with a double-sided insert. Limited to 1,000 copies."
    }

}

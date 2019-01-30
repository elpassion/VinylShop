class ShoppingBoxPresenter {

    func present(albums: [Album], in view: ShoppingBoxView) {
        let subviews: [ShoppingBoxItemView] = albums.enumerated().map { (index, album) in
            let view = ShoppingBoxItemView()
            view.titleLabel.text = album.title
            view.bandLabel.text = album.band
            view.separatorView.isHidden = index == albums.count - 1

            return view
        }

        view.itemsView.stackView.replaceSubviews(with: subviews)
    }

}

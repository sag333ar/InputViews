import UIKit

public class CollectionInputView: UIView {
	public static let cellIdentifier = "Cell"
	let collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.minimumLineSpacing = 5
		flowLayout.minimumInteritemSpacing = 5
		flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
		let collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = .white
		return collectionView
	}()

	var items: (() -> [Any]) = { return [] }
	var didSelect: ((Any) -> Void)?
	var text: ((Any) -> String) = { _ in return "" }
	var contains: ((Any) -> Bool) = {_ in return false }

	public override init(frame: CGRect) {
		super.init(frame: frame)
		make()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		make()
	}

	public override func didMoveToWindow() {
		super.didMoveToWindow()
		collectionView.frame = bounds
		collectionView.reloadData()
	}

	private func make() {
		collectionView.register(CollectionInputViewCell.self, forCellWithReuseIdentifier: CollectionInputView.cellIdentifier)
		addSubview(collectionView)
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.widthAnchor.constraint(equalTo: widthAnchor),
			collectionView.heightAnchor.constraint(equalTo: heightAnchor)
			])
		collectionView.dataSource = self
		collectionView.delegate = self
	}

	public static func create(
		items: @escaping (() -> [Any]) = { return [] },
		didSelect: ((Any) -> Void)? = nil,
		text: @escaping ((Any) -> String) = { _ in return "" },
		contains: @escaping ((Any) -> Bool) = {_ in return false }
		) -> CollectionInputView {
		let view = CollectionInputView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
		view.items = items
		view.didSelect = didSelect
		view.text = text
		view.contains = contains
		return view
	}

}

extension CollectionInputView: UICollectionViewDataSource, UICollectionViewDelegate {
	public func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int) -> Int {
		return items().count
	}

	public func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CollectionInputView.cellIdentifier,
			for: indexPath
		)
		if let kcvc = cell as? CollectionInputViewCell {
			kcvc.layoutIfNeeded()
			kcvc.titleLabel.text = text(items()[indexPath.row])
			if contains(items()[indexPath.row]) {
				kcvc.backgroundLabel.backgroundColor = kcvc.backgroundLabel.tintColor
			} else {
				kcvc.backgroundLabel.backgroundColor = .groupTableViewBackground
			}
			kcvc.backgroundLabel.layer.cornerRadius = (kcvc.backgroundLabel.frame.height / 2.0) - 2.0
		}
		return cell
	}

	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		didSelect?(items()[indexPath.row])
		collectionView.reloadData()
	}
}

extension CollectionInputView: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var size = (text(items()[indexPath.row]) as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
		size.width += 15
		size.height = 40
		return size
	}
}

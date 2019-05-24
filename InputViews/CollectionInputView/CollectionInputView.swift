import UIKit

public class CollectionInputView<T>: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  public let cellIdentifier = "Cell"
  let collectionView: UICollectionView = {
    var flowLayout: UICollectionViewFlowLayout {
      let flowLayout = UICollectionViewFlowLayout()
      flowLayout.minimumLineSpacing = 5
      flowLayout.minimumInteritemSpacing = 5
      flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
      return flowLayout
    }
    let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
    let collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
    collectionView.backgroundColor = .white
    return collectionView
  }()

  public var items: (() -> [T]) = { return [] }
  public var didSelect: ((T) -> Void)?
  public var text: ((T) -> String) = { _ in return "" }
  public var contains: ((T) -> Bool) = {_ in return false }
  public var font: UIFont = .systemFont(ofSize: 15)
  public var itemBackgroundColor: UIColor = .groupTableViewBackground
  public var selectionColor: UIColor = UIView().tintColor

  public required init(
    items: @escaping (() -> [T]) = { return [] },
    didSelect: ((T) -> Void)? = nil,
    text: @escaping ((T) -> String) = { _ in return "" },
    contains: @escaping ((T) -> Bool) = {_ in return false },
    font: UIFont = .systemFont(ofSize: 15),
    itemBackgroundColor: UIColor = .groupTableViewBackground,
    selectionColor: UIColor = UIView().tintColor,
    height: CGFloat
    ) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
    self.items = items
    self.didSelect = didSelect
    self.text = text
    self.contains = contains
    self.font = font
    self.itemBackgroundColor = itemBackgroundColor
    self.selectionColor = selectionColor
    translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(CollectionInputViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
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

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override public func didMoveToWindow() {
    super.didMoveToWindow()
    layoutIfNeeded()
    collectionView.frame = bounds
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.reloadData()
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return items().count
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellIdentifier,
      for: indexPath
    )
    if let kcvc = cell as? CollectionInputViewCell {
      kcvc.layoutIfNeeded()
      kcvc.titleLabel.text = text(items()[indexPath.row])
      kcvc.titleLabel.font = font
      if contains(items()[indexPath.row]) {
        kcvc.backgroundLabel.backgroundColor = selectionColor
      } else {
        kcvc.backgroundLabel.backgroundColor = itemBackgroundColor
      }
      kcvc.backgroundLabel.layer.cornerRadius = (kcvc.backgroundLabel.frame.height / 2.0) - 2.0
    }
    return cell
  }

  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    didSelect?(items()[indexPath.row])
    collectionView.reloadData()
  }

  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
    var size = (text(items()[indexPath.row]) as NSString)
      .size(withAttributes: [NSAttributedString.Key.font: font])
    size.width += 15
    size.height = 40
    return size
  }
}

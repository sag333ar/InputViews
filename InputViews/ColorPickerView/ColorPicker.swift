import UIKit

public class ColorPickerView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  public static let defaultHexColors = ["FFCDD2", "F8BBD0", "E1BEE7", "EF9A9A", "F48FB1", "CE93D8", "FF8A80", "FF80AB", "EA80FC", "D1C4E9", "C5CAE9", "BBDEFB", "B39DDB", "9FA8DA", "90CAF9", "B388FF", "8C9EFF", "82B1FF", "7C4DFF", "536DFE", "448AFF", "B3E5FC", "B2EBF2", "B2DFDB", "81D4FA", "80DEEA", "80CBC4", "80D8FF", "84FFFF", "A7FFEB", "40C4FF", "18FFFF", "64FFDA", "C8E6C9", "DCEDC8", "F0F4C3", "A5D6A7", "C5E1A5", "E6EE9C", "B9F6CA", "CCFF90", "F4FF81", "69F0AE", "B2FF59", "EEFF41", "FFF9C4", "FFECB3", "FFE0B2", "FFF59D", "FFE082", "FFCC80", "FFFF8D", "FFE57F", "FFD180", "FFCCBC", "D7CCC8", "F5F5F5", "FF9E80", "CFD8DC", "B0BEC5"]

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

  public var items: (() -> [UIColor]) = {
    return ColorPickerView.defaultHexColors.map { UIColor(hexString: $0) }.compactMap { $0 }
  }
  public var didSelect: ((UIColor) -> Void)?
  public var contains: ((UIColor) -> Bool) = {_ in return false }
  public var selectionColor: UIColor = .black
  public var colorSize: CGFloat = 20.0

  public required init(
    items: @escaping (() -> [UIColor]) = { return ColorPickerView.defaultHexColors.map { UIColor(hexString: $0) }.compactMap { $0 } },
    didSelect: ((UIColor) -> Void)? = nil,
    contains: @escaping ((UIColor) -> Bool) = {_ in return false },
    selectionColor: UIColor = .black,
    height: CGFloat,
    colorSize: CGFloat = 20.0
    ) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
    self.items = items
    self.didSelect = didSelect
    self.contains = contains
    self.selectionColor = selectionColor
    self.colorSize = colorSize
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
      kcvc.titleLabel.text = ""
      kcvc.backgroundColor = .clear
      kcvc.backgroundLabel.backgroundColor = items()[indexPath.row]
      kcvc.backgroundLabel.layer.borderWidth = 1
      kcvc.backgroundLabel.layer.borderColor = contains(items()[indexPath.row])
        ? selectionColor.cgColor : UIColor.clear.cgColor
      kcvc.backgroundLabel.layer.cornerRadius = (kcvc.backgroundLabel.frame.height / 2.0)
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
    return CGSize(width: colorSize, height: colorSize)
  }
}

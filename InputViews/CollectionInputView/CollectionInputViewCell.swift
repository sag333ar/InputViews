import UIKit

public class CollectionInputViewCell: UICollectionViewCell {
  var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = .systemFont(ofSize: 15)
    titleLabel.clipsToBounds = true
    titleLabel.textAlignment = .center
    return titleLabel
  }()

  var backgroundLabel: UILabel = {
    let backgroundLabel = UILabel()
    backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
    backgroundLabel.clipsToBounds = true
    return backgroundLabel
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    make()
  }

  private func make() {
    addSubview(backgroundLabel)
    NSLayoutConstraint.activate([
      backgroundLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundLabel.topAnchor.constraint(equalTo: topAnchor),
      backgroundLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
  }

  public override func layoutIfNeeded() {
    super.layoutIfNeeded()
    backgroundLabel.layer.cornerRadius = (backgroundLabel.frame.size.height / 2.0) - 2.0
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    make()
  }
}

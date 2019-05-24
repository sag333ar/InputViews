import UIKit

public class TableInputView<T>: UIView, UITableViewDataSource, UITableViewDelegate {
  let cellIdentifier = "Cell"
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  public var items: (() -> [T]) = { return [] }
  public var didSelect: ((T) -> Void)?
  public var text: ((T) -> String) = { _ in return "" }
  public var contains: ((T) -> Bool) = {_ in return false }
  public var font: UIFont = .systemFont(ofSize: 15)

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public override func didMoveToWindow() {
    super.didMoveToWindow()
    tableView.frame = bounds
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
  }

  public required init(
    items: @escaping (() -> [T]) = { return [] },
    didSelect: ((T) -> Void)? = nil,
    text: @escaping ((T) -> String) = { _ in return "" },
    contains: @escaping ((T) -> Bool) = {_ in return false },
    height: CGFloat,
    font: UIFont = .systemFont(ofSize: 15)
    ) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
    self.items = items
    self.didSelect = didSelect
    self.text = text
    self.contains = contains
    self.font = font
    translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableView.automaticDimension
    addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.widthAnchor.constraint(equalTo: widthAnchor),
      tableView.heightAnchor.constraint(equalTo: heightAnchor)
      ])
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items().count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier,
      for: indexPath
    )
    let currentText = items()[indexPath.row]
    cell.textLabel?.font = font
    cell.textLabel?.text = text(currentText)
    cell.textLabel?.numberOfLines = 0
    cell.accessoryType = contains(currentText) ? .checkmark : .none
    cell.selectionStyle = .none
    return cell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let currentText = items()[indexPath.row]
    didSelect?(currentText)
    tableView.reloadData()
  }
}

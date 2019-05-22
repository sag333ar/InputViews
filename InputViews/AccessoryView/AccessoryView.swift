import UIKit
public class AccessoryView: UIView {
  let toolBar: UIToolbar = {
    let toolBar = UIToolbar()
    return toolBar
  }()

  let doneItem: UIBarButtonItem = {
    let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    return doneItem
  }()

  let addItem: UIBarButtonItem = {
    let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    return addItem
  }()

  var title = ""
  var doneTapped: (() -> Void)?
  var addTapped: (() -> Void)?
  var shouldShowAdd: (() -> Bool) = { return false }

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
    toolBar.frame = bounds
    let flexi1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let flexi2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let title = UIBarButtonItem(title: self.title, style: .plain, target: nil, action: nil)
    title.isEnabled = false
    if shouldShowAdd() {
      toolBar.setItems([addItem, flexi1, title, flexi2, doneItem], animated: true)
    } else {
      toolBar.setItems([flexi1, title, flexi2, doneItem], animated: true)
    }
  }

  private func make() {
    addSubview(toolBar)
    NSLayoutConstraint.activate([
      toolBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      toolBar.topAnchor.constraint(equalTo: topAnchor),
      toolBar.widthAnchor.constraint(equalTo: widthAnchor),
      toolBar.heightAnchor.constraint(equalTo: heightAnchor)
      ])
  }

  public static func create(
    _ title: String = "",
    doneTapped: (() -> Void)? = nil,
    addTapped: (() -> Void)? = nil,
    shouldShowAdd: @escaping (() -> Bool) = { return false }
    ) -> AccessoryView? {
    let view = AccessoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    view.shouldShowAdd = shouldShowAdd
    view.doneTapped = doneTapped
    view.addTapped = addTapped
    view.title = title
    return view
  }

  @objc func doneButtonTapped() {
    doneTapped?()
  }

  @objc func addButtonTapped() {
    addTapped?()
  }
}

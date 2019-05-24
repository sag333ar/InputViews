import UIKit

public class PickerInputView<T>: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
  var selectedIndex = 0
  public var didSelectAtIndex: ((Int) -> Void)?
  public var items: (() -> [T]) = { return [] }
  public var text: ((T) -> String) = { _ in return "" }

  let pickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    return pickerView
  }()

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public override func didMoveToWindow() {
    super.didMoveToWindow()
    pickerView.frame = bounds
    pickerView.backgroundColor = .white
    backgroundColor = .white
    pickerView.reloadAllComponents()
  }

  public required init(
    items: @escaping (() -> [T]) = { return [] },
    text: @escaping ((T) -> String) = { _ in return "" },
    didSelectAtIndex: ((Int) -> Void)? = nil,
    height: CGFloat
    ) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
    self.didSelectAtIndex = didSelectAtIndex
    self.items = items
    self.text = text
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(pickerView)
    NSLayoutConstraint.activate([
      pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pickerView.topAnchor.constraint(equalTo: topAnchor),
      pickerView.widthAnchor.constraint(equalTo: widthAnchor),
      pickerView.heightAnchor.constraint(equalTo: heightAnchor)
      ])
    pickerView.dataSource = self
    pickerView.delegate = self
  }

  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return items().count
  }

  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return text(items()[row])
  }

  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedIndex = row
    didSelectAtIndex?(row)
  }
}

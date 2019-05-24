import UIKit

public class DatePickerInputView: UIView {
  var didSelect: ((Date) -> Void)?
  let pickerView: UIDatePicker = {
    let pickerView = UIDatePicker()
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    return pickerView
  }()

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public override func didMoveToWindow() {
    super.didMoveToWindow()
    pickerView.frame = bounds
    pickerView.date = Date()
  }

  public required init(
    mode: UIDatePicker.Mode,
    didSelect: ((Date) -> Void)? = nil
    ) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
    self.didSelect = didSelect
    self.pickerView.datePickerMode = mode
    self.pickerView.addTarget(self, action: #selector(didChangeTheDate), for: .valueChanged)
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(pickerView)
    NSLayoutConstraint.activate([
      pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pickerView.topAnchor.constraint(equalTo: topAnchor),
      pickerView.widthAnchor.constraint(equalTo: widthAnchor),
      pickerView.heightAnchor.constraint(equalTo: heightAnchor)
      ])
    pickerView.backgroundColor = .white
  }

  @objc func didChangeTheDate() {
    didSelect?(pickerView.date)
  }
}

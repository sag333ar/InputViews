import UIKit

class DatePickerInputView: UIView {
	var didSelect: ((Date) -> Void)?
	let pickerView: UIDatePicker = {
		let pickerView = UIDatePicker()
		return pickerView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		make()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		make()
	}

	override func didMoveToWindow() {
		super.didMoveToWindow()
		pickerView.frame = bounds
		pickerView.date = Date()
	}

	private func make() {
		addSubview(pickerView)
		NSLayoutConstraint.activate([
			pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			pickerView.topAnchor.constraint(equalTo: topAnchor),
			pickerView.widthAnchor.constraint(equalTo: widthAnchor),
			pickerView.heightAnchor.constraint(equalTo: heightAnchor)
			])
		pickerView.backgroundColor = .white
	}

	static func create(
		mode: UIDatePicker.Mode,
		didSelect: ((Date) -> Void)? = nil,
		owner: AnyObject
		) -> DatePickerInputView {
		let view = DatePickerInputView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
		view.didSelect = didSelect
		view.pickerView.datePickerMode = mode
		view.pickerView.addTarget(view, action: #selector(didChangeTheDate), for: .valueChanged)
		return view
	}

	@objc func didChangeTheDate() {
		didSelect?(pickerView.date)
	}
}
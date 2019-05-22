import UIKit

class PickerInputView: UIView {
	var selectedIndex = 0
	var didSelect: ((Int) -> Void)?
	var items: (() -> [String]) = { return [] }

	let pickerView: UIPickerView = {
		let pickerView = UIPickerView()
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
		pickerView.reloadAllComponents()
	}

	private func make() {
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

	static func create(
		didSelect: ((Int) -> Void)? = nil,
		items: @escaping (() -> [String]) = { return [] },
		owner: AnyObject
		) -> PickerInputView {
		let view = PickerInputView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
		view.didSelect = didSelect
		view.items = items
		return view
	}
}

extension PickerInputView: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return items().count
	}
}

extension PickerInputView: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return items()[row]
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedIndex = row
		didSelect?(row)
	}
}
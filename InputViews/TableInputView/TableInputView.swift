import UIKit

public class TableInputView: UIView {
	static let cellIdentifier = "Cell"
	let tableView: UITableView = {
		let tableView = UITableView()
		return tableView
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
		tableView.frame = bounds
		tableView.reloadData()
	}

	private func make() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableInputView.cellIdentifier)
		addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.widthAnchor.constraint(equalTo: widthAnchor),
			tableView.heightAnchor.constraint(equalTo: heightAnchor)
			])
		tableView.dataSource = self
		tableView.delegate = self
	}

	public static func create(
		items: @escaping (() -> [Any]) = { return [] },
		didSelect: ((Any) -> Void)? = nil,
		text: @escaping ((Any) -> String) = { _ in return "" },
		contains: @escaping ((Any) -> Bool) = {_ in return false }
		) -> TableInputView {
		let view = TableInputView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
		view.items = items
		view.didSelect = didSelect
		view.text = text
		view.contains = contains
		return view
	}
}

extension TableInputView: UITableViewDataSource, UITableViewDelegate {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items().count
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: TableInputView.cellIdentifier,
			for: indexPath
		)
		let currentText = items()[indexPath.row]
		cell.textLabel?.font = .systemFont(ofSize: 15)
		cell.textLabel?.text = text(currentText)
		cell.accessoryType = contains(currentText) ? .checkmark : .none
		return cell
	}

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let currentText = items()[indexPath.row]
		didSelect?(currentText)
		tableView.reloadData()
	}
}

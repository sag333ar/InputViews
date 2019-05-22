//
//  ViewController.swift
//  Example
//
//  Created by sagar kothari on 22/05/19.
//  Copyright © 2019 Sagar R Kothari. All rights reserved.
//

import UIKit
import InputViews

class ViewController: UIViewController {
	@IBOutlet var datePicker: NoCutPasteTextField? {
		didSet {
			guard let datePicker = datePicker else { return }
			// Setting up input view
			datePicker.inputView = DatePickerInputView.create(
				mode: .dateAndTime, didSelect: { (date) in
					let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
					datePicker.text = dateFormatter.string(from: date)
			})
			// Setting up accessory view
			datePicker.inputAccessoryView = AccessoryView.create("Select Date", doneTapped: {
				datePicker.resignFirstResponder()
			})
		}
	}

	@IBOutlet var itemPicker: NoCutPasteTextField? {
		didSet {
			guard let itemPicker = itemPicker else { return }
			// Setting up input view
			let array = ["First item", "Second item", "Third item", "Fourth item", "Fifth", "and sixth"]
			itemPicker.inputView = PickerInputView.create(didSelect: { (index) in
				itemPicker.text = array[index]
			}, items: { () -> [String] in
				return array
			})
			// Setting up accessory view
			itemPicker.inputAccessoryView = AccessoryView.create("Select item", doneTapped: {
				itemPicker.resignFirstResponder()
			})
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

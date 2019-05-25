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
      datePicker.inputView = DatePickerInputView(
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
      let array = ["First item", "Second item", "Third item", "Fourth item", "Fifth", "and sixth"]
      // Setting up input view
      let inputView = PickerInputView<String>(height: 250)
      inputView.items = { return array }
      inputView.didSelectAtIndex = { index in itemPicker.text = array[index] }
      inputView.text = { string in return string }
      itemPicker.inputView = inputView
      // Setting up accessory view
      itemPicker.inputAccessoryView = AccessoryView.create("Select item", doneTapped: {
        itemPicker.resignFirstResponder()
      })
    }
  }

  @IBOutlet var itemsFromTablePicker: NoCutPasteTextField? {
    didSet {
      guard let itemsFromTablePicker = itemsFromTablePicker else { return }
      let array = ["First item", "Second item", "Third item", "Fourth item", "Fifth", "and sixth"]
      var selected: [String] = []
      let inputView = TableInputView<String>.init(height: 250)
      inputView.items = { return array }
      inputView.didSelect = { string in
        if let index = selected.firstIndex(of: string) {
          selected.remove(at: index)
        } else {
          selected.append(string)
        }
        itemsFromTablePicker.text = selected.joined(separator: ", ")
      }
      inputView.contains = { string in return selected.firstIndex(of: string) != nil }
      inputView.text = { string in return string }
      itemsFromTablePicker.inputView = inputView
      // Setting up accessory view
      itemsFromTablePicker.inputAccessoryView = AccessoryView.create("Select item", doneTapped: {
        itemsFromTablePicker.resignFirstResponder()
      })
    }
  }

  @IBOutlet var itemsFromCollectionView: NoCutPasteTextField? {
    didSet {
      guard let itemsFromCollectionView = itemsFromCollectionView else { return }
      let array = ["First item", "Second item", "Third item", "Fourth item", "Fifth", "and sixth"]
      var selected: [String] = []
      let inputView = CollectionInputView<String>(height: 250)
      inputView.items = { return array }
      inputView.didSelect = { string in
        if let index = selected.firstIndex(of: string) {
          selected.remove(at: index)
        } else {
          selected.append(string)
        }
        itemsFromCollectionView.text = selected.joined(separator: ", ")
      }
      inputView.text = { string in return string }
      inputView.contains = { string in return selected.firstIndex(of: string) != nil }
      itemsFromCollectionView.inputView = inputView
      // Setting up accessory view
      itemsFromCollectionView.inputAccessoryView = AccessoryView.create("Select item", doneTapped: {
        itemsFromCollectionView.resignFirstResponder()
      })
    }
  }

  @IBOutlet var pickFontAwesomeIconView: NoCutPasteTextField? {
    didSet {
      guard let pickFontAwesomeIconView = pickFontAwesomeIconView else { return }
      pickFontAwesomeIconView.inputView = PickFontAwesomeIconView(didSelect: { (icon) in
        print("Icon is \(icon)")
      }, height: 250)
      // Setting up accessory view
      pickFontAwesomeIconView.inputAccessoryView = AccessoryView.create("Select item", doneTapped: {
        pickFontAwesomeIconView.resignFirstResponder()
      })
    }
  }

  @IBOutlet var colorPicker: NoCutPasteTextField? {
    didSet {
      guard let colorPicker = colorPicker else { return }
      var selectedColor: UIColor?
      colorPicker.inputView = ColorPickerView.init(didSelect: { (color) in
        colorPicker.backgroundColor = color
        selectedColor = color
      }, contains: { (color) in
        return color.isEqual(selectedColor)
      }, height: 250, colorSize: 30)
      // Setting up accessory view
      colorPicker.inputAccessoryView = AccessoryView.create("Select Color", doneTapped: {
        colorPicker.resignFirstResponder()
      })
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

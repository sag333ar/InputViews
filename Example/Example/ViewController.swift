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
      let array = ["First item", "Second item", "Third item", "Fourth item", "Fifth", "and sixth"]
      // Setting up input view
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

  @IBOutlet var itemsFromTablePicker: NoCutPasteTextField? {
    didSet {
      guard let itemsFromTablePicker = itemsFromTablePicker else { return }
      let array = ["First item", "Second item", "Third item", "Fourth item", "Fifth", "and sixth"]
      var selected: [String] = []
      itemsFromTablePicker.inputView = TableInputView.create(items: { () -> [Any] in
        return array
      }, didSelect: { (anyObj) in
        guard let string = anyObj as? String else { return }
        if let index = selected.firstIndex(of: string) {
          selected.remove(at: index)
        } else {
          selected.append(string)
        }
        itemsFromTablePicker.text = selected.joined(separator: ", ")
      }, text: { (anyObject) -> String in
        return anyObject as? String ?? ""
      }, contains: { (anyObj) -> Bool in
        guard let string = anyObj as? String, selected.firstIndex(of: string) != nil
          else { return false }
        return true
      })
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
      itemsFromCollectionView.inputView = CollectionInputView.create(items: { () -> [Any] in
        return array
      }, didSelect: { (anyObj) in
        guard let string = anyObj as? String else { return }
        if let index = selected.firstIndex(of: string) {
          selected.remove(at: index)
        } else {
          selected.append(string)
        }
        itemsFromCollectionView.text = selected.joined(separator: ", ")
      }, text: { (anyObject) -> String in
        return anyObject as? String ?? ""
      }, contains: { (anyObj) -> Bool in
        guard let string = anyObj as? String, selected.firstIndex(of: string) != nil
          else { return false }
        return true
      })
      // Setting up accessory view
      itemsFromCollectionView.inputAccessoryView = AccessoryView.create("Select item", doneTapped: {
        itemsFromCollectionView.resignFirstResponder()
      })
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

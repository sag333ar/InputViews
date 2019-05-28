![InputViews Title](assets/inputViews.png)

| Example1 | Example2 | Example3 |
|------------|------------|------------|
| ![DatePicker](assets/DatePicker.gif) | ![ItemPicker](assets/ItemPicker.gif) | ![ItemsPicker](assets/ItemsPicker.gif) |
| Example4 | Example5 | Example6 |
| ![ItemsPicker](assets/CollectionItemsPicker.gif) | ![IconPicker](assets/Pick_Font_Awesome_Solid_Icon.gif) | ![ColorPicker](assets/Pick_color.gif) |

# InputViews

> Input views for UITextField show PickerView, TableView, Collection, instead of default keyboard

![Pod](https://cocoapod-badges.herokuapp.com/v/InputViews/badge.png)
![Platform](https://cocoapod-badges.herokuapp.com/p/InputViews/badge.png)
![License](https://cocoapod-badges.herokuapp.com/l/InputViews/badge.png)

It helps you convert ordinary `UITextfield` to item picker of multiple style.

## Features

- [x] Date Picker (Example1)
- [x] Item Picker using `UIPickerView` (Example2)
- [x] Item Picker using `UITableView` (Example3)
- [x] Item Picker using `UICollectionView` (Example4)
- [x] Quick `AccessoryView` with done button (All examples with done button toolbar)
- [x] Font Awesome Icon Picker (Example5)
- [x] UIColor Picker (Example6)

## Requirements

- iOS 10.0+
- Xcode 10.2.1+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `InputViews` by adding it to your `Podfile`:

```ruby
platform :ios, '10.0'
use_frameworks!
pod 'InputViews'
```

To get the full benefits import `InputViews` wherever you import UIKit

``` swift
import UIKit
import InputViews
```

## Usage Guide

### Date Picker (Example1)

```swift
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
    datePicker.inputAccessoryView = AccessoryView("Select Date", doneTapped: {
      datePicker.resignFirstResponder()
    })
  }
}
```

### Item picker with `UIPickerView` (Example2)

```swift
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
    itemPicker.inputAccessoryView = AccessoryView("Select item", doneTapped: {
      itemPicker.resignFirstResponder()
    })
  }
}
```

### Items picker with `UITableView` (Example3)

```swift
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
    itemsFromTablePicker.inputAccessoryView = AccessoryView("Select item", doneTapped: {
      itemsFromTablePicker.resignFirstResponder()
    })
  }
}
```

### Items picker with `UICollectionView` (Example4)

```swift
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
    itemsFromCollectionView.inputAccessoryView = AccessoryView("Select item", doneTapped: {
      itemsFromCollectionView.resignFirstResponder()
    })
  }
}
```

### Pick Font Awesome Icon (Example5)

```swift
@IBOutlet var pickFontAwesomeIconView: NoCutPasteTextField? {
  didSet {
    guard let pickFontAwesomeIconView = pickFontAwesomeIconView else { return }
    pickFontAwesomeIconView.inputView = PickFontAwesomeIconView(didSelect: { (icon) in
      print("Icon is \(icon)")
    }, height: 250)
    // Setting up accessory view
    pickFontAwesomeIconView.inputAccessoryView = AccessoryView("Select item", doneTapped: {
      pickFontAwesomeIconView.resignFirstResponder()
    })
  }
}
```

### Pick UIColor (Example6)

```swift
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
    colorPicker.inputAccessoryView = AccessoryView("Select Color", doneTapped: {
      colorPicker.resignFirstResponder()
    })
  }
}
```
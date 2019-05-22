import UIKit

public class NoCutPasteTextField: UITextField {
  public override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
    if action == #selector(UIResponderStandardEditActions.paste(_:))
      ||
      action == #selector(UIResponderStandardEditActions.cut(_:)) {
      return nil
    }
    return super.target(forAction: action, withSender: sender)
  }
}

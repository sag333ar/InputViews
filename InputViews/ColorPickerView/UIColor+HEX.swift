import UIKit

public extension UIColor {
  convenience init?(hexString: String) {
    var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
    let red, green, blue, alpha: CGFloat
    switch chars.count {
    case 3:
      chars = chars.flatMap { [$0, $0] }
      fallthrough
    case 6:
      chars = ["F","F"] + chars
      fallthrough
    case 8:
      alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
      red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
      green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
      blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
    default:
      return nil
    }
    self.init(red: red, green: green, blue:  blue, alpha: alpha)
  }

  var hexString: String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
    return String(format: "#%06x", rgb)
  }
}

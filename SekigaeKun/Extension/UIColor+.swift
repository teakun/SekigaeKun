import UIKit

extension UIColor {
    class func colorFromHex(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red  : CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x0000FF00) >>  8) / 255.0,
            blue : CGFloat( rgbValue & 0x000000FF)        / 255.0,
            alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
        )
    }
    
    static var turquoise   : UIColor { return UIColor.colorFromHex(0xFF1ABC9C) }
    static var greenSea    : UIColor { return UIColor.colorFromHex(0xFF16A085) }
    static var emerland    : UIColor { return UIColor.colorFromHex(0xFF2ECC71) }
    static var nephritis   : UIColor { return UIColor.colorFromHex(0xFF27AE60) }
    static var peterRiver  : UIColor { return UIColor.colorFromHex(0xFF3498DB) }
    static var belizeHole  : UIColor { return UIColor.colorFromHex(0xFF2980B9) }
    static var amethyst    : UIColor { return UIColor.colorFromHex(0xFF9B59B6) }
    static var wisteria    : UIColor { return UIColor.colorFromHex(0xFF8E44AD) }
    static var wetAsphalt  : UIColor { return UIColor.colorFromHex(0xFF34495E) }
    static var midnightBlue: UIColor { return UIColor.colorFromHex(0xFF2C3E50) }
    static var sunflower   : UIColor { return UIColor.colorFromHex(0xFFF1C40F) }
    static var tangerine   : UIColor { return UIColor.colorFromHex(0xFFF39C12) }
    static var carrot      : UIColor { return UIColor.colorFromHex(0xFFE67E22) }
    static var pumpkin     : UIColor { return UIColor.colorFromHex(0xFFD35400) }
    static var alizarin    : UIColor { return UIColor.colorFromHex(0xFFE74C3C) }
    static var pomegranate : UIColor { return UIColor.colorFromHex(0xFFC0392B) }
    static var clouds      : UIColor { return UIColor.colorFromHex(0xFFECF0F1) }
    static var silver      : UIColor { return UIColor.colorFromHex(0xFFBDC3C7) }
    static var concrete    : UIColor { return UIColor.colorFromHex(0xFF95A5A6) }
    static var asbestos    : UIColor { return UIColor.colorFromHex(0xFF7F8C8D) }
}

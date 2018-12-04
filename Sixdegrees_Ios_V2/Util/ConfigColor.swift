

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func ColorBlue() -> UIColor{
        return UIColor(red: 0.29, green: 0.56, blue: 0.89, alpha: 1.0)
    }
    
    static func ColorLightBlue() -> UIColor{
        return UIColor(red:219/255, green: 233/255, blue: 249/255, alpha: 1.0)
    }
    
    static func colorGray() -> UIColor{
        // #024ba0
        return UIColor(red: 0.75, green: 0.77, blue: 0.81,alpha:1.0)
    }
    static func NavigationGreen() -> UIColor{
        // #02abad
        return UIColor.rgb(red: 2, green: 171, blue: 173)
    }

    static func SophiaLightGray() -> UIColor{
        // #dedede
        return UIColor.rgb(red: 222, green: 222, blue: 222)
    }

    static func SophiaGreen() -> UIColor{
        // #4ac6de
        return UIColor.rgb(red: 74, green: 197, blue: 222)
    }
    static func HeaderGreen() -> UIColor{
        // #51C6DC
        return UIColor.rgb(red: 81, green: 198, blue: 220)
    }
    static func lightBlueBackground() -> UIColor{
        // #e6f1ff
        return UIColor.rgb(red: 229, green: 241, blue: 255)
    }


    //----------------------------------------------------
    static func mollyRedTextColor() -> UIColor{
        return UIColor.rgb(red: 233, green: 120, blue: 138)
    }
    static func buttonBlueColor() -> UIColor{
        // #4a92df
        return UIColor.rgb(red: 78, green: 146, blue: 223)
    }
    static func popular24HourColor() -> UIColor{
        return UIColor(red: 0.04, green: 0.13, blue: 0.34, alpha: 1)
    }
    static func popular3DayColor() -> UIColor{
        return UIColor(red: 0.2, green: 0.29, blue: 0.67, alpha: 1)
    }
    static func popular1WeekColor() -> UIColor{
        return UIColor(red: 0.29, green: 0.56, blue: 0.67, alpha: 1)
    }
    static func categorylightGray() -> UIColor{
        return UIColor.rgb(red: 248, green: 248, blue: 248)
    }
    static func lightBlueTextColor() -> UIColor{
        return UIColor.rgb(red: 114, green: 168, blue: 233)
    }
    static func mollyBlueBackgoundColor() -> UIColor{
        return UIColor.rgb(red: 74, green: 144, blue: 226)
    }
    static func mollyLightGray() -> UIColor{
        // #f4f5f6
        return UIColor.rgb(red: 244, green: 245, blue: 246)
    }
    static func mollyLightGreenTextColor() -> UIColor{
        return UIColor.rgb(red: 183, green: 209, blue: 223)
    }
    static func mollyBlackTextColor() -> UIColor{
        return UIColor(red:0.35, green:0.37, blue:0.44, alpha:1)
    }
    static func mollyLightGrayTextColor() -> UIColor{
        return UIColor.rgb(red: 190, green: 190, blue: 196)
    }
    static func navigationLightBlue() -> UIColor{
        return UIColor.rgb(red: 210, green: 227, blue: 248)
    }

}

func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}

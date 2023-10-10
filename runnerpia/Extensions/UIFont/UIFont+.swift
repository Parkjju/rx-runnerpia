//
//  UIFont+.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/10.
//

import UIKit

enum PretendardStyle: String {
    case black = "Pretendard-Black"
    case bold = "Pretendard-Bold"
    case extraBold = "Pretendard-ExtraBold"
    case extraLight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
    case semibold = "Pretendard-SemiBold"
    case thin = "Pretendard-Thin"
}

extension UIFont {
    static func pretendard(_ style: PretendardStyle, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}

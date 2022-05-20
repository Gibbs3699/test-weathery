//
//  UIView+Extension.swift
//  Weathery
//
//  Created by TheGIZzz on 20/5/2565 BE.
//

import Foundation
import UIKit

extension UIView {
    
    func backgroundBlur(withStyle: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: withStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 1.0
        addSubview(blurEffectView)
    }
}

//
//  AttributeFactory.swift
//  DhruvApp
//
//  Created by STTL on 12/04/24.
//

import UIKit

// Class that Gives Border to Views
class BorderFactory {
    
    //Adding Border To UIView
    //Params : (uiview , cornerradius , bordercolor, borderWidth)
    static func addBorder(to view: UIView, cornerRadius: CGFloat = 0.0, borderColor: UIColor? = .none, borderWidth: CGFloat = 0.0) {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = borderColor?.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.masksToBounds = true
    }
    
    //Adding Shadow To UIView
    //Params : (uiview, shadowRadius , shadowColor , shadowOpacity, shadowOffset)
    static func addShadow(to view: UIView, shadowRadius: CGFloat = 0.0, shadowColor: CGColor? = UIColor.black.cgColor, shadowOpacity: Float = 1.0, shadowOffset: CGSize = CGSize(width: 0, height: 0)) {
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.layer.masksToBounds = false
    }

}

//MARK:- Class that Gives UnderLine to Button
class AttributedString{
    //Underlined button
    //Params : (uibutton , text)
    static func underlineButton(_ btnName:UIButton,_ text:String) {
        let string = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        btnName.setAttributedTitle(string, for: .normal)
    }
}

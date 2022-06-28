//
//  TableViewExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit

extension UITableView {
    
    func showMenssage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = "text_color".getColor()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        messageLabel.setMargins(margin: 16)
        messageLabel.layer.zPosition = 50
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func hideMessage() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UILabel {
    func setMargins(margin: CGFloat = 16) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            paragraphStyle.alignment = .center
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

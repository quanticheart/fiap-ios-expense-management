//
//  StringExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 18/06/22.
//

import Foundation
import UIKit

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func getColor() -> UIColor? {
        return UIColor(named: self)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

enum Localization: String {
    
    ///Tab Bar
    case TAB1
    case TAB2
    case TAB3
    
    ///EXPENSE DETAILS SCREE
    case MSG_EXPENSE_LIST_EMPTY
    case MSG_STATES_LIST_EMPTY
    case MSG_STATES_SEARCH_EMPTY
    case NAVIGATION_INSERT
    case NAVIGATION_UPDATE
    case NAVIGATION_INSERT_STATE
    case HINT_NAME_EXPENSE
    case HINT_PRICE_EXPENSE
    case HINT_SELECT_STATE
    case HINT_SELECT_IMAGE
    case HINT_LABEL_DESCRIPTION
    case HINT_LABEL_CREDIT
    case BTN_LABEL_INSERT
    case BTN_LABEL_UPDATE
    case BTN_LABEL_CANCEL
    case BTN_LABEL_EXCLUDE
    case DIALOG_IMG_MSG_TITLE
    case DIALOG_IMG_MSG_SUBTITLE
    case DIALOG_IMG_OPTION_CAMERA
    case DIALOG_IMG_OPTION_LIBRARY
    case DIALOG_IMG_OPTION_ALBUM
    case DIALOG_STATE_PLACEHOLDER
    case SEARCH_STATE_PLACEHOLDER
    
    ///DETAIL
    case DETAILS_COMPL_TITLE
    
    /// REGISTER EXPENSE
    case SUMMARY_ALERT_TITLE
    case SUMMARY_ALERT_MESSAGE
    
    ///SUMMARY SCREE
    case SUMMARY_TITLE
    case CREDIT_CARD_EXPENSES
    case OTHER_EXPENSES
    
    ///CONFIG SCREE
    case STATES_LIST
    case SAVE_BUTTON_TITLE
    case TODAYS_EXCHANGE
    case IOF_TAX
    case CONFIG_ALERT_TITLE
    case CONFIG_ALERT_MESSAGE
    
    
    /// Returns the localized string of the given case
    /// - Returns: NSLocalizedString
    func getLocalizedString() -> String {
        return self.rawValue.localize()
    }
    
}

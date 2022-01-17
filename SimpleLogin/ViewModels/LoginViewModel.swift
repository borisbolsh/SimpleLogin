import Foundation
import UIKit.UIColor

class LoginViewModel {
    var statusText = Dynamic("")
    var statusColor = Dynamic(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var isLoggedIn = false
    
    func userButtonPressed(login: String, password: String) {
        if login != User.logins[0].login || password != User.logins[0].passwords {
            statusText.value = GlobalStrings.SignInStatusText.failedString
            statusColor.value = GlobalConstants.Colors.failed
            isLoggedIn = false
        } else {
            statusText.value = GlobalStrings.SignInStatusText.successString
            statusColor.value = GlobalConstants.Colors.success
            isLoggedIn = true
        }
    }
}

//
//  ViewController.swift
//  TouchIDDemo
//
//  Created by Rohit on 27/10/20.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func actionOnAuthenticateButton(_ sender: UIButton) {
        authenticateUserWithTouchID()
    }
    func authenticateUserWithTouchID() {
        let context : LAContext = LAContext()
        let myLocalizedReasonString = "Authenticate with Touch ID"
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, evaluateError in
                if success {
                    self.displayAlert(message: "Touch ID Authentication is Successful")
                }else {
                    //self.displayAlert(message: "Touch ID Authentication is Failed")
                    if let error = evaluateError {
                        let message = self.getErrorMessageForLAErrorCode(errorCode: error._code)
                        print(message)
                        self.displayAlert(message: message)
                    }
                }
            }
        } else {
            self.displayAlert(message: "Touch ID not available")
        }
    }
    func displayAlert(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    func getErrorMessageForLAErrorCode(errorCode: Int) -> String {
        
        var message = ""
        switch errorCode {
        
        case LAError.appCancel.rawValue:
            message = "Authentication was canceled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "Authentication was not successful, because user failed to provide valid credentials."
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Authentication could not start, because passcode is not set on the device."
            
        case LAError.systemCancel.rawValue:
            message = "Authentication cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "Authentication was canceled by user"
            
        case LAError.userFallback.rawValue:
            message = "Authentication was canceled, because the user tapped the fallback button"
            
        default:
            message = "Error code not found in LAError"
        }
        return message
    }
}


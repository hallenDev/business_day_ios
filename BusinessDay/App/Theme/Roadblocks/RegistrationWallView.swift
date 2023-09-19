import UIKit
import CosmosKit

class RegistrationWallView: UIView {

    @IBOutlet var text1: BDBlockerLabelShort!
    @IBOutlet var text2: BDBlockerLabelLengthy!
    @IBOutlet var text3: BDBlockerTextView!

    @IBOutlet var registerButton: BDBlockerButton! {
        didSet {
            registerButton.titleLabel?.font = UIFont(name: ThemeBuilder.BDFonts.montserratBold.rawValue, textStyle: .subheadline)
        }
    }

    @IBOutlet var signInButton: BDBlockerButton! {
        didSet {
            signInButton.titleLabel?.font = UIFont(name: ThemeBuilder.BDFonts.montserratBold.rawValue, textStyle: .subheadline)
        }
    }

    class func nib() -> UINib {
        return UINib(nibName: "RegistrationWallView", bundle: .main)
    }

    @IBAction func signIn(_ sender: Any) {
        let login = cosmos.getAuthorisationView()
        login.modalPresentationStyle = .fullScreen
        UIApplication.shared.topViewController()?.present(login, animated: true, completion: nil)
    }

    @IBAction func register(_ sender: Any) {
        let login = cosmos.getAuthorisationView()
        let childView = login.view
        childView?.layoutIfNeeded()
        login.modalPresentationStyle = .fullScreen
        UIApplication.shared.topViewController()?.present(login, animated: true, completion: nil)
        login.triggerSegue("Register")
    }
}

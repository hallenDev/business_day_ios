import UIKit
import CosmosKit

class SubscriptionWallView: UIView {

    @IBOutlet var text1: BDBlockerLabelShort!
    @IBOutlet var text2: BDBlockerLabelLengthy!
    @IBOutlet var text4: BDBlockerLabelShort!
    @IBOutlet var text5: BDBlockerTextView!
    @IBOutlet var signInButton: BDBlockerButton! {
        didSet {
            signInButton.titleLabel?.font = UIFont(name: ThemeBuilder.BDFonts.montserratBold.rawValue, textStyle: .subheadline)
            signInButton.isHidden = (cosmos.user != nil)
        }
    }
    @IBOutlet var subscribeButton: BDBlockerButton! {
        didSet {
            subscribeButton.titleLabel?.font = UIFont(name: ThemeBuilder.BDFonts.montserratBold.rawValue, textStyle: .subheadline)
        }
    }

    @IBAction func signIn(_ sender: Any) {
        let login = cosmos.getAuthorisationView()
        login.modalPresentationStyle = .fullScreen
        UIApplication.shared.topViewController()?.present(login, animated: true, completion: nil)
    }

    @IBAction func subscribe(_ sender: Any) {
        let urlString = "https://www.businesslive.co.za/buy"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    class func nib() -> UINib {
        return UINib(nibName: "SubscriptionWallView", bundle: .main)
    }
}

import UIKit
import CosmosKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Check if user has profile.
        checkUserProfile()
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedIndex == 0 && tabBarController.viewControllers?.firstIndex(of: viewController) == 0 {
            let navController = viewController as? UINavigationController
            let articleList = navController?.viewControllers.first as? ArticleListViewController
            articleList?.scrollToTop()
        }
        return true
    }
    
    func checkUserProfile() {
        if !cosmos.isLoggedIn {
            return
        }

        let profileCompleted = cosmos.user?.profile_complete ?? false
        if !profileCompleted {
            let welcome: WelcomeNavController = cosmos.getWelcomeView()
            welcome.modalPresentationStyle = .fullScreen
            present(welcome, animated: true, completion: nil)
        }
    }
}

import Foundation
import UIKit
import CosmosKit

class BDFeaturedArticleCell: BDArticleCell {

    @IBOutlet var imageHeightConstraint: NSLayoutConstraint! {
        didSet {
            imageHeightConstraint.constant = CGFloat.maximum(285, UIScreen.main.bounds.height * 0.30)
        }
    }

    override func configure(for article: ArticleSummaryViewModel, cosmos: Cosmos) {
        super.configure(for: article, cosmos: cosmos)
    }
}

import Foundation
import CosmosKit

class BDArticleHeader: ArticleHeader {

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = cosmos.articleTheme.dateFormat
        return formatter
    }()

    @IBOutlet var updatedTime: BDArticleUpdatedTimeLabel!
    @IBOutlet var publishedTime: BDArticleMetaInfoLabel!
    @IBOutlet var authorInfo: BDArticleAuthorInfoLabel!

    override func configure(_ article: ArticleViewModel, logo: UIImage?, cosmos: Cosmos) {
        super.configure(article, logo: logo, cosmos: cosmos)
        section.isHidden = false
        sponsor.isHidden = false

        section.text = article.sectionName

        if article.isPremium {
            sponsor.image = UIImage(bdName: .labelPremium)
        } else if article.isSponsored {
            sponsor.image = UIImage(bdName: .labelSponsored)
        } else {
            sponsor.isHidden = true
        }

        if let pubDate = article.datePublished {
            publishedTime.text = pubDate
        } else {
            publishedTime.removeFromSuperview()
        }
        if let modified = article.dateModified {
            updatedTime.text = String(format: "UPDATED %@", modified)
        } else {
            updatedTime.removeFromSuperview()
        }

        if let author = article.author?.name {
            if author.starts(with: "by") {
                authorInfo.text = author
            } else {
                authorInfo.text = String(format: "by %@", author)
            }
        } else {
            authorInfo.removeFromSuperview()
        }
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: .main)
    }
}

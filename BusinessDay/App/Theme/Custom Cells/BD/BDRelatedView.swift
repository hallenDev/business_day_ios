import UIKit
import CosmosKit

class BDRelatedView: UIView, RelatableArticle {

    @IBOutlet var sectionBlock: SectionBlock!
    @IBOutlet var sectionLabel: BDRelatedSectionLabel!
    @IBOutlet var titleLabel: BDRelatedTitleLabel!
    @IBOutlet var synopsisLabel: BDRelatedSynopsisLabel!
    @IBOutlet var timeLabel: BDTimeLabel!
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var sponsor: UIImageView!

    let placeholder = {
        UIImage(cosmosName: .videoPlaceholder)
    }()

    func configureForRelated(article: ArticleSummaryViewModel) {
        self.configure(for: article)
    }

    func configure(for article: ArticleSummaryViewModel) {
        backgroundColor = cosmos.relatedArticleTheme.backgroundColor

        sectionLabel.text = article.sectionName
        titleLabel.text = article.title
        synopsisLabel.text = article.synopsis

        if let url = article.image?.imageURL,
            let imageURL = URL(string: url) {
            articleImage.kf.setImage(with: imageURL, placeholder: article.image?.blurImage ?? placeholder)
        } else {
            articleImage.image = placeholder
        }

        if article.isPremium {
            sponsor.image = UIImage(bdName: .labelPremium)
        } else if article.isSponsored {
            sponsor.image = UIImage(bdName: .labelSponsored)
        } else {
            sponsor.isHidden = true
        }

        if let modDate = article.modifiedDate,
           TimeFormatter.isFresh(date: modDate),
           let updatedTime = TimeFormatter.timeAgoString(for: modDate) {
            self.timeLabel.text = String(format: "Updated %@", updatedTime)
        } else {
            self.timeLabel.text = TimeFormatter.timeAgoString(for: article.publishedDate)
        }
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: .main)
    }
}

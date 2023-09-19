import UIKit
import CosmosKit

class BDArticleCell: UITableViewCell, CustomArticleSummaryCell, AdInjectableCell {

    @IBOutlet var topAdView: AdContainerView!
    @IBOutlet var topAdViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var bottomAdView: AdContainerView!
    @IBOutlet var bottomAdViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var wrapperView: UIView!

    @IBOutlet var sectionBlock: SectionBlock!
    @IBOutlet var sectionLabel: BDSectionLabel!

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var synopsisLabel: BDSynopsisLabel!

    @IBOutlet var timeLabel: BDTimeLabel!

    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var videoIcon: UIImageView!
    @IBOutlet var sponsor: UIImageView!

    var interscrollerTapped: EmptyCallBack!

    var placeholder: UIImage = {
        UIImage(cosmosName: .videoPlaceholder)
    }()

    func configureAd(placement: AdPlacement, ad: CosmosAd) {
        if placement.type == .banner {
            configureBannerAd(placement: placement, ad: ad)
        } else if let height = placement.sizes.first?.size.height {
            configureInterscroller(height: height, placement: placement, ad: ad)
            contentView.backgroundColor = .clear
            backgroundColor = .clear
        }
    }

    public func insertInterscrollerButton(for targetView: UIView) {
        let button = createInterScrollerButton(for: targetView)
        button.addTarget(self, action: #selector(interscrollerSelected(_:)), for: .touchUpInside)
    }

    @objc func interscrollerSelected(_ sender: Any) {
        interscrollerTapped()
    }

    func configure(for article: ArticleSummaryViewModel, cosmos: Cosmos) {
        self.backgroundColor = UIColor(dynamic: .background)
        self.contentView.backgroundColor = UIColor(dynamic: .background)
        self.wrapperView.backgroundColor = UIColor(dynamic: .background)
        self.topAdView.backgroundColor = UIColor(dynamic: .background)
        self.bottomAdView.backgroundColor = UIColor(dynamic: .background)

        self.sectionLabel.text = article.sectionName
        self.titleLabel.text = article.title
        self.synopsisLabel.text = article.synopsis
        self.videoIcon.isHidden = !article.hasVideoContent

        if article.isPremium {
            sponsor.image = UIImage(bdName: .labelPremium)
        } else if article.isSponsored {
            sponsor.image = UIImage(bdName: .labelSponsored)
        } else {
            sponsor.isHidden = true
        }

        if let url = article.image?.imageURL,
            let imageURL = URL(string: url) {
            articleImage.kf.setImage(with: imageURL, placeholder: article.image?.blurImage ?? placeholder)
        } else {
            articleImage.image = placeholder
        }

        if let modDate = article.modifiedDate,
           TimeFormatter.isFresh(date: modDate),
           let updatedTime = TimeFormatter.timeAgoString(for: modDate) {
            self.timeLabel.text = String(format: "Updated %@", updatedTime)
        } else {
            self.timeLabel.text = TimeFormatter.timeAgoString(for: article.publishedDate)
        }
    }

    class func nib() -> UINib {
        return UINib(nibName: self.reuseID, bundle: .main)
    }

    class var reuseID: String {
        String(describing: self)
    }

    class var uiPair: CustomUIPair {
        CustomUIPair(nib: self.nib(), reuseId: self.reuseID)
    }

    class func instanceFromNib() -> BDArticleCell {
        // swiftlint:disable:next force_cast
        return (Self.nib().instantiate(withOwner: self, options: nil)[0] as! BDArticleCell)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        sponsor.image = nil
        sponsor.isHidden = false
        videoIcon.isHidden = false
        articleImage.image = nil
        timeLabel.text = nil
        titleLabel.text = nil
        synopsisLabel.text = nil
        sectionLabel.text = nil

        bottomAdViewHeightConstraint.constant = 0
        bottomAdView.backgroundColor = .white
        bottomAdView.subviews.forEach { $0.removeFromSuperview() }
        topAdViewHeightConstraint.constant = 0
        topAdView.backgroundColor = .white
        topAdView.subviews.forEach { $0.removeFromSuperview() }
    }
}

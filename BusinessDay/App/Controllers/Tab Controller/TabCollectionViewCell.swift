import UIKit

class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet var title: TabLabel!
    @IBOutlet var selectedView: UIView!

    override var isSelected: Bool {
        didSet {
            selectedView.backgroundColor = isSelected ? UIColor(dynamic: .brandPrimary) : .clear
            title.textColor = isSelected ? UIColor(dynamic: .text) : UIColor(grayScale: .gray4)
        }
    }

    func configure(data: TabData) {
        title.text = data.title
        title.textColor = isSelected ? UIColor(dynamic: .text) : UIColor(grayScale: .gray4)
        selectedView.backgroundColor = isSelected ? UIColor(dynamic: .brandPrimary) : .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        selectedView.backgroundColor = .clear
        title.text = nil
    }
}

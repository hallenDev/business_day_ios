import UIKit

class LimitedTabFlow: UICollectionViewFlowLayout {

    private let maxNumColumns: Int
    private let minColumnWidth: CGFloat = 128
    private let cellHeight: CGFloat = 24

    init(columnCap: Int) {
        maxNumColumns = columnCap
        super.init()
    }

    required init?(coder: NSCoder) {
        maxNumColumns = 2
        super.init(coder: coder)
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width

        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)

        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = .zero
        self.sectionInsetReference = .fromSafeArea
        self.scrollDirection = .horizontal
    }
}

import UIKit

class TabScrollView: UIScrollView {

    private var currentPage: Int = 0
    private var widthChanged = false

    override var bounds: CGRect {
        didSet {
            self.widthChanged = oldValue.width != self.bounds.width
        }
    }

    private var tabViews = [UIView]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            self.tabViews.forEach { self.addSubview($0) }
        }
    }

    init() {
        super.init(frame: .zero)
        setupScrollView()
    }

    fileprivate func setupScrollView() {
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        bouncesZoom = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        for (index, view) in self.tabViews.enumerated() {
            view.frame = CGRect(origin: CGPoint(x: CGFloat(index) * self.bounds.width, y: 0), size: self.bounds.size)
        }

        self.contentSize = CGSize(width: self.bounds.width * CGFloat(self.tabViews.count), height: self.bounds.height)

        if self.widthChanged {
            let newContentOffset = CGFloat(self.currentPage) * self.bounds.width
            let offset = CGPoint(x: newContentOffset, y: self.contentOffset.y)
            self.setContentOffset(offset, animated: false)
        }
    }

    func updateCurrentPage() -> Int {
        self.currentPage = calculateCurrentTab() ?? 0
        return self.currentPage
    }

    func calculateCurrentTab() -> Int? {
        let origins = self.tabViews.map { $0.frame.origin.x }
        let diffs = origins.map { abs(self.contentOffset.x - $0) }
        guard let minimum = diffs.min() else { return nil }
        return diffs.firstIndex(of: minimum)
    }

    func setViews(_ views: [UIView]) {
        tabViews = views
    }
}

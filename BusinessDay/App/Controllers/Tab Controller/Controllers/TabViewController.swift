import UIKit
import CosmosKit

class TabViewController: UIViewController {

    @IBOutlet var titleLabel: HeaderLabel!
    @IBOutlet var collectionView: UICollectionView!
    var scrollView = TabScrollView()
    var viewModel: TabViewModel!

    private struct Config {
        static let interItemSpacing: CGFloat = 18
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.title
        setupScrollView()
        configureScrollView()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.navigationController?.navigationBar.configureNav(cosmos: cosmos)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cosmos.logger?.log(event: viewModel.event)
    }

    fileprivate func setupCollectionView() {
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
        if viewModel.maxColumnCount != 0 {
            collectionView.collectionViewLayout = LimitedTabFlow(columnCap: viewModel.maxColumnCount)
        }
    }

    fileprivate func setupScrollView() {
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Config.interItemSpacing)
        ])
    }

    func configure(viewModel: TabViewModel) {
        self.viewModel = viewModel
    }

    func configureScrollView() {
        self.children.forEach { $0.willMove(toParent: nil) }
        self.scrollView.setViews([])
        self.children.forEach { $0.removeFromParent() }

        let viewControllers = viewModel.viewControllers()
        viewControllers.forEach { self.addChild($0) }
        self.scrollView.setViews(viewModel.views())
        viewControllers.forEach { $0.didMove(toParent: self) }
    }
}

// MARK: Collection view datasource 
extension TabViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath)
        if let content = viewModel.item(at: indexPath) {
            (cell as? TabCollectionViewCell)?.configure(data: content)
        }
        return cell
    }
}

// MARK: Collection view delegate
extension TabViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)

        guard indexPath.row < self.children.count else { return }

        let viewController = self.children[indexPath.row]
        self.scrollView.scrollRectToVisible(viewController.view.frame, animated: true)
    }
}

// MARK: Scroll View Delegate
extension TabViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCollectionView()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateCollectionView()
    }

    fileprivate func updateCollectionView() {
        let index = IndexPath(row: scrollView.updateCurrentPage(), section: 0)
        collectionView.selectItem(at: index, animated: true, scrollPosition: .centeredVertically)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}

// MARK: static create method
extension TabViewController {
    static func create(viewModel: TabViewModel) -> TabViewController {
        // swiftlint:disable:next force_cast
        let controller = UIStoryboard.businessDay.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        controller.configure(viewModel: viewModel)
        return controller
    }
}

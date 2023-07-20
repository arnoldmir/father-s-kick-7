import UIKit

class ViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let imageViewHeight: CGFloat = 270
    private var scrollIndicatorInsets: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene

        return imageViewHeight - (scene?.windows.first?.safeAreaInsets.top ?? 0.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupImageView()
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.frame = view.frame
        scrollView.alwaysBounceVertical = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
        scrollView.indicatorStyle = .black
        scrollView.verticalScrollIndicatorInsets.top = scrollIndicatorInsets
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
    }
    
    private func setupImageView() {
        imageView.image = .init(named: "kek-cheburek")
        imageView.frame = .init(origin: scrollView.frame.origin,
                                size: .init(width: scrollView.frame.width,
                                            height: imageViewHeight))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        scrollView.addSubview(imageView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        if offsetY < 0 {
            imageView.frame = CGRect(x: 0, y: offsetY, width: view.frame.width, height: imageViewHeight - offsetY)
            scrollView.verticalScrollIndicatorInsets.top = scrollIndicatorInsets - offsetY
        }
    }
}

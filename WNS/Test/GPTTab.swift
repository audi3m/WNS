//
//  GPTTab.swift
//  WNS
//
//  Created by J Oh on 9/1/24.
//

import UIKit
import SnapKit

class GPTTab: UIViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    let tabs = ["와인", "해시태그", "닉네임"]
    var buttons: [UIButton] = []
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupTabs()
        setupPageViewController()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { make in
            
        }
        stackView.snp.makeConstraints { make in
            
        }
    }
    
    
    
    func setupTabs() {
        for (index, title) in tabs.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        updateTabSelection(index: 0)
    }
    
    @objc func tabTapped(_ sender: UIButton) {
        let index = sender.tag
        pageViewController.setViewControllers([viewControllers[index]], direction: .forward, animated: true, completion: nil)
        updateTabSelection(index: index)
    }
    
    func updateTabSelection(index: Int) {
        for (i, button) in buttons.enumerated() {
            if i == index {
                button.setTitleColor(.blue, for: .normal)
            } else {
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        for _ in tabs {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(hue: CGFloat(arc4random() % 256) / 256.0, saturation: 1.0, brightness: 1.0, alpha: 1.0) // 랜덤 색상
            viewControllers.append(vc)
        }
        
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        pageViewController.didMove(toParent: self)
    }
    
}

extension GPTTab: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController), currentIndex > 0 else { return nil }
        return viewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController), currentIndex < viewControllers.count - 1 else { return nil }
        return viewControllers[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentVC = pageViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: currentVC) else { return }
        updateTabSelection(index: index)
    }
}

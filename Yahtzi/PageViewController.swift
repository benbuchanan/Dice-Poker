//
//  PageViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 5/6/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "pageOne"), self.newVc(viewController: "pageTwo"), self.newVc(viewController: "pageThree"), self.newVc(viewController: "pageFour"), self.newVc(viewController: "pageFive"), self.newVc(viewController: "pageSix")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self

        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // dismiss page view controller
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // loads the vcs as you swipe through pages
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    // MARK: - Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = orderedViewControllers.firstIndex(of: viewController)!
        let previousIndex = currentIndex - 1
        return (previousIndex == -1) ? nil : orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = orderedViewControllers.firstIndex(of: viewController)!
        let nextIndex = currentIndex + 1
        return (nextIndex == orderedViewControllers.count) ? nil : orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return 6
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 0.3)
        appearance.currentPageIndicatorTintColor = UIColor.systemBlue
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

        for view in self.view.subviews {
            if view is UIScrollView  {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    // MARK: - Disabling rotation
    // Set the shouldAutorotate to False
    override open var shouldAutorotate: Bool {
       return false
    }

    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }

}

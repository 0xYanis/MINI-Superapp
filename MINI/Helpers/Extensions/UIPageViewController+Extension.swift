//
//  UIPageViewController+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 08.09.2023.
//

import UIKit

extension UIPageViewController {
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard
            let currentPage = viewControllers?[0],
            let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage)
        else { return }
        
        setViewControllers(
            [nextPage],
            direction: .forward,
            animated: animated,
            completion: completion
        )
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0],
              let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage)
        else { return }
        
        setViewControllers(
            [prevPage],
            direction: .forward,
            animated: animated,
            completion: completion
        )
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers(
            [pages[index-1]],
            direction: .forward,
            animated: true
        )
    }
    
}

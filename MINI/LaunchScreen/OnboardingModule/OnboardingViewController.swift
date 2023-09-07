//
//  OnboardingViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    
}

final class OnboardingViewController: UIPageViewController {
    
    public var presenter: OnboardingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension OnboardingViewController: OnboardingViewProtocol {
    
}

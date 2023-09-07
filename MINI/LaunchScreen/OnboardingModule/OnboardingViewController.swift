//
//  OnboardingViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    
}

final class OnboardingViewController: UIViewController {
    
    public var presenter: OnboardingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

extension OnboardingViewController: OnboardingViewProtocol {
    
}

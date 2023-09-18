//
//  BankSheetLayout.swift
//  MINI
//
//  Created by Yan Rybkin on 18.09.2023.
//

import UIKit
import FloatingPanel

final class BankSheetLayout: FloatingPanelLayout {
    
    typealias anchor = FloatingPanelLayoutAnchor
    
    var position: FloatingPanel.FloatingPanelPosition = .bottom
    
    var initialState: FloatingPanel.FloatingPanelState = .half
    
    var anchors: [FloatingPanel.FloatingPanelState : FloatingPanel.FloatingPanelLayoutAnchoring] = [
        .full: anchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
        .half: anchor(fractionalInset: 0.47, edge: .bottom, referenceGuide: .safeArea),
    ]
    
}

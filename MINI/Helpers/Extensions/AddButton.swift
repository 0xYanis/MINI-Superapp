//
//  AddButton.swift
//  MINI
//
//  Created by Yanis on 23.10.2023.
//

import UIKit

final class AddButton: UIButton {
    
    private let image = UIImage(
        systemName: UIImage.SystemSymbol.plus.rawValue,
        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
    )
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func initialize() {
        setImage(image, for: .normal)
        tintColor = .tintMINI
        backgroundColor = .secondarySystemBackground
        contentMode = .scaleAspectFill
    }
    
}

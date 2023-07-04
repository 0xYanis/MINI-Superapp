//
//  UITagPickerView.swift
//  MINI
//
//  Created by Yan Rybkin on 04.07.2023.
//

import UIKit

protocol UITagPickerViewDataSource: AnyObject {
    func tagPickerCount(_ tagPicker: UITagPickerView) -> Int
    func tagPickerTitle(_ tagPicker: UITagPickerView, indexPath: IndexPath) -> String
}

public class UITagPickerView: UIControl {
    
    var dataSource: UITagPickerViewDataSource? {
        didSet {
            setupView()
        }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    func setupView() {
        let count = dataSource?.tagPickerCount(self)
        for item  in 0..<count! {
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSource?.tagPickerTitle(self, indexPath: indexPath)
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = item
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(
                self,
                action: #selector(selectedButton),
                for: .touchUpInside
            )
            buttons.append(button)
            self.addSubview(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
    
    @objc func selectedButton(sender: UIButton) {
        print("selectedButton")
    }
}

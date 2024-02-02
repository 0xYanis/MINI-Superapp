//
//  DateViewController.swift
//  MINI
//
//  Created by Yanis on 02.02.2024.
//

import UIKit

final class DateViewController: UIViewController {
    
    static var modalDate = UINavigationController(
        rootViewController: DateViewController()
    )
    
    private let calendarView = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addCalendarView()
        configureBar()
    }
    
    private func addCalendarView() {
        calendarView.locale = .current
        calendarView.calendar = .current
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(15)
        }
    }
    
    private func configureBar() {
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissPicker)
        )
        navigationController?.navigationBar.topItem?.rightBarButtonItem = closeButton
        navigationController?.navigationBar.topItem?.title = "Дата поездки"
    }
    
    @objc private func dismissPicker() {
        dismiss(animated: true)
    }
}

//
//  CardFormView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.08.2023.
//

import UIKit

/*
 struct BankCardEntity: Codable {
     var id: Int
     var cardColor: String
     var logo: String
     var cardType: String
     var amount: Double
     var currency: String
     var number: String
     var bankName: String
     var holderName: String?
     var expirationDate: String
     var cvv: String
 }
 */

final class CardFormView: UIView {
    
    weak var presenter: NewCardPresenterProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CardFormView {
    
    func initialize() {
        
    }
    
}

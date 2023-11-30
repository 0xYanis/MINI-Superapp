//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct Template: Identifiable, Codable {
    var id = UUID().uuidString
    var image: String
    var label: String
    
    static func convertToTempStruct(tempObject: TemplateObject) -> Template {
        return .init(
            id: tempObject.id,
            image: tempObject.image,
            label: tempObject.label
        )
    }
}

class TemplateObject: Object {
    @Persisted var id = UUID().uuidString
    @Persisted var image: String
    @Persisted var label: String
    
    class func convertToTempObject(tempStruct: Template) -> TemplateObject {
        let object = TemplateObject()
        object.id = tempStruct.id
        object.label = tempStruct.label
        object.image = tempStruct.image
        return object
    }
    
}

var mockTemplates: [Template] = [
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template")
]

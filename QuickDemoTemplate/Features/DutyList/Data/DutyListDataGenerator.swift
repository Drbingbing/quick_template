//
//  DutyListDataGenerator.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/26.
//

import SwiftyJSON
import Foundation

struct DutyListDataGenerator {
    
    static func load() -> [PositionCategorySelectableRow] {
        let filePath = Bundle.main.url(forResource: "duty_list", withExtension: "json")!
        let contents = try! Data(contentsOf: filePath, options: .mappedIfSafe)
        let json = JSON(contents)
        
        return json["tCode"]["n"].arrayValue.map { CodeJsonParams(json: $0) }
            .map { PositionCategorySelectableRow(params: $0) }
    }
    
    static func loadLevel1() -> [Pair] {
        let filePath = Bundle.main.url(forResource: "duty_list", withExtension: "json")!
        let contents = try! Data(contentsOf: filePath, options: .mappedIfSafe)
        let json = JSON(contents)
        
        return json["tCode"]["n"].arrayValue.map { Pair(json: $0) }
    }
    
    static func loadLevel2(for pair: Pair) -> [Pair] {
        let filePath = Bundle.main.url(forResource: "duty_list", withExtension: "json")!
        let contents = try! Data(contentsOf: filePath, options: .mappedIfSafe)
        let json = JSON(contents)
        
        return json["tCode"]["n"].arrayValue.map { Pair(json: $0) }
    }
}

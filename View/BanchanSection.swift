//
//  BanchanSection.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/05.
//

import Foundation
import RxDataSources

struct BanchanSection: SectionModelType {
    var sectionitem: Sectionitem
    var items: [Banchan]
    
    enum Sectionitem: Int {
        case main
        case soup
        case side
    }
    
    init(sectionitem: Sectionitem, items: [Banchan]) {
        self.sectionitem = sectionitem
        self.items = items
    }
    
    static func getSctionType(_ rowValue: Int) -> Sectionitem {
        var type: Sectionitem!
        
        switch rowValue {
        case Sectionitem.main.rawValue:
            type = Sectionitem.main
            break
        case Sectionitem.soup.rawValue:
            type = Sectionitem.soup
            break
        case Sectionitem.side.rawValue:
            type = Sectionitem.side
            break
        default:
            break
        }
        return type
    }
    
    init(original: BanchanSection, items: [Banchan]) {
        self = original
        self.items = items
    }
}

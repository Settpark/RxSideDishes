//
//  BanchanSection.swift
//  RxSwift_Sidedishes
//
//  Created by 박정하 on 2021/08/05.
//

import Foundation
import RxDataSources

struct BanchanSection: SectionModelType, Equatable {
    
    static func == (lhs: BanchanSection, rhs: BanchanSection) -> Bool {
        return lhs.sectionitem == rhs.sectionitem && lhs.items == rhs.items
    }
    
    var sectionitem: BanchanUsecase
    var items: [BanchanDTO]
    
    init(sectionitem: BanchanUsecase, items: [BanchanDTO]) {
        self.sectionitem = sectionitem
        self.items = items
    }
    
    static func getSectionType(_ rowValue: Int) -> BanchanUsecase {
        var type: BanchanUsecase!
        
        switch rowValue {
        case 0:
            type = BanchanUsecase.main
            break
        case 1:
            type = BanchanUsecase.soup
            break
        case 2:
            type = BanchanUsecase.side
            break
        default:
            break
        }
        return type
    }
    
    init(original: BanchanSection, items: [BanchanDTO]) {
        self = original
        self.items = items
    }
}

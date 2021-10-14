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
    
    var sectionitem: MainpageUsecase
    var items: [Banchan]
    
    init(sectionitem: MainpageUsecase, items: [Banchan]) {
        self.sectionitem = sectionitem
        self.items = items
    }
    
    static func getSectionType(_ rowValue: Int) -> MainpageUsecase {
        var type: MainpageUsecase!
        
        switch rowValue {
        case 0:
            type = MainpageUsecase.main
            break
        case 1:
            type = MainpageUsecase.soup
            break
        case 2:
            type = MainpageUsecase.side
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

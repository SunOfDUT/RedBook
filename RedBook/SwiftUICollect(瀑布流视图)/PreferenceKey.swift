//
//  PreferenceKey.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/24.
//

import Foundation
import SwiftUI

struct PreferenceSetter<ID:Hashable> : View{
    var id : ID
    var body: some View{
        GeometryReader{ proxy in
            Color.clear
                .preference(key: ElementPreferenceKey.self, value: [ElementPreferenceData(id: AnyHashable(self.id), size: proxy.size)])
        }
    }
}

struct ElementPreferenceData:Equatable{
    let id : AnyHashable
    let size : CGSize
}

struct ElementPreferenceKey:PreferenceKey{
    typealias Value =  [ElementPreferenceData]
    
    static var defaultValue: [ElementPreferenceData] = []
    
    static func reduce(value: inout [ElementPreferenceData], nextValue: () -> [ElementPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

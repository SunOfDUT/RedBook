//
//  EnvironmentKey.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/24.
//

import Foundation
import SwiftUI

@propertyWrapper
struct ReSizeNumber{
    private var value : Int = 1
    
    var wrappedValue : Int{
        get{value}
        set{value = max(1,newValue)}
    }
    
    init(wrappedValue initialValue:Int){
        self.wrappedValue = initialValue
    }
}

struct GridStyle{
    @ReSizeNumber var columsInportait : Int
    @ReSizeNumber var columsInlandscpae : Int
    
    let spacing : CGFloat
    let animation : Animation?
    
    var colums : Int{
        #if os(OSX) || os(tvOS) || targetEnvironment(macCatalyst)
        return columsInlandscpae
        #elseif os(watchOS)
        return columsInportait
        #else
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width > screenSize.height ? columsInlandscpae : columsInportait
        #endif
    }
}

struct GridStyleKey:EnvironmentKey{
    typealias Value = GridStyle
    static let defaultValue: Value =
    GridStyle(columsInportait: 2, columsInlandscpae: 2, spacing: 8, animation: Animation.default)
}

extension EnvironmentValues{
    var gridStyle:GridStyle{
        get {self[GridStyleKey.self]}
        set {self[GridStyleKey.self] = newValue}
    }
}
struct ScollOptions{
    let direction : Axis.Set
}

struct ScollOptionsKey : EnvironmentKey{
    static var defaultValue: ScollOptions = ScollOptions(direction: .vertical)
}
extension EnvironmentValues{
    var scolloptions:ScollOptions{
        get{self[ScollOptionsKey.self]}
        set{self[ScollOptionsKey.self] = newValue}
    }
}

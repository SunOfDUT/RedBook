//
//  AnimationTest.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/24.
//

import SwiftUI

struct AnimationTest: View {
    @State var showit = false
    @State var showit2 = false
    var body: some View {
       // 1.解决if Animation消失的问题
        ZStack{
            RoundedRectangle(cornerRadius: 20)
        }
    }
}

struct AnimationTest_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTest()
    }
}

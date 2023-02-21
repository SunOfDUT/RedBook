//
//  BiJiView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/13.
//

import SwiftUI

struct BiJiView: View {
    var mypyq : [Carddata]
    @Binding var dragsize : CGFloat
    @Binding var  scrollsize : CGFloat
    @Binding var  scrollsizeall : CGFloat
    var body: some View {
        ScrollView{
            ScrollRead
//            SwiftUICollectionView(Array(mypyq.enumerated()),id: \.offset){ index,card in
//                PaperCard(card: card, index: index)
//            }
//            .girdStyle(colums: 2, spacing: 4, animation:.default)
//            .scollOptions(direction:.vertical)
//            .padding(2)
        }
    }
    
    var ScrollRead : some View{
        GeometryReader{ proxy in
            Color.clear
                .preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation {
                if  value < 290 {
                    dragsize = -50
                }else if value > 310{
                    dragsize = 50
                }
                
                if value > 321{
                    withAnimation {
                        scrollsize = value
                    }
                }else{
                    withAnimation {
                        scrollsize = 0
                    }
                }
                scrollsize = value
            }
        }
    }
}



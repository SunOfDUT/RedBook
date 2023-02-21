//
//  NavBar1.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/13.
//

import SwiftUI

struct NavBar1: View {
    @Binding var select : Int
    @Binding var isshow : Bool
    @State var  Lovetag : [String] = []
    var body: some View {
        HStack{
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:20){
                    ForEach(0..<Lovetag.count){ item in
                        Button{
                            select = item
                        }label: {
                            Text(Lovetag[item])
                                .foregroundColor(select == item ? .black : .gray)
                        }
                    }
                }
            }
            .foregroundColor(.black)
            .padding(.leading)
            
            Button{
                withAnimation{
                    isshow = true
                }
            }label: {
                Image(systemName: "chevron.down")
                    .padding(.trailing)
            }
            .foregroundColor(.black)
        }
        .padding(.bottom,8)
    }
}

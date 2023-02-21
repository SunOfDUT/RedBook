//
//  Test3.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/21.
//

import SwiftUI

struct Test3: View {
    @State var selcet = 1
    var body: some View {
        VStack{
            HStack{
                Button{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                        selcet = 0
                    }
                    
                }label: {
                    Text("关注")
                        .foregroundColor(selcet == 0 ? .black: .gray)
                }
                
                Button{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                        selcet = 1
                    }
                   
                }label:{
                    Text("发现")
                        .foregroundColor(selcet == 1 ? .black: .gray)
                }
                
                Button{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                        selcet = 2
                    }
                    
                }label: {
                    Text("附近")
                        .foregroundColor(selcet == 2 ? .black: .gray)
                }
            }
            .padding(.bottom,5)
            .overlay(
                HStack{
                    
                    if selcet == 2{
                        Spacer()
                    }
                    
                    VStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 30, height: 3)
                            .foregroundColor(Color("red"))
                    }
                    
                    if selcet == 0{
                        Spacer()
                    }
                }
                .padding(.horizontal,3)
            )
        }
    }
}

struct Test3_Previews: PreviewProvider {
    static var previews: some View {
        Test3()
    }
}

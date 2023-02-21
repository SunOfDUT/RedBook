//
//  SearchDetial3.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI

struct SearchDetial3: View {
    @State var selectSort = 0
    var body: some View {
        ScrollView(showsIndicators: false){
            HStack{
                Button{
                    withAnimation {
                        selectSort  = 0
                    }
                }label: {
                    Text("综合")
                        .font(.footnote)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10))
                }
                .foregroundColor(selectSort == 0 ? .black : .gray)
               
                Button{
                    withAnimation {
                        selectSort  = 1
                    }
                }label: {
                    Text("销量")
                        .font(.footnote)
                }
                .foregroundColor(selectSort == 1 ? .black : .gray)
                
                Spacer()
                
                Divider()
                
                Button{
                    withAnimation {
                        selectSort  = 2
                    }
                }label: {
                    Text("筛选")
                        .font(.footnote)
                    Image(systemName: "pin")
                        .font(.system(size: 10))
                }
                .foregroundColor(selectSort == 2 ? .black : .gray)
            }
            .frame(height:30)
            .padding(.horizontal)
            Spacer()
            // nearview
        }
    }
}

struct SearchDetial3_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetial3()
    }
}

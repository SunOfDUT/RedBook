//
//  SearchDetial2.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI

struct SearchDetial2: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            ForEach(0..<10){ item in
                HStack(alignment:.top){
                    Image("image4")
                        .CircleImage(width: 50)
                    VStack(alignment:.leading,spacing: 0){
                        Text("周杰伦粉丝会")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        HStack{
                            Text("小红号:")
                            Text("199928")
                        }
                        .font(.footnote)
                        
                        HStack{
                            Text("笔记.")
                            Text("18882")
                            
                            Divider()
                                .frame(height:10)
                            Text("粉丝.")
                            Text("8w")
                        }
                        .font(.footnote)
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button{
                        
                    }label: {
                        Text("关注")
                            .foregroundColor(Color("red"))
                            .padding(.vertical,5)
                            .padding(.horizontal,18)
                            .background(.white)
                            .padding(1)
                            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct SearchDetial2_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetial2()
    }
}

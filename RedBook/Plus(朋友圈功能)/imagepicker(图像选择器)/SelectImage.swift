//
//  SelectImage.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/10.
//

import SwiftUI

struct SelectImage: View {
    @Binding var Images : [myimage]
    @Binding var selectint : Int
    @State var showPublish : Bool = false
    @Binding var showplusview : Bool
    var body: some View{
        VStack{
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(Array(Images.enumerated()), id:\.offset){ count,img in
                        if img.ischeck{
                        Image(uiImage: img.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100,height: 100)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                            .overlay(
                                Button{
                                    withAnimation {
                                        Images[count].ischeck.toggle()
                                        selectint -= 1
                                    }
                                }label: {
                                    Image(systemName: "xmark")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(.black.opacity(0.5),in: Circle())
                                        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topTrailing)
                                        .padding(8)
                                }
                            )
                        }
                    }
                }
            }
            .padding(.bottom)
            
            HStack{
                Text("选择你想要发布的视频或照片")
                
                Spacer()
                
                Button{
                    withAnimation {
                        self.showPublish = true
                    }
                }label: {
                    Text("下一步")
                        .padding(.vertical,5)
                        .padding(.horizontal,15)
                        .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                }
            }
            .foregroundColor(.white)
        }
        .padding(.horizontal,5)
        .frame(height: UIScreen.main.bounds.height / 5)
        .background(.black)
        .fullScreenCover(isPresented: $showPublish) {
            PYQPublishView(images: GetPickeImage(images: self.Images))
        }
    }
}

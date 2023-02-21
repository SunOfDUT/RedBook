//
//  ConcernView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/13.
//

import SwiftUI


struct ConcernView: View {
    @Binding var isshow : Bool
    @Binding var showShare : Bool
    @Binding var showContend  : Bool
    @Binding var showaccountdetial : Bool
    @Binding var showanimation : [Bool]
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @State var Myconcernpyq : [Carddata] = []
    
//    func GetMyconcernPyq(){
//        if Myconcernpyq.isEmpty{
//            for item in Myclientdata.MyClient.concern{
//                for i in pyqdata.allPyqData{
//                    if i.objectid == item{
//                        self.Myconcernpyq.append(i)
//                    }
//                }
//            }
//        }
//        
//        self.Myconcernpyq = Myconcernpyq.sorted { car1, card2 in
//            car1.publishtime < card2.publishtime
//        }
//    }
    
    
    
    var body: some View {
            ScrollView{
                    // 关注
                    HStack{
                        Button{
                            withAnimation {
                                isshow = true
                            }
                        }label: {
                            VStack(spacing:0){
                                PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
                                    .mask(Circle())
                                    .frame(width: 60, height: 60)
                                Text("分享瞬间")
                                    .font(.footnote)
                            }
                        }
                        Spacer()
                    }
                    .padding(15)
                // 关注的人发的内容
                if Myconcernpyq.count == 0{
                    Text("--------你的关注还没有发动态哦--------")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .padding(.horizontal)
                }else{
                    ForEach(Myconcernpyq){ item in
                        ConcernCard(card: item, showShare: $showShare, showContend: $showContend, showaccountdetial: $showaccountdetial, showanimation: $showanimation)
                    }
                }
            }
            .foregroundColor(.black)
            .onAppear {
//                GetMyconcernPyq()
            }
    }
}


//
//struct ConcernView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConcernView(isshow: .constant(false),showShare: .constant(false),showContend: .constant(false),showaccountdetial: .constant(false))
//    }
//}

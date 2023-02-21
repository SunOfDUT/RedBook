//
//  ALlCard.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/18.
//

import SwiftUI







//struct AllCard : View{
//    var viewname : String
//    var namespace : Namespace.ID
//    @EnvironmentObject var mycarddatas : Model
//    @EnvironmentObject var pyqdata : PYQData
//    @EnvironmentObject var Myclientdata  : ClientData
//    @Binding var isshowdetial : Bool
//    @Binding var isscroll : Bool
//    @State var refresh : Bool = false
//    @State var currentpage : Int = 0
//    @State var maxHeight : CGFloat = 0
//    @State var scrollsize : CGFloat = 0
//
//    var body: some View{
//        ScrollView{
//            ScorllRead
//            SwiftUICollectionView(Array(pyqdata.allPyqData.enumerated()),id: \.offset) { index,card in
//                PaperCard(card: card, index: index)
//            }gridsize:{ gridheight in
//                maxHeight = gridheight
//            }
//            .girdStyle(colums: 2, spacing: 4, animation:.spring())
//            .scollOptions(direction:.vertical)
//            .padding(2)
//        }
//        .coordinateSpace(name: "scroll")
//        .onAppear {
//            self.pyqdata.downloading(currentpage:currentpage)
//        }
////        .overlay(
////            Text("\(scrollsize)")
////                .foregroundColor(.white)
////                .background(.red)
////        )
//    }
//
//    var ScorllRead : some View{
//        GeometryReader{ proxy in
//            Color.clear
//                .preference(key: ScrollPreferenceKey.self, value:proxy.frame(in: .named("scroll")).minY)
////            Text("\(proxy.frame(in: .named("scroll")).minY)")
//        }
//        .frame(height:0)
//        .onPreferenceChange(ScrollPreferenceKey.self) { value in
//            let newsize = currentpage == 0 ? maxHeight - (UIScreen.main.bounds.height + 220)*CGFloat((currentpage + 2)) : maxHeight - (UIScreen.main.bounds.height + 20)*CGFloat((currentpage + 2))
//            if value < CGFloat(newsize){
//               withAnimation {
//                   currentpage += 1
//                   DispatchQueue.global().async {
//                       pyqdata.downloading(currentpage: currentpage)
//                   }
//               }
//            }
//            scrollsize = value
//            print(newsize)
//            print(currentpage)
//        }
//    }
//}
//
//struct PaperCard : View{
////    var viewname : String
////    var namespace : Namespace.ID
//    var card : Carddata
//    var index : Int
//    var body: some View{
//        VStack{
//            NavigationLink{
//                CardDetial(index: index, card: card)
//                    .NavigationHidden()
//
//            }label: {
//                Card( index: index, card: card)
//                    .foregroundColor(.black)
//            }
//
//        }
//    }
//}

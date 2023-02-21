//
//  test9.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/24.
//
import SwiftUI
//struct test9: View{
//    @Namespace var namespace
//    @EnvironmentObject var pyqdata : PYQData
//    @State var showgood = false
//    var body: some View{
//            VStack{
//                if showgood{
//                    CardDetial(viewname: "1", index:0, card: pyqdata.allPyqData[0], showgood: $showgood, namespaceid: namespace)
//                        
//                        .animation(.default, value: showgood)
//                        .padding(.top)
//                }else{
//                   Card(viewname: "1", index:0,card: pyqdata.allPyqData[0], showgood: $showgood, namespaceid: namespace)
//                      
//                        .animation(.default, value: showgood)
//                }
//            }
//            .frame(width: showgood ? UIScreen.main.bounds.width:UIScreen.main.bounds.width / 2, height: showgood ? UIScreen.main.bounds.height:260)
//    }
//}

//    func columnWidth2(colunms:Int,spacing:CGFloat,geometry:CGSize) -> CGFloat{
//        let Allwidth = max(0, geometry.width - (spacing * CGFloat(colunms)) - 1)
//        return Allwidth / CGFloat(colunms)
//    }
//}
//
//
//struct ImagePointKey : PreferenceKey{
//    static var defaultValue: CGFloat = CGFloat()
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}
//
//
//
//struct SizeKeyValue : PreferenceKey{
//    static var defaultValue: CGSize = CGSize()
//    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
//        value = nextValue()
//    }
//}
//struct addproview : PreviewProvider{
//    static var previews: some View{
//        test9()
//    }
//}

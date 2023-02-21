//
//  RowView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/18.
//

import SwiftUI

struct RowView: View {
    @State var rowtag : [Tags] = []
//    @Binding var Lovetag : [String]
//    @Binding var isEditingMode : Bool
    @EnvironmentObject var mycarddatas : Model
    var body: some View {
    HStack{
        ForEach(0..<rowtag.count){ item in
                if !rowtag[item].isinlove{
                    Button{
                        withAnimation {
                            for i in 0..<mycarddatas.AllTags.count{
                                if mycarddatas.AllTags[i].tagtext == rowtag[item].tagtext{
                                    mycarddatas.AllTags[i].isinlove = true
                                }
                            }
                            rowtag[item].isinlove = true//                          
                        }
                    }label: {
                        HStack{
                            Text("+")
                            Text(rowtag[item].tagtext)
                        }
                        .ButtonStyleWhite()
                    }
                }
                    
                }
            }
        }
    }

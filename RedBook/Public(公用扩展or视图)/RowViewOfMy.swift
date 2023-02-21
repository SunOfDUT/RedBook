//
//  RowViewOfMy.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/18.
//

import SwiftUI

struct RowViewOfMy: View {
    var rowindex : Int = 0
    var selectindex : Int = 0
    @EnvironmentObject var mycarddatas : Model
    @State var rowtag : [Tags] = []
    @Binding var isEditingMode : Bool
    var body: some View {
        HStack{
            ForEach(0..<rowtag.count){ item in
                if item < 3 && rowindex == 1{
                    Button{
                        
                    }label: {
                        Text(rowtag[item].tagtext)
                            .ButtonStyleGray()
                    }
                }else{
                    if isEditingMode{
                        ZStack{
                            HStack{
                                Text(rowtag[item].tagtext)
                            }
                            .ButtonStyleWhite()
                            
                            Button{
                                withAnimation {
                                    
                                }
                            }label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 10))
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(.gray.opacity(0.3),in: Circle())
                            }
                            .offset(x: 45, y: -15)
                        }
                    }else{
                        HStack{
                            Text(rowtag[item].tagtext)
                        }
                        .ButtonStyleWhite()
                    }
                }
            }
        }
    }
}

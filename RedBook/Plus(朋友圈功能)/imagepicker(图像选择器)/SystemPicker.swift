//
//  ImagePickerDetial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/10.
//
import SwiftUI
import Photos

struct myimage : Identifiable,Equatable{
    var id = UUID()
    var image : UIImage?
    var ischeck : Bool
    var assset : PHAsset?
    var imagedata : Data?
}
struct ImagePickerDetial : View{
    var Viewname : String
    var number : Int
    @State var images : [myimage]
    //每次最多可选择的照片数量
    @State var maxSelected:Int = 0
    @State var pickimages : [myimage] = []
    @State var Columns = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 55, alignment: .center), count: 4)
    @Binding var showpluseview : Bool
    @State var showalert : Bool = false
    @State var showChoice = false
    
    init(Viewname: String,images:[myimage],number:Int,showplusview:Binding<Bool>){
        self.Viewname = Viewname
        self.number = number
        self.images = images
        self._showpluseview = showplusview
    }
    
    var body: some View{
        ZStack{
            VStack{
                // 很多图片
                ScrollView{
                    LazyVGrid(columns:Columns){
                        ForEach(Array(images.enumerated()), id:\.offset){ count,index in
                            Image(uiImage:index.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width / 4 - 5,height: UIScreen.main.bounds.width / 4 - 5)
                                .clipped()
                                .onTapGesture {
                                    withAnimation {
                                        if self.maxSelected < 9{
                                            if images[count].ischeck{
                                                self.maxSelected -= 1
                                            }else{
                                                self.maxSelected += 1
                                            }
                                            images[count].ischeck.toggle()
                                        }else{
                                            if images[count].ischeck{
                                                self.maxSelected -= 1
                                                images[count].ischeck.toggle()
                                            }else{
                                                withAnimation {
                                                    self.showalert = true
                                                }
                                            }
                                        }
                                    }
                                }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Image(index.ischeck ? "CellBlueSelected":"CellGreySelected")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:30, height:30)
                                                .scaleEffect(index.ischeck ? 1.1:0.8)
                                           
                                        }
                                        Spacer()
                                    }
                                    .padding(5)
                                )
                        }
                    }
                }
                if self.maxSelected != 0{
                    SelectImage(Images: $images,selectint: $maxSelected,showplusview:$showpluseview)
                }
            }
            }
            .onDisappear(perform: {
                withAnimation {
                    self.maxSelected = 0
                }
            })
            .onChange(of: self.maxSelected, perform: { newvalue in
                self.pickimages = GetPickeImage(images: self.images)
                if self.maxSelected != 0{
                    withAnimation {
                        showChoice = true
                    }
                   
                }else if self.maxSelected == 0{
                    withAnimation {
                        showChoice = false
                    }
                }
            })
            .alert(isPresented: $showalert) {
                Alert(title: Text("最多不能超过9张"), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定"),action: {
                    showalert = false
            }))
        }
    }
}

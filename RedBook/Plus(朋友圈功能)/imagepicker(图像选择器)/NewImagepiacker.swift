//
//  old.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/11.
//

import SwiftUI
import Photos

struct oldImagePickerDetial : View{
    var Viewname : String
    var number : Int
    //取得的资源结果，用了存放的PHAsset
    var assetsFetchResults:PHFetchResult<PHAsset>?
    //带缓存的图片管理对象
    var imageManager:PHCachingImageManager
    //缩略图大小
    var assetGridThumbnailSize:CGSize!
    var mediaType : PHAssetMediaType
    //每次最多可选择的照片数量
    @State var maxSelected:Int = 0
    @State var images : [myimage] = []
    @Binding var pickimages : [myimage]
    @State var Columns = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 55, alignment: .center), count: 4)
    @Binding var showpluseview : Bool
    @State var showalert : Bool = false
    @State var showChoice = false
    @EnvironmentObject var Myclientdata  : ClientData
    @State var currentpage = 0
    @State var scrollsize : CGFloat = 0
    
    init(Viewname: String, assetsFetchResults: PHFetchResult<PHAsset>?,number:Int,pickimages:Binding<[myimage]>,mediaType:PHAssetMediaType,showplusview:Binding<Bool>){
        let scale = UIScreen.main.scale
        self.assetGridThumbnailSize = CGSize(width: (UIScreen.main.bounds.width / 4 - 5)*scale ,
                                        height: (UIScreen.main.bounds.width / 4 - 5)*scale)
        self.mediaType = mediaType
        self.Viewname = Viewname
        self.assetsFetchResults = assetsFetchResults
        self.number = number
        self._pickimages = pickimages
        self._showpluseview = showplusview
        self.imageManager = PHCachingImageManager()
        self.imageManager.allowsCachingHighQualityImages = true
        self.stopCaching()
    }
    
    func stopCaching() {
        imageManager.stopCachingImagesForAllAssets()
    }
    
    func SetImageView(page:Int){
//        var returnimage : UIImage = UIImage()
            if page == 0{
                withAnimation {
                   self.images = []
                }
            }
          let current = page * 28
          let nextcurrent = (page+1) * 28
          let options = PHImageRequestOptions()
          options.resizeMode = .exact
          options.deliveryMode = .highQualityFormat
          options.isSynchronous = true
            for i in current..<nextcurrent{
            guard i < self.assetsFetchResults?.count ?? 0 else {return}
            let asset = self.assetsFetchResults![i]
                if mediaType == .unknown{
                     self.imageManager.requestImage(for:asset,targetSize:self.assetGridThumbnailSize, contentMode: .aspectFill, options: options) { (image, nfo) in
                        withAnimation {
                            self.images.append(myimage(image: image ?? UIImage(), ischeck: false, assset: asset))
                        }
                    }
                }
                else{
                    if asset.mediaType == self.mediaType{
                        self.imageManager.requestImage(for:asset, targetSize:self.assetGridThumbnailSize, contentMode: .aspectFill, options: options) { (image, nfo) in
                            withAnimation {
                                self.images.append(myimage(image: image ?? UIImage(), ischeck: false, assset: asset))
                            }
                        }
                    }
                }
        }
        print(images.count)
    }
    
    var body: some View{
        ZStack{
            VStack{
//                 很多图片
                ScrollView{
                    scrollread
                    LazyVGrid(columns:Columns){
                        ForEach(Array(images.enumerated()), id:\.offset){ count,index in
                            Image(uiImage:index.image ?? UIImage())
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
                .coordinateSpace(name: "scoll")
//                .overlay(
//                    Text("\(scrollsize)")
//                        .foregroundColor(.white)
//                        .background(.red)
//                )
                
                if self.maxSelected != 0{
                    SelectImage(Images: $images,selectint: $maxSelected,showplusview:$showpluseview)
                }
                }
            }
            .onDisappear(perform: {
                withAnimation {
                    self.maxSelected = 0
                    do{
                        self.images = []
                    }
                    self.currentpage = 0
                }
            })
            .onAppear(perform: {
                DispatchQueue.global().async {
                    self.SetImageView(page:0)
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
    
    var scrollread : some View{
        GeometryReader{ proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value:proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation {
               let rowsize = UIScreen.main.bounds.width / 4
               let currentpageheight = currentpage < 5 ? 122 - currentpage * Int(rowsize * 8 ) : 122 - currentpage * Int(rowsize * 7.5)
               let newsize =  currentpage < 3 ? currentpageheight - Int(rowsize / 2 - CGFloat((20) * currentpage)) : (currentpageheight + (20) * currentpage)
                   if value < CGFloat(newsize){
                       withAnimation {
                           currentpage += 1
                           DispatchQueue.global().async {
                             self.SetImageView(page:currentpage)
                           }
                       }
                   }
            }
        }
    }
}

func GetPickeImage(images:[myimage])->[myimage]{
   var pickimage : [myimage] = []
   for i in images{
       if i.ischeck{
           pickimage.append(i)
       }
   }
   return pickimage
}

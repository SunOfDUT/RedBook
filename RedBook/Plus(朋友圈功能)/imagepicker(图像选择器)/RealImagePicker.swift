//
//  RealImagePicker.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/9.
//

import SwiftUI
import Photos

struct RealImagePicker: View {
    @Binding var  showplusview : Bool
    @State var isshowdetial2 = false
    @State var pickimages : [myimage] = []
    @State var select = 0
    
    //相簿列表项集合
    @State var items:[ImageAlbumItem] = []

    @State var isshowdetial = false
    @State var selectAlbum : ImageAlbumItem = ImageAlbumItem(number: 0, fetchResult: PHFetchResult<PHAsset>.init())
    var imageManager:PHCachingImageManager = PHCachingImageManager()
    // 调用一个方法 获取到我们手机里面所有的合集 以及合集里面的照片 还有
    @State var isshow = false
//    var assetGridThumbnailSize = CGSize(width: (UIScreen.main.bounds.width / 4 - 5)*(UIScreen.main.scale) ,
//                                        height: (UIScreen.main.bounds.width / 4 - 5)*(UIScreen.main.scale))
    
    func GetImage(){
        self.items = []
        PHPhotoLibrary.requestAuthorization{ status in
            // 告诉用户我们需要获取它图库的权限
            guard status == .authorized else {return}
            let smartOptions = PHFetchOptions()
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular,options: smartOptions)
            // 系统默认
            self.convertCollection(collection: smartAlbums)
            // 自己创建的合集
            let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            self.convertCollection(collection: userCollections as! PHFetchResult<PHAssetCollection>)
            self.items.sort{ (item1, item2) -> Bool in
                return item1.fetchResult.count > item2.fetchResult.count
            }
            self.selectAlbum = items[0]
        }
    }
    
    func convertCollection(collection: PHFetchResult<PHAssetCollection>){
        for i in 0..<collection.count{
                //获取出但前相簿内的图片
                let resultsOptions = PHFetchOptions()
                resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                                   ascending: false)]
//                resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
//                                                       PHAssetMediaType.image.rawValue)
                let c = collection[i]
                let assetsFetchResult = PHAsset.fetchAssets(in: c , options: resultsOptions)
                //没有图片的空相簿不显示
                if assetsFetchResult.count > 0 {
                    
                    let title = titleOfAlbumForChinse(title: c.localizedTitle)
                    
                    self.items.append(ImageAlbumItem(number: assetsFetchResult.count, title: title, fetchResult: assetsFetchResult))
                }
            }
    }
    
    private func titleOfAlbumForChinse(title:String?) -> String? {
        if title == "Slo-mo" {
            return "慢动作"
        } else if title == "Recently Added" {
            return "最近添加"
        } else if title == "Favorites" {
            return "个人收藏"
        } else if title == "Recently Deleted" {
            return "最近删除"
        } else if title == "Videos" {
            return "视频"
        } else if title == "All Photos" {
            return "所有照片"
        } else if title == "Selfies" {
            return "自拍"
        } else if title == "Screenshots" {
            return "屏幕快照"
        } else if title == "Camera Roll" {
            return "相机胶卷"
        } else if title == "Recents" {
            return "最近项目"
        }
        return title
    }
    
    func GetfristImage(asset:PHAsset) -> UIImage{
          var fistimage = UIImage()
          let options = PHImageRequestOptions()
          options.resizeMode = .exact
          options.deliveryMode = .highQualityFormat
          options.isSynchronous = true
         self.imageManager.requestImage(for:asset, targetSize:UIScreen.main.bounds.size, contentMode: .aspectFit, options: options) { (image, nfo) in
                fistimage = image ?? UIImage()
          }
         return fistimage
    }
    
    var body: some View {
            VStack{
                HStack(alignment:.top){
                    Button{
                        withAnimation {
                            self.showplusview = false
                        }
                    }label: {
                        Image(systemName: "xmark")
                    }
                   
                   Spacer()
                
                   Button{
                       withAnimation {
                           isshowdetial2.toggle()
                       }
                   }label: {
                       HStack{
                           if selectAlbum.title != nil{
                               Text(selectAlbum.title!)
                                   .padding(.trailing,2)
                           }
                           
                           Image(systemName: isshowdetial2 ? "chevron.up":"chevron.down")
                               .font(.footnote)
                       }
                   }
                   .padding(.bottom,2)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.bottom,5)
                
                
                Divider()
                    .foregroundColor(.white)
                
                if !isshowdetial2{
                VStack{
                HStack{
                    Spacer()
                    Button{
                        withAnimation {
                            select = 0
                        }
                    }label: {
                        Text("全部")
                    }
                    .foregroundColor(select == 0 ? .white:.gray)
                    Spacer()
                    Button{
                        withAnimation {
                            select = 1
                        }
                    }label: {
                        Text("视频")
                    }
                    .foregroundColor(select == 1 ? .white:.gray)
                    Spacer()
                    Button{
                        withAnimation {
                            select = 2
                        }
                    }label: {
                        Text("照片")
                    }
                    .foregroundColor(select == 2 ? .white:.gray)
                    Spacer()
                }
                .padding(.bottom,5)
                
                // 照片 --> imagedetial
              
                if selectAlbum.title != nil{
                    TabView(selection:$select){
                        oldImagePickerDetial(Viewname: selectAlbum.title!, assetsFetchResults:  selectAlbum.fetchResult,number: selectAlbum.number, pickimages: $pickimages, mediaType: .unknown,showplusview: $showplusview)
                            .tag(0)
                        oldImagePickerDetial(Viewname:  selectAlbum.title!, assetsFetchResults:  selectAlbum.fetchResult,number: selectAlbum.number, pickimages: $pickimages, mediaType: .video,showplusview: $showplusview)
                            .tag(1)
                        oldImagePickerDetial(Viewname:  selectAlbum.title!, assetsFetchResults:  selectAlbum.fetchResult,number: selectAlbum.number, pickimages: $pickimages, mediaType: .image,showplusview: $showplusview)
                            .tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                }
                .animation(.default, value: self.showplusview)
                }else{
                    ScrollView{
                        VStack{
                            ForEach(Array(items.enumerated()), id:\.offset){ count,index in
                                HStack{
                                    Image(uiImage: GetfristImage(asset: index.fetchResult.firstObject!))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width / 4 - 5,height: UIScreen.main.bounds.width / 4 - 5)
                                        .clipped()
                                    
                                    Text(index.title!)
                                        .foregroundColor(.white)
                                    Text("(\(index.number))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .onTapGesture {
                                    withAnimation {
                                        self.selectAlbum = index
                                        self.isshowdetial2 = false
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                    .background(.black)
                    .transition(.offset(x: 0, y: -UIScreen.main.bounds.height))
                    .opacity(self.showplusview ? 1:0)
                    .animation(.default, value: self.showplusview)
                }
                
                Spacer()
            }
            .background(.black)
            .onAppear {
                DispatchQueue.global(qos:.background).async{
                    GetImage()
                }
            }
    }
}


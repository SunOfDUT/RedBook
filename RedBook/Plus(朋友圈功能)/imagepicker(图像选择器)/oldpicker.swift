//
//  NewImagepiacker.swift
//  Teachin
//
//Created by 孙志雄 on 2022/8/8.
import SwiftUI
import Photos


// 模版
struct ImageAlbumItem : Identifiable,Equatable{
    var id = UUID()
    var number : Int
    var title : String?
    var fetchResult : PHFetchResult<PHAsset>
}
// 制作一个imagepickerlist --
struct ImagePickerList : View{
    //相簿列表项集合
    @State var items:[ImageAlbumItem] = []
    @State var pickimages : [myimage] = []
    
    // 调用一个方法 获取到我们手机里面所有的合集 以及合集里面的照片 还有
    
   //每次最多可选择的照片数量
    @State var maxSelected:Int = Int.max
    
    @State var isshow = false
    
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
        }
        return title
    }
    
    var body: some View{
        NavigationView{
//            List{
//                if pickimages != []{
//                    ScrollView(.horizontal,showsIndicators: false){
//                        HStack{
//                            ForEach(pickimages){ item in
//                                Image(uiImage: item)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: UIScreen.main.bounds.width / 4 - 5,height: UIScreen.main.bounds.width / 4 - 5)
//                                    .clipped()
//                            }
//                        }
//                    }
//                }
//
//                ForEach(items){ index in
//                    NavigationLink{
//                        ImagePickerDetial(Viewname: index.title!, assetsFetchResults: index.fetchResult,number:index.number, pickimages: $pickimages, mediaType: .image)
//                            .NavigationHidden()
//                    }label:{
//                        HStack{
//                            Text(index.title!)
//                            Text("(\(index.number))")
//                                .font(.footnote)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//            }
//            .listStyle(.grouped)
        }
        .navigationTitle("相册")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            DispatchQueue.main.async{
               GetImage()
            }
        }
    }
}



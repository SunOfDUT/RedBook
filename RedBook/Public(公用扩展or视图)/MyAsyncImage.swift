//
//  MyAsyncImage.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/6.
//

import SwiftUI
import Foundation
import Combine
import UIKit

// view 和 逻辑是分开写的
struct MyAsyncImage<Placeholder:View> : View{
    @StateObject private var loader : ImageLoader
    private let contentmode : Bool
    private let placeholder : Placeholder
    // 最后呈现的出来image
    private let image : (UIImage) -> Image
//    view定义好了
    init(
        url:URL,
        // 非逃逸闭包
        contentmode : Bool,
        @ViewBuilder placeholder : ()->Placeholder,
        // 逃逸闭包 --> 返回一个处理好的对象 callback函数
        @ViewBuilder image : @escaping (UIImage) -> Image = Image.init(uiImage:)
    ){
        self.contentmode =  contentmode
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue:ImageLoader(url: url, cathe: Environment(\.imageCathe).wrappedValue))
       
    }
    
    var body: some View{
        Group{
            if loader.image != nil{
                image(loader.image!)
                    // 定义公用的image修饰符
                    .resizable()
                    .aspectRatio(contentMode:contentmode ? .fill:.fit)
            }else{
                placeholder
            }
        }
        .onAppear {
            loader.Load()
        }
    }
}

// 我们定义了一个缓存结构 --> <Key,Value> --> <environmentKey,environmentvalue>
struct ImageCatheKey : EnvironmentKey{
    static let defaultValue : ImageCathe = CatheTemporary()
}

extension EnvironmentValues{
    var imageCathe : ImageCathe{
        get{self[ImageCatheKey.self]}
        set{self[ImageCatheKey.self] = newValue}
    }
}

protocol ImageCathe{
    subscript(_ url:URL) -> UIImage? {get set}
}

// 定义一个缓存的结构
struct CatheTemporary : ImageCathe{
    // cache对象
    private let cache = NSCache<NSURL,UIImage>()
    subscript(_ key: URL) -> UIImage? {
        // 从外界获得url转化到我们的NScahe里面的键值对象
        get{cache.object(forKey: key as NSURL)}
        set{newValue == nil ? cache.removeObject(forKey: key as NSURL):cache.setObject(newValue!, forKey: key as NSURL)
    }
 }
}
// 定义一下我们的加载逻辑
class ImageLoader : ObservableObject{
    @Published var image : UIImage?
    private(set) var isLoading = false
    private var url : URL
    private var cathe : ImageCathe?
    private var cancellable : AnyCancellable?
    private static var imageProcessing = DispatchQueue(label: "image-processing")
    
    init(url : URL,cathe:ImageCathe? = nil){
        self.url = url
        self.cathe = cathe
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func Load(){
        // 定义我们真正的加载逻辑
        guard !isLoading else {return}
        
        if let image = cathe?[url] {
            // 如果我们通过外来的url来去在我们的imagecathe里面搜索对应的键值 如果搜索成功 直接返回
            self.image = image
            return
        }
        
        // 下面里面我们需要去定义和远端服务器通讯过程
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map{
                UIImage(data: $0.data)
            }
            .replaceError(with: nil)
        // 进程的完成指标
            .handleEvents(receiveSubscription: {
                [weak self] _ in self?.onStart()
            }, receiveOutput: {
                [weak self] in self?.cache($0)
            }, receiveCompletion: {
                [weak self] _ in self?.onFinish()
            }, receiveCancel:{
                [weak self] in self?.onFinish()
            })
            .subscribe(on:ImageLoader.imageProcessing)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] in self?.image = $0}
    }
    func onStart(){
        isLoading = true
    }
    func onFinish(){
        isLoading = false
    }
    
    func cache(_ image:UIImage?){
        // 存储我们的cache
        image.map{
            cathe?[url] = $0
        }
    }
}

//
//  TmpSaveObjectData.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/10.
//

import SwiftUI
import Photos


func initSaveObject()-> saveobject{
    var output : saveobject = saveobject(mysavedimage: [], mypyqmessage: Carddata(title: "", content: "", locate: "", publishtime: Date(), publishimageurl: [], pinlun: [], love: 0, star: 0, pyqobjectid: "", client:  Client(username: "", clientname: "", introduce: "", sex: "", locate: "", clientimage: "", clienbakground: "", school: "", brithday: Date(), profession: "")))
    if let datastore = UserDefaults.standard.object(forKey: "TmpSavedobjects") as? Data{
        let data = try! decoder.decode(saveobject.self, from: datastore)
        output = data
    }
    return output
}

class SaveobjectData : ObservableObject{
    @Published var Saveobjects : saveobject
    var imageManager:PHCachingImageManager = PHCachingImageManager()
    
    init(SaveObject : saveobject){
        self.Saveobjects = SaveObject
    }
    
    func convert(image:[myimage]) -> [saveimage]{
        var img : [saveimage] = []
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        for i in image{
            self.imageManager.requestImageDataAndOrientation(for: i.assset!, options: options){data, asdi, asdb, asdc in
                guard data != nil else {return}
                img.append(saveimage(image:i.image?.pngData() ?? Data(), ischeck: i.ischeck,origrinimage:data!))
            }
           
        }
        return img
    }
    
    func convert2(images:[saveimage]) -> [myimage]{
        var img : [myimage] = []
        for i in images{
            img.append(myimage(image:UIImage(data:i.image) ?? UIImage(), ischeck: i.ischeck,assset:nil,imagedata:i.origrinimage))
        }
        return img
    }

    func saveMyPyq(){
        let datastore = try! encoder.encode(self.Saveobjects)
        UserDefaults.standard.set(datastore, forKey: "TmpSavedobjects")
    }
}

struct saveobject :Identifiable,Codable,Equatable{
    var id = UUID()
    var mysavedimage : [saveimage]
    var mypyqmessage : Carddata
}

struct saveimage : Identifiable,Codable,Equatable{
    var id = UUID()
    var image : Data
    var ischeck : Bool
    var origrinimage : Data
}

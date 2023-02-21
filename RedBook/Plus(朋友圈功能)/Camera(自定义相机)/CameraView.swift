//
//  CameraView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/9.
//

import SwiftUI
import AVFoundation

// 有一个预览界面 + 拍照键 + 功能键.....
struct CameraView : View{
    @StateObject var Camera : CameraModel = CameraModel()
    @Binding var  showplusview : Bool
    var body: some View{
        ZStack{
            //预览界面
            CameraPreview(camera: Camera)
                .ignoresSafeArea(.all)
            
            VStack{
                HStack(alignment:.top){
                   
                  
                    Button{
                        withAnimation {
                            self.showplusview = false
                        }
                    }label: {
                        Image(systemName: "xmark")
                            .padding(8)
                            .background(.white,in: Circle())
                    }
                   
                    Spacer()
                    
                       Button{
                           Camera.ChangeWH()
                       }label: {
                            Text("3:4")
                                .padding(8)
                                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                        }
                    Spacer()
                    
                    
                    if Camera.isback{
                        Button{
                            Camera.OpenFlash()
                        }label: {
                            Image(systemName: Camera.isflash ?  "bolt.circle":"bolt.slash.circle")
                              .padding(8)
                              .background(.white,in: Circle())
                        }
                    }else{
                        Image(systemName: "bolt.slash.circle")
                          .padding(8)
                          .background(.gray,in: Circle())
                    }
                      
                        Spacer()
                    
                      Button{
                          Task {
                             await Camera.ChangeCam()
                          }
                         
                      }label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .padding(8)
                            .background(.white,in: Circle())
                      }
                   
                }
                .foregroundColor(.black)
                .padding(10)
                .font(.system(size:17))
                .background(.black)
                
                Spacer()
                
                HStack{
                    
                    
                    if Camera.isTaken{
                        Button{
                            Camera.Restart()
                        }label: {
                            Text("取消")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    if !Camera.isTaken{
                        Button{
                            Camera.takePic()
                        }label: {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width:60)
                        }
                    }else{
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width:60)
                    }
                  
                    Spacer()
                    
                    if Camera.isTaken{
                        Button{
                            if !Camera.isSaved{
                                Camera.SavePic()
                            }
                        }label: {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.white)
                                .frame(width:40,height: 40)
                                .background(.gray,in: Circle())
                        }
                    }
                }
                .frame(height:UIScreen.main.bounds.height / 4 - 50)
                .padding(.horizontal)
                .background(.black)
               
                
            // 自定义界面
        }
        .onAppear {
            Camera.Check()
        }
        .onDisappear(perform: {
            Camera.ShutDown()
        })
        .alert(isPresented: $Camera.isSaved) {
            Alert(title: Text("保存成功"), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定"),action: {
                Camera.Restart()
        }))
       
    }
 }
}
}
class CameraModel:NSObject,ObservableObject,AVCapturePhotoCaptureDelegate{
    @Published var session = AVCaptureSession()
    
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    @Published var output = AVCapturePhotoOutput()
    
    @Published var isTaken : Bool = false
    
    @Published var isSaved : Bool = false
    
    @Published var picData : Data  = Data()
    
    @Published var setting:AVCapturePhotoSettings?
    
    @Published var device:AVCaptureDevice!//获取设备:如摄像头
    
    @Published var input:AVCaptureDeviceInput!//输入流
    
    @Published var isflash : Bool = false
    
    @Published var isback : Bool = true
    
    @Published var iswaiting : Bool = false
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                // 启动
                self.SetUp()
                return
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { (Status) in
                    if Status{
                        // 启动
                        self.SetUp()
                    }
                }
                return
            case .denied:
                return
            default:
                return
        }
    }
    
    func ShutDown(){
        self.session.stopRunning()
        self.session.beginConfiguration()
        self.session.removeInput(self.input)
        self.session.removeOutput(self.output)
        self.session.commitConfiguration()
    }
    
    func SetUp(){
        do{
            self.session.beginConfiguration()
            self.device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
               //照片输出设置
            self.setting = AVCapturePhotoSettings.init(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
          //用输入设备初始化输入
            self.input = try AVCaptureDeviceInput(device: self.device!)
            if(self.session.canAddInput(self.input)){
                self.session.addInput(self.input)
          }
            if(self.session.canAddOutput(self.output)){
                self.session.addOutput(self.output)
           }
            self.session.commitConfiguration()
            self.session.startRunning()
        }catch{
            print(error)
        }
    }
    
    func Restart(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken = false
                    self.isSaved = false
                }
            }
        }
    }
    
    func ChangeCam()async{
        do{
            if self.device.position == .back{
                let device = AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front)
                self.session.beginConfiguration()
                self.session.removeInput(self.input)
                let newinput = try AVCaptureDeviceInput(device: device!)
                if(self.session.canAddInput(newinput)){
                    self.session.addInput(newinput)
                }
                self.session.commitConfiguration()
                self.input = newinput
                self.device = device!
                self.isback = false
            }else{
                let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
                self.session.beginConfiguration()
                self.session.removeInput(self.input)
                let newinput = try AVCaptureDeviceInput(device: device!)
                if(self.session.canAddInput(newinput)){
                    self.session.addInput(newinput)
                }
                self.session.commitConfiguration()
                self.input = newinput
                self.device = device!
                self.isback = true
            }
        }catch{
            print(error)
        }
    }
    
    func ChangeWH(){
        
    }
    
    func OpenFlash(){
        self.isflash = !self.isflash//改变闪光灯
        try? self.device.lockForConfiguration()
        if(self.isflash){//开启
            self.device.torchMode = .on
           }else{//关闭
               if self.device.hasTorch {
                   self.device.torchMode = .off//关闭闪光灯
               }
           
           }
        self.device.unlockForConfiguration()
    }
   
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
           let imagedata  =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
           self.picData = imagedata!
    }
    
    func takePic(){
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken = true
                }
            }
        }
    }
    
    func SavePic(){
        let image = UIImage(data: self.picData)!
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
       self.isSaved = true
       print("Saved Successfully...")
    }
}

struct CameraPreview : UIViewRepresentable{
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) ->  UIView {
        let UIView = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = UIView.frame
        camera.preview.videoGravity = .resizeAspectFill
        UIView.layer.addSublayer(camera.preview)
        camera.session.startRunning()
        return UIView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        return
    }
}

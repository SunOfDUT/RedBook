//
//  RecordingView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/9.
//

import SwiftUI
import AVFoundation

// 有一个预览界面 + 拍照键 + 功能键.....
//struct RecordingView : View{
//    @StateObject var Camera : RecordVideo = RecordVideo()
//    var body: some View{
//        ZStack{
//            //预览界面
//            RecordPreview(camera: Camera)
//                .ignoresSafeArea(.all)
//
//            VStack{
//                HStack(alignment:.top){
//
//
//                    Button{
//
//                    }label: {
//                        Image(systemName: "xmark")
//                            .padding(8)
//                            .background(.white,in: Circle())
//                    }
//                   Spacer()
//                  Button{
//                      Task {
//                         await Camera.ChangeCam()
//                      }
//
//                  }label: {
//                    Image(systemName: "arrow.triangle.2.circlepath.camera")
//                        .padding(8)
//                        .background(.white,in: Circle())
//                  }
//
//                }
//                .foregroundColor(.white)
//                .padding(10)
//                .font(.system(size:17))
//
//                Spacer()
//
//                HStack{
//                    Spacer()
//
//
//                    Button{
//                        Camera.isRecording.toggle()
//                    }label: {
//                        if Camera.isRecording{
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(.red)
//                                .frame(width: 50, height: 50)
//                        }else{
//                            Circle()
//                                .foregroundColor(.gray)
//                                .frame(width:60)
//
//                            Button{
//
//                            }label: {
//                                VStack{
//                                    Image(systemName: "xmark")
//                                        .foregroundColor(.white)
//                                    Text("取消")
//                                }
//                            }
//
//
//                            Button{
//
//                            }label: {
//                                VStack{
//                                    Image(systemName: "checkmark")
//                                        .foregroundColor(.white)
//                                        .padding(10)
//                                        .background(.red)
//                                    Text("拍好了")
//                                }
//                            }
//                        }
//                    }
//
//                    Spacer()
//                }
//                .frame(height:UIScreen.main.bounds.height / 4 - 50)
//                .padding(.horizontal)
//                .background(.black)
//
//
//            // 自定义界面
//        }
//        .onAppear {
//            Camera.Check()
//        }
//        .alert(isPresented: $Camera.isSaved) {
//            Alert(title: Text("保存成功"), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定"),action: {
//                Camera.Restart()
//        }))
//
//    }
// }
//}
//}
//class RecordVideo:NSObject,ObservableObject,AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate{
//
//    @Published var session = AVCaptureSession()
//
//    @Published var preview : AVCaptureVideoPreviewLayer!
//
//    @Published var output = AVCaptureMovieFileOutput()
//
//    @Published var isRecording : Bool = false
//
//    @Published var isSaved : Bool = false
//
//    @Published var picData : Data  = Data()
//
//    @Published var setting:AVCapturePhotoSettings?
//
//    @Published var device:AVCaptureDevice!//获取设备:如摄像头
//
//    @Published var input:AVCaptureDeviceInput!//输入流
//
//    @Published var isflash : Bool = false
//
//    @Published var isback : Bool = true
//
//    @Published var iswaiting : Bool = false
//
    
    //保存所有的录像片段数组
//       var videoAssets = [AVAsset]()
//       //保存所有的录像片段url数组
//       var assetURLs = [String]()
//       //单独录像片段的index索引
//       var appendix: Int32 = 1
//
//       //最大允许的录制时间（秒）
//       let totalSeconds: Float64 = 15.00
//       //每秒帧数
//       var framesPerSecond:Int32 = 30
//       //剩余时间
//       var remainingTime : TimeInterval = 15.0
//
//       //表示是否停止录像
//       var stopRecording: Bool = false
//       //剩余时间计时器
//       var timer: Timer?
//       //进度条计时器
//       var progressBarTimer: Timer?
//       //进度条计时器时间间隔
//       var incInterval: TimeInterval = 0.05
//       //进度条
//       var progressBar: UIView = UIView()
//       //当前进度条终点位置
//       var oldX: CGFloat = 0
//       //录制、保存按钮
//       var recordButton, saveButton : UIButton!
//      //视频片段合并后的url
//      var outputURL: NSURL?
//
//    func Check(){
//        switch AVCaptureDevice.authorizationStatus(for: .video){
//            case .authorized:
//                // 启动
//                self.SetUp()
//                return
//
//            case .notDetermined:
//                AVCaptureDevice.requestAccess(for: .video) { (Status) in
//                    if Status{
//                        // 启动
//                        self.SetUp()
//                    }
//                }
//                return
//            case .denied:
//                return
//            default:
//                return
//        }
//    }
//
//    func SetUp(){
//        do{
//            self.session.beginConfiguration()
//            self.device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
//               //照片输出设置
//            self.setting = AVCapturePhotoSettings.init(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
//          //用输入设备初始化输入
//            self.input = try AVCaptureDeviceInput(device: self.device!)
//            if(self.session.canAddInput(self.input)){
//                self.session.addInput(self.input)
//          }
//            if(self.session.canAddOutput(self.output)){
//                self.session.addOutput(self.output)
//           }
//            let audioCaptureDevice = AVCaptureDevice.default(for: .audio)
//            let audioInput = try AVCaptureDeviceInput.init(device: audioCaptureDevice!)
//            if(self.session.canAddInput(audioInput)){
//                self.session.canAddInput(audioInput)
//            }
//            self.session.commitConfiguration()
//        }catch{
//            print(error)
//        }
//    }
//
//    func Restart(){
//        DispatchQueue.global(qos: .background).async {
//            self.session.startRunning()
//            DispatchQueue.main.async {
//                withAnimation {
//                    self.isRecording = false
//                    self.isSaved = false
//                }
//            }
//        }
//    }
//
//    func ChangeCam()async{
//        do{
//            if self.device.position == .back{
//                let device = AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front)
//                self.session.beginConfiguration()
//                self.session.removeInput(self.input)
//                let newinput = try AVCaptureDeviceInput(device: device!)
//                if(self.session.canAddInput(newinput)){
//                    self.session.addInput(newinput)
//                }
//                self.session.commitConfiguration()
//                self.input = newinput
//                self.device = device!
//                self.isback = false
//            }else{
//                let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
//                self.session.beginConfiguration()
//                self.session.removeInput(self.input)
//                let newinput = try AVCaptureDeviceInput(device: device!)
//                if(self.session.canAddInput(newinput)){
//                    self.session.addInput(newinput)
//                }
//                self.session.commitConfiguration()
//                self.input = newinput
//                self.device = device!
//                self.isback = true
//            }
//        }catch{
//            print(error)
//        }
//    }
//
//
//
//    func OpenFlash(){
//        self.isflash = !self.isflash//改变闪光灯
//        try? self.device.lockForConfiguration()
//        if(self.isflash){//开启
//            self.device.torchMode = .on
//           }else{//关闭
//               if self.device.hasTorch {
//                   self.device.torchMode = .off//关闭闪光灯
//               }
//
//           }
//        self.device.unlockForConfiguration()
//    }
//
//
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
//           let imagedata  =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
//           self.picData = imagedata!
//    }
//
//    func StartRecord(){
//        if(!isRecording) {
//           let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
//                                                           .userDomainMask, true)
//           let documentsDirectory = paths[0] as String
//           let outputFilePath = "\(documentsDirectory)/output-\(appendix).mov"
//           appendix += 1
//           let outputURL = NSURL(fileURLWithPath: outputFilePath)
//           let fileManager = FileManager.default
//           if(fileManager.fileExists(atPath: outputFilePath)) {
//               do {
//                   try fileManager.removeItem(atPath: outputFilePath)
//               } catch _ {
//               }
//           }
//           print("开始录制：\(outputFilePath) ")
//           self.output.startRecording(to: outputURL as URL, recordingDelegate: self as AVCaptureFileOutputRecordingDelegate)
//            self.isRecording = true
//       }
//    }
//
//    func StopRecord(){
//        if isRecording{
//            self.output.stopRecording()
//            self.isRecording = false
//        }
//    }
//    func SavePic(){
//        let image = UIImage(data: self.picData)!
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//       self.isSaved = true
//       print("Saved Successfully...")
//    }
//}
//
//struct RecordPreview : UIViewRepresentable{
//    @ObservedObject var camera : RecordVideo
//
//    func makeUIView(context: Context) ->  UIView {
//        let UIView = UIView(frame: UIScreen.main.bounds)
//        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
//        camera.preview.frame = UIView.frame
//        camera.preview.videoGravity = .resizeAspectFill
//        UIView.layer.addSublayer(camera.preview)
//        camera.session.startRunning()
//        return UIView
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        return
//    }
//}

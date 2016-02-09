//
//  TakeVideoController.swift
//  4makers
//
//  Created by baptiste Fehrenbach on 09/02/2016.
//  Copyright © 2016 AwH. All rights reserved.
//

import UIKit
import AVFoundation

class TakeVideoController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var videoView: UIView!
    
    var timer = NSTimer()
    var filePath:String? = nil
    var delegate = VideoDelegate()
    
    var captureSession: AVCaptureSession!
    var captureDevice : AVCaptureDevice!
    var movieFileOutput: AVCaptureMovieFileOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.layer.zPosition = 2000
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if device.hasMediaType(AVMediaTypeVideo) {
                if device.position == AVCaptureDevicePosition.Back {
                    captureDevice = device as! AVCaptureDevice
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetHigh
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            movieFileOutput = AVCaptureMovieFileOutput()
            if captureSession!.canAddOutput(movieFileOutput) {
                captureSession!.addOutput(movieFileOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer!.connection!.videoOrientation = AVCaptureVideoOrientation.Portrait
                videoView.layer.addSublayer(previewLayer)
                
                captureSession!.startRunning()
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer!.frame = videoView.bounds
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func takeVideo(sender: AnyObject) {
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let documentsDirectory = paths[0]
        
        repeat {
            filePath =
            "\(documentsDirectory)/video\(Int(arc4random_uniform(10000) + 1)).mp4"
        } while (NSFileManager.defaultManager().fileExistsAtPath(filePath!))
        movieFileOutput!.startRecordingToOutputFileURL(NSURL(fileURLWithPath: filePath!), recordingDelegate: delegate)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    @IBAction func stopVideo(sender: AnyObject) {
        endCapture()
    }
    
    @IBAction func stopVideoToo(sender: AnyObject) {
        endCapture()
    }
    
    func endCapture() {
        timer.invalidate()
        progressBar.progress = 0
        movieFileOutput!.stopRecording()
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "waitALittleTime", userInfo: nil, repeats: false)
    }
    
    func update() {
        progressBar.progress += 0.1
        if progressBar.progress == 1 {
            endCapture()
        }
    }
    
    func waitALittleTime() {
        performSegueWithIdentifier("showTakenVideo", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTakenVideo" {
            let controller = segue.destinationViewController as! VideoEditorController
            controller.videoUrl = filePath!
        }
    }
    
}
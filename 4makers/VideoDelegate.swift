//
//  VideoDelegate.swift
//  4makers
//
//  Created by baptiste Fehrenbach on 09/02/2016.
//  Copyright © 2016 AwH. All rights reserved.
//

import UIKit
import AVFoundation

class VideoDelegate : NSObject, AVCaptureFileOutputRecordingDelegate
{
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        print("capture output : finish recording to \(outputFileURL)")
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        print("capture output: started recording to \(fileURL)")
    }
    
}
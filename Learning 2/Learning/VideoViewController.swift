//
//  VideoViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var YTvideo : Proof = Proof()
    
    @IBOutlet weak var videoTitle: UILabel!
    var vidtitle : String = ""
    @IBOutlet weak var webview: UIWebView!
    var EmbedURL : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       videoTitle.text = YTvideo.title
        print("YTvideo.title :",YTvideo.title)
        EmbedURL = YTvideo.videoPath
        print("YTvideo.videoPath :",YTvideo.videoPath)

        
//        webview.loadHTMLString("<iframe width=\"\(webview.frame.width)\" height=\"\(webview.frame.height)\" src=\"https://www.youtube.com/embed/UOvVv8YxDm4\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
       
        webview.loadHTMLString(YTvideo.videoPath, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backToProofs") {
            let cam = segue.destination as! proofsViewController;
            
            
            
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

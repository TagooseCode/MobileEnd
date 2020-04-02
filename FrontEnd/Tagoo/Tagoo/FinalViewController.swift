//
//  CameraView.swift
//  Unity-iPhone
//
//This comment proves that project is within workspace
//  Created by Hendrik Tjoa on 3/25/20.
//Google Maps SDK Key: AIzaSyDcloJazSsWlb0A5GDhERYjGyzHaYMIfas
//
/* https://www.appcoda.com/arkit-introduction-scenekit/ was source */
/*https://guides.codepath.com/ios/Creating-Custom-View-Controllers */

import UIKit
import ARKit
import AVFoundation


class FinalViewController: UIViewController {
    

    @IBOutlet weak var CamView: ARSCNView!
    @IBOutlet weak var Crosshair: UIImageView!
    
    @IBOutlet weak var coordinates: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CamView.addSubview(Crosshair)
        self.coordinates.text = "I can change"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        CamView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CamView.session.pause()
    }
}
    

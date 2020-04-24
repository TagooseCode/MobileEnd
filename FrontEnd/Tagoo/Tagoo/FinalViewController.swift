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
import GoogleMaps
import CoreLocation


class FinalViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var timer = Timer()
    var locationManager = CLLocationManager()
    @IBOutlet weak var CamView: ARSCNView!
    @IBOutlet weak var Crosshair: UIImageView!
    
    @IBOutlet weak var coordinates: UILabel!
    private let session = AVCaptureSession()
    

    
    

    let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first;

    var deviceInput : AVCaptureDeviceInput?
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        } catch {
            print("Could not create video device input: \(error)")
            return
        }
        guard session.canAddInput(deviceInput!) else {
            print("Could not add video device input to the session")
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput!)
        //Location Manager code to fetch current location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
          switch (CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
              print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
              print("Access")
          }
        } else {
          print("Location services are not enabled")
        }
        CamView.addSubview(Crosshair)
        self.coordinates.text = "I can change"
        scheduledTimerWithTimeInterval()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.showCurrentLocation), userInfo: nil, repeats: true)
    }
    
    @objc func showCurrentLocation() {
        let locationObj = locationManager.location as! CLLocation
        let coord = locationObj.coordinate
        let lattitude = coord.latitude
        let longitude = coord.longitude
        self.coordinates.text = "\(lattitude)" + " " + "\(longitude)"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        timer.invalidate()
    }
}
    

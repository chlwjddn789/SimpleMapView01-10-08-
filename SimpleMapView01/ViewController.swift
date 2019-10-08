//
//  ViewController.swift
//  SimpleMapView01
//
//  Created by dit02 on 2019. 9. 17..
//  Copyright © 2019년 DIT. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
      
      var pins = [MKPointAnnotation]()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // MKViewDelegate와 UIViewController 연결
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        //plist 파일 불러오기
      let path = Bundle.main.path(forResource: "pinData", ofType: "plist")
      let contents = NSArray(contentsOfFile: path!)
   
      
    
      
      // optional binding 처리
      if let myItems = contents {
            
            for item in myItems {
                  let lat = (item as AnyObject).value(forKey: "lat")
                  let lng = (item as AnyObject).value(forKey: "lng")
                  let title = (item as AnyObject).value(forKey: "title")
                  let subtitle = (item as AnyObject).value(forKey: "subtitle")
                  
                  let myLng = (lng as! NSString).doubleValue
                  let myLat = (lat as! NSString).doubleValue
                  

                  
                  let pin = MKPointAnnotation()
                  pin.coordinate.latitude = myLat
                  pin.coordinate.longitude = myLng
                  pin.title = title as? String
                  pin.subtitle = subtitle as? String
                  pins.append(pin)
                  
            
            }
            
      }else{
            print("nil 발생")
      }
  
      
        mapView.showAnnotations(pins, animated: true)
    }

    @IBAction func standardMapType(_ sender: Any) {
        mapView.mapType = MKMapType.standard
    }
    @IBAction func satelliteMapType(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    @IBAction func hybridMapType(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "RE"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            if annotation.title == "DIT 동의과학대학교"{
                annotationView?.pinTintColor = UIColor.green
            }
            else if annotation.title == "송상현 광장"{
                annotationView?.pinTintColor = UIColor.red
            }
            else if annotation.title == "번개반점"{
                annotationView?.pinTintColor = UIColor.blue
            }
            else if annotation.title == "영도 목장원"{
                annotationView?.pinTintColor = UIColor.brown
            }
            else {
            }
            annotationView?.animatesDrop = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            let imgV = UIImageView(image: UIImage(named: "dog.png"))
            imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.leftCalloutAccessoryView = imgV
        }else{
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let alert = UIAlertController(title: view.annotation!.title!, message: view.annotation!.subtitle!, preferredStyle: .alert)
        
        let cancelBtn = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        alert.addAction(cancelBtn)
        
        present(alert, animated: false, completion: nil)
    }
}


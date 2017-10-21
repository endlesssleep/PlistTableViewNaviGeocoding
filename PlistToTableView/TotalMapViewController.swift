//
//  TotalMapViewController.swift
//  PlistToTableView
//
//  Created by 김종현 on 2017. 10. 8..
//  Copyright © 2017년 김종현. All rights reserved.
//

import UIKit
import MapKit

class TotalMapViewController: UIViewController {

    @IBOutlet weak var totalMapView: MKMapView!
    var dContents: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("dContents = \(String(describing: dContents))")
        
        var annos = [MKPointAnnotation]()
        
        if let myItems = dContents {
            for item in myItems {
                let address = (item as AnyObject).value(forKey: "address")
                let title = (item as AnyObject).value(forKey: "title")
                let geoCoder = CLGeocoder()
                
                geoCoder.geocodeAddressString(address as! String, completionHandler: { placemarks, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let myPlacemarks = placemarks {
                        let myPlacemark = myPlacemarks[0]
                        
                        let anno = MKPointAnnotation()
                        anno.title = title as? String
                        anno.subtitle = address as? String
                        
                        if let myLocation = myPlacemark.location {
                            anno.coordinate = myLocation.coordinate
                            annos.append(anno)
                        }
                        
                    }
                    
                    self.totalMapView.showAnnotations(annos, animated: true)
                    self.totalMapView.addAnnotations(annos)
                } )
            }
            
            } else {
                print("dContents의 값은 nil")
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

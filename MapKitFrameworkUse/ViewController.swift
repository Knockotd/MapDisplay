//
//  ViewController.swift
//  MapKitFrameworkUse
//
//  Created by 503-26 on 22/11/2018.
//  Copyright © 2018 map. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController {
    var locationManager:CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    @IBAction func zoom(_ sender: Any) {
        
        //맵뷰에서 현재 사용자의 위치를 가져오기
        let userLocation = mapView.userLocation
        //출력 영역 만들기
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        //맵 뷰에 설정
        mapView.setRegion(region, animated: true)
    }
    @IBAction func type(_ sender: Any) {
        if mapView.mapType == .satellite{
            mapView.mapType = .standard
        }else{
            mapView.mapType = .satellite
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //위치정보 사용 객체 생성
        locationManager = CLLocationManager()
        //위치정보 사용권한을 묻는 대화상자 출력
        locationManager?.requestWhenInUseAuthorization()
        //맵뷰에 현재 위치를 출력
        mapView.showsUserLocation = true
        
        mapView.delegate = self
    }
}
extension ViewController:MKMapViewDelegate{
    //사용자의 위치가 변경된 경우 호출되는 메소드
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
}

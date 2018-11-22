//
//  ViewController.swift
//  MapDisplay
//
//  Created by 503-26 on 22/11/2018.
//  Copyright © 2018 map. All rights reserved.
//

import UIKit
import Contacts //연락처가(지오코딩을 포함함)
import MapKit //지도
import CoreLocation //위지정보

class ViewController: UIViewController {

    @IBOutlet weak var post: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    
    //주소에 해당하는 위도와 경도 정보를 저장할 변수 생성
    var coords : CLLocationCoordinate2D?
    
    //지도를 출력하는 사용자 정의 메소드
    func showMap(){
        //입력한 내용 가져오기(문자열이 ""이렇게 없는게 아니라 객체 자체가 없을 때 안 한다는 것.
        if let addressString = address.text,
            let cityString = city.text,
            let stateString = state.text,
            let postString = post.text,
            let coordinate = coords{
            //주소객체 만들기
            let addressDict = [CNPostalAddressStreetKey:addressString,
                               CNPostalAddressCityKey:cityString,
                               CNPostalAddressStateKey:stateString,
                               CNPostalAddressPostalCodeKey:postString]
            //지도를 출력할 장소 만들기
            //addressDict는 마커를 클릭했을 때 주소가 보일 때 사용함.
            let place = MKPlacemark.init(coordinate: coordinate, addressDictionary: addressDict)
            //지도에 출력할 장소를 포함할 객체 만들기
            let mapItem = MKMapItem.init(placemark: place)
            //지도 옵션 설정
            let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            //지도출력
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    @IBAction func mapDisplay(_ sender: Any) {
        //역 지오코딩: 주소정보를 가지고 위치정보를 찾아오는 것
        //다음이나 네이버의 오픈 API를 이용해도 되고 애플의 경우는 MapKit에서 이 기능을 제공합니다.
        //구글에서도 제공합니다.
        if let addressString = address.text,
            let cityString = city.text,
            let stateString = state.text,
            let postString = post.text{
            //'주소'는 거리 - 도시 - 주 - 우편번호 순입니다.
            let address = "\(addressString), \(cityString) \(stateString) \(postString)"
            //위도 경도 찾아오기
            CLGeocoder().geocodeAddressString(address, completionHandler:{
                (placemarks, error) in
                //에러가 발생한 경우 - 인터넷이 안 되거나 주소가 잘못된 경우
                if error != nil{
                    print("FAIL:\(error!.localizedDescription)")
                }else if let marks = placemarks, marks.count>0{
                    //첫번째 데이터 가져오기
                    //주소를 가지고 위도,경도를 찾으면 여러개이다.
                    let placemark = marks[0]
                    //주소를 저장하고 지도 출력하는 메소드 호출
                    if let location = placemark.location{
                        self.coords = location.coordinate
                        self.showMap()
                    }
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}


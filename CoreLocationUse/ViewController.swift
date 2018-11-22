import UIKit
//위치정보 사용을 위한 프레임워크
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {

    //위치정보 사용을 위한 인스턴스를 생성
    var locationManager = CLLocationManager()
    //시작위치를 저장할 변수
    var startLocation:CLLocation!
    
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    //var flug = true
    @IBAction func locationUpdate(_ sender: Any) {
        /*
        //이미지를 이용할 때
        if flug == true{
            flug = false
        }else{
            flug = true
        }
 */
        //버튼의 타이틀을 가지고 토글
        let btn = sender as! UIButton
        if btn.title(for: .normal) == "위치정보수집시작"{
            //위치정보 수집시작
            locationManager.startUpdatingLocation()
            //위치정보 자동으로 업데이트되는 것을 멈추는 설정(true(활성):움직이지 않을 때는 업데이트를 하지 않음)
            //기본적으로 활성화 상태.
            //비활성화를 한다면 Request가 많이 발생하고 베터리 소모량도 크다.
            locationManager.pausesLocationUpdatesAutomatically = true
            btn.setTitle("위치정보수집중지", for: .normal)
        }else{
            //위치정보 수집중지
            locationManager.stopUpdatingLocation()
            btn.setTitle("위치정보수집시작", for: .normal)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //정밀도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //delegate 설정
        locationManager.delegate = self
        //위치정보 사용 동의 대화상자 출력 - 실행 중에만 사용
        locationManager.requestWhenInUseAuthorization()
        
        
        
    }
//Mark 위치정보 갱신과 관련된 메소드
    // 위치정보를 가져오는데 성공했을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //배열에서 위치정보객체 1개 가져오기
        var lastLocation = locations[locations.count-1]
        //위도 경도 고도 출력
        lblLatitude.text = "\(lastLocation.coordinate.latitude)"
        lblLongitude.text = "\(lastLocation.coordinate.longitude)"
        lblAltitude.text = "\(lastLocation.altitude)"
        
        //시작위치 설정
        if startLocation == nil{
            //만약 앱이 시작될 때마다 시작위치를 설정하고 싶으면
            //viewDidLoad에서 startLocation의 값을 nil로 계속 초기화 시켜주면 된다.
            startLocation = lastLocation
        }
        
        //거리계산(실수)
        let distance = lastLocation.distance(from: startLocation)
        lblDistance.text = "\(distance)"
    }
}


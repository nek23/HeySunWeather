import Alamofire
import Foundation

class WeatherManager: NSObject {
  static let shared = WeatherManager()
  
  func hourlyWeather(longitude: Double, latitude: Double, onSuccess: @escaping(Weather) -> Void, onFailure: @escaping(String) -> Void) {
    
    guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/hourly") else { return }
    let parameters = [
      "key": "02b8e2154bfd4412a5d22453b76192af",
      "lat": String(latitude),
      "lon": String(longitude),
      "lang": "ru",
      "hours": "24"
    ]
    
    Alamofire.request(
      url,
      method: .get,
      parameters: parameters,
      encoding: URLEncoding.default,
      headers: nil).responseData { (response) in
        switch response.result {
        case .success(_):
          do {
            let json = response.data
            let decoder = JSONDecoder()
            print(String(data: json!, encoding: .utf8))
            let jsonData = try decoder.decode(Weather.self, from: json!)
            onSuccess(jsonData)
          } catch {
            onFailure(error.localizedDescription)
          }
        case .failure(let error):
          onFailure(error.localizedDescription)
        }
    }
  }
}

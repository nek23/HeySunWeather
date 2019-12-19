import Foundation
import UIKit

class ViewModel: NSObject {
  
  @IBOutlet weak var weatherManager: WeatherManager!
  
  private var weather: Weather?
  private var weatherData: [WeatherData]?
  
  // Setup cell
  func numberOfRowsInSection() -> Int {
    return weather?.data?.count ?? 0
  }
  
  func tempForTempLabel(at indexPath: IndexPath) -> String {
    guard let temp = weatherData?[indexPath.row].temp else { return "" }
    var tempString = String(Int(temp))
    if temp > 0 { tempString = "+" + tempString }
    tempString = tempString + "˚"
    return tempString
  }
  
  func timeForHourLabel(at indexPath: IndexPath) -> String {
    guard let dateString = weatherData?[indexPath.row].timestampLocal else { return ""}
    let start = dateString.index(dateString.startIndex, offsetBy: 11)
    let end = dateString.index(dateString.endIndex, offsetBy: -3)
    let range = start..<end
    return String(dateString[range])
  }
  
  func colorForLabels(at indexPath: IndexPath) -> UIColor? {
    guard let pod = weatherData?[indexPath.row].pod else { return nil }
    return pod == .d ? UIColor.black : UIColor.white
  }
  
  func backgroundForCell(at indexPath: IndexPath) -> UIColor? {
    guard let pod = weatherData?[indexPath.row].pod else { return nil }
    return pod == .d ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) : #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
  }
  
  func descAndImage(at indexPath: IndexPath) -> (description: String, image: String)? {
    guard let code = weatherData?[indexPath.row].weather?.code else { return nil }
    guard let pod = weatherData?[indexPath.row].pod else { return nil }
    print(code)
    
    switch code {
    case 200, 201, 202:
      return (description: "Гроза", image: pod == .d ? "light-thunderstorm" : "night-thunderstorm")
    case 230, 231, 232, 233:
      return (description: "Сильная гроза", image: "heavy-thunderstorm")
    case 300, 301, 302:
      return (description: "Изморозь", image: "drizzle")
    case 500, 521:
      return (description: "Легкий дождь", image: pod == .d ? "shower-rainy" : "night-rainy")
    case 501, 511, 520:
      return (description: "Дождь", image: "rainy")
    case 502, 522:
      return (description: "Сильный дождь", image: "heavy-rainy")
    case 600, 611, 621, 622, 623:
      return (description: "Снег", image: pod == .d ? "snowy" : "night-snowy")
    case 602, 612:
      return (description: "Сильный снег", image: "heavy-snowy")
    case 610:
      return (description: "Снег с дождем", image: "rainy-snowy")
    case 711, 700, 721, 731, 741, 751:
      return (description: "Туман", image: "foog")
    case 800:
      return (description: "Ясно", image: pod == .d ? "sunny" : "night" )
    case 801, 802:
      return (description: pod == .d ? "Солнечно" : "Малооблачно", image: pod == .d ? "sunny-cloudy" : "night-cloudy")
    case 803:
      return (description: "Облачно", image: "cloud")
    case 804:
      return (description: "Пасмурно", image: "cloudy")
    case 900:
      return (description: "Осадки", image: "rainy")
    default:
      return (description: "хуйня", image: "rainy")
    }
  }
  
  func fetchHourlyWeather(long: Double, lat: Double, onSuccess: @escaping() -> (), onError: @escaping(String) -> ()) {
    WeatherManager.shared.hourlyWeather(longitude: long, latitude: lat, onSuccess: { [weak self] weather in
      self?.weatherData = weather.data
      self?.weather = weather
      onSuccess()
    }) { (error) in
      onError(error)
    }
  }
}

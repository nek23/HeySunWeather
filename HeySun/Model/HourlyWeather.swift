// MARK: - Weather
struct Weather: Codable {
  let data: [WeatherData]?
  let cityName: String?
  let lon: Double?
  let timezone: String?
  let lat: Double?
  let countryCode, stateCode: String?
  
  enum CodingKeys: String, CodingKey {
    case data
    case cityName = "city_name"
    case lon, timezone, lat
    case countryCode = "country_code"
    case stateCode = "state_code"
  }
}

// MARK: - WeatherData
struct WeatherData: Codable {
  let windCdir: String?
  let temp: Double?
  let rh: Int?
  let pod: Pod?
  let pres: Double?
  let weather: WeatherClass?
  let windGustSpd: Double?
  let timestampLocal: String?
  let clouds: Int?
  let windSpd: Double?
  let pop: Int?
  let slp, dni: Double?
  let precip, vis, dhi, appTemp: Double?
  let datetime: String?
  let ghi: Double?
  
  enum CodingKeys: String, CodingKey {
    case windCdir = "wind_cdir"
    case temp
    case rh
    case pod
    case pres
    case weather
    case windGustSpd = "wind_gust_spd"
    case timestampLocal = "timestamp_local"
    case clouds
    case windSpd = "wind_spd"
    case pop
    case slp, dni
    case precip, vis, dhi
    case appTemp = "app_temp"
    case datetime, ghi
  }
}

enum Pod: String, Codable {
  case d = "d"
  case n = "n"
}

struct WeatherClass: Codable {
  let icon: String?
  let code: Int?
  let weatherDescription: String?
  
  enum CodingKeys: String, CodingKey {
    case icon, code
    case weatherDescription = "description"
  }
}

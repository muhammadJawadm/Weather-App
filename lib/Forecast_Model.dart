class ForecastModel {
  String? cod;
  int? message;
  int? cnt;
  List<ForecastItem>? list;
  City? city;

  ForecastModel({this.cod, this.message, this.cnt, this.list, this.city});

  ForecastModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <ForecastItem>[];
      json['list'].forEach((v) {
        list!.add(ForecastItem.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
}

class ForecastItem {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Rain? rain;
  Sys? sys;
  String? dtTxt;

  ForecastItem.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    weather =
        json['weather']?.map<Weather>((v) => Weather.fromJson(v)).toList();
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = (json['pop'] ?? 0).toDouble();
    rain = json['rain'] != null ? Rain.fromJson(json['rain']) : null;
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  Main.fromJson(Map<String, dynamic> json) {
    temp = (json['temp'] ?? 0).toDouble();
    feelsLike = (json['feels_like'] ?? 0).toDouble();
    tempMin = (json['temp_min'] ?? 0).toDouble();
    tempMax = (json['temp_max'] ?? 0).toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = (json['temp_kf'] ?? 0).toDouble();
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Clouds {
  int? all;

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind.fromJson(Map<String, dynamic> json) {
    speed = (json['speed'] ?? 0).toDouble();
    deg = json['deg'];
    gust = (json['gust'] ?? 0).toDouble();
  }
}

class Rain {
  double? h3;

  Rain.fromJson(Map<String, dynamic> json) {
    h3 = (json['3h'] ?? 0).toDouble();
  }
}

class Sys {
  String? pod;

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Coord {
  double? lat;
  double? lon;

  Coord.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] ?? 0).toDouble();
    lon = (json['lon'] ?? 0).toDouble();
  }
}

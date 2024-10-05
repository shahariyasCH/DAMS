import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'alert.dart';

class DisasterTypeBox extends StatefulWidget {
  final String name;
  final String imageAsset;
  final String controlMeasures;
  final double? maxWind;
  final double? minWind;

  const DisasterTypeBox({
    Key? key,
    required this.name,
    required this.imageAsset,
    required this.controlMeasures,
    this.maxWind,
    this.minWind,
  }) : super(key: key);

  @override
  _DisasterTypeBoxState createState() => _DisasterTypeBoxState();
}

class _DisasterTypeBoxState extends State<DisasterTypeBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showControlMeasuresPopup(context, widget.controlMeasures);
      },
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 16.0),
          width: 350.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.cover,
                  width: 350.0,
                  height: 250.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              if (widget.minWind != null && widget.maxWind != null)
                Text(
                  "Min Wind: ${widget.minWind} m/s, Max Wind: ${widget.maxWind} m/s",
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showControlMeasuresPopup(BuildContext context, String controlMeasures) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Control Measures"),
          content: Text(controlMeasures),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

final List<Map<String, dynamic>> commonDisasters = [
  {
    "name": "Earthquake",
    "imageAsset": "image/earthquake.jpg",
    "controlMeasures":
        "Stay indoors, take cover under a sturdy piece of furniture, and hold on until the shaking stops."
  },
  {
    "name": "Flood",
    "imageAsset": "image/Flood.jpg",
    "controlMeasures":
        "Move to higher ground, avoid flooded areas, and do not attempt to cross flowing water."
  },
  {
    "name": "Tsunami",
    "imageAsset": "image/Tsunami.jpg",
    "controlMeasures": "Evacuate immediately to higher ground or inland."
  },
  {
    "name": "Hurricane",
    "imageAsset": "image/Hurricane.jpg",
    "controlMeasures":
        "Evacuate to a safe location or take shelter in a sturdy building."
  },
  {
    "name": "Wildfire",
    "imageAsset": "image/Wildfire.jpg",
    "controlMeasures":
        "Evacuate if instructed, and avoid areas with active fires."
  },
  {
    "name": "Tornado",
    "imageAsset": "image/Tornado.jpg",
    "controlMeasures":
        "Seek shelter in a sturdy building or underground shelter."
  },
  {
    "name": "Drought",
    "imageAsset": "image/Drought.jpg",
    "controlMeasures":
        "Conserve water, reduce outdoor activities, and follow water use restrictions."
  },
  {
    "name": "Avalanche",
    "imageAsset": "image/Avalanche.jpg",
    "controlMeasures":
        "Avoid areas prone to avalanches and always check avalanche forecasts before traveling."
  },
  {
    "name": "Landslide",
    "imageAsset": "image/Landslide.jpg",
    "controlMeasures":
        "Avoid building on steep slopes, and be cautious during heavy rainfall."
  },
  {
    "name": "Volcanic Eruption",
    "imageAsset": "image/volcano.jpg",
    "controlMeasures":
        "Follow evacuation orders and stay away from volcanic ashfall and debris."
  },
  {
    "name": "Blizzard",
    "imageAsset": "image/Blizzard.jpg",
    "controlMeasures":
        "Stay indoors, and avoid unnecessary travel during blizzard conditions."
  },
  {
    "name": "Sandstorm",
    "imageAsset": "image/Sandstorm.jpg",
    "controlMeasures":
        "Stay indoors, and protect yourself from airborne dust by sealing windows and doors."
  },
  {
    "name": "Cyclone",
    "imageAsset": "image/Cyclone.jpg",
    "controlMeasures":
        "Evacuate if instructed, and secure loose objects to prevent damage."
  },
  {
    "name": "Sinkhole",
    "imageAsset": "image/Sinkhole.jpg",
    "controlMeasures":
        "Avoid areas with recent sinkhole activity, and report any signs of sinkholes to authorities."
  },
  {
    "name": "Thunderstorm",
    "imageAsset": "image/Thunderstorm.jpg",
    "controlMeasures":
        "Take shelter indoors, avoid using electrical appliances, and stay away from tall objects."
  },
  {
    "name": "Hailstorm",
    "imageAsset": "image/Hailstorm.jpg",
    "controlMeasures":
        "Seek shelter indoors, protect vehicles and property, and avoid windows during hailstorms."
  },
  {
    "name": "Chemical Spill",
    "imageAsset": "image/chemical_spill.jpg",
    "controlMeasures":
        "Evacuate if instructed, avoid contaminated areas, and seek medical attention if exposed to chemicals."
  },
  {
    "name": "Nuclear Accident",
    "imageAsset": "image/nuclear_accident.jpg",
    "controlMeasures":
        "Follow evacuation orders, take iodine tablets if instructed, and stay indoors to avoid radiation exposure."
  },
  {
    "name": "Pandemic",
    "imageAsset": "image/pandemic.jpg",
    "controlMeasures":
        "Follow public health guidelines, practice good hygiene, and get vaccinated if available."
  },
  {
    "name": "Oil Spill",
    "imageAsset": "image/oil_spill.jpg",
    "controlMeasures":
        "Stay away from affected areas, avoid contact with oil, and follow cleanup instructions from authorities."
  },
  {
    "name": "Biological Hazard",
    "imageAsset": "image/biological_hazard.jpg",
    "controlMeasures":
        "Use personal protective equipment, practice good hygiene, and follow medical advice if exposed."
  },
  {
    "name": "Explosion",
    "imageAsset": "image/explosion.jpg",
    "controlMeasures":
        "Seek shelter indoors, avoid windows, and follow evacuation orders if necessary."
  },
  {
    "name": "Air Quality Emergency",
    "imageAsset": "image/air_quality_emergency.jpg",
    "controlMeasures":
        "Stay indoors, use air purifiers or masks if available, and limit outdoor activities."
  },
  // Add more disaster types as needed
];

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final String OPENWEATHER_API_KEY;
  late final WeatherFactory _wf;
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    OPENWEATHER_API_KEY = "5d3e0cb9f4ccdc66d4ecf5b1e801a6f1";
    _wf = WeatherFactory(OPENWEATHER_API_KEY);
    _fetchWeatherData(); // Fetch weather data on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DAMS"),
        backgroundColor: const Color.fromARGB(255, 86, 116, 181),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300.0,
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(255, 123, 131, 221),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Weather in your location",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "${_weather?.weatherMain ?? 'Fetching...'}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "${_weather?.temperature?.celsius?.toStringAsFixed(0) ?? '--'}° C",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 55,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    if (_weather?.tempMax != null && _weather?.tempMin != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C        Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4.0),
                    if (_weather?.windSpeed != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Wind Speed: ${_weather?.windSpeed?.toStringAsFixed(1) ?? '--'} m/s",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Common Disaster Types",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: commonDisasters.map((disaster) {
                    return DisasterTypeBox(
                      name: disaster['name'],
                      imageAsset: disaster['imageAsset'],
                      controlMeasures: disaster['controlMeasures'],
                      maxWind: disaster['maxWind'],
                      minWind: disaster['minWind'],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Alert()),
          );
        },
        child: const Text("Alert"),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _fetchWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      Weather response = await _wf.currentWeatherByLocation(
          position.latitude, position.longitude);
      print(response);

      setState(() {
        _weather = response;
      });
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}
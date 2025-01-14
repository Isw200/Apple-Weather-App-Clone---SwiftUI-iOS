# Weather App Pro

<img src="https://github.com/user-attachments/assets/be412a8f-09c8-4d29-8e9c-222da0d44005" alt="app-icon" width="150" height="150" style="border-radius: 50%; border: 2px solid #000;">


WeatherAppPro is a modern weather application designed to provide users with detailed and accurate weather information. The app includes dynamic visualizations, a user-friendly interface, and features such as saving favorite cities, interactive maps, and air quality monitoring.

---

## Features

- **Current, Hourly, and Daily Weather**: Displays comprehensive weather data, including temperature, humidity, wind speed, and weather conditions.
- **Interactive Map**: Includes an interactive weather map with overlays for temperature, precipitation, wind, and more using `MKMapView`.
- **Dynamic Backgrounds**: Weather-specific video backgrounds that adapt to weather conditions and time of day using `AVPlayer`.
- **Air Quality Monitoring**: Provides real-time air quality data and detailed components analysis.
- **Favorite Cities Management**: Save and manage your favorite cities using Core Data for easy access.
- **Compass View**: A custom compass showing wind direction and speed with a visually intuitive design.
- **Report an Issue**: Allows users to report inaccurate weather data directly to Firebase.
- **Skeleton Loading Views**: Enhances user experience with animated placeholders during data loading.
- **Dark Mode Support**: Seamless dark mode compatibility for better accessibility.

---

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/915658c8-2ed3-4cc9-8d45-d5466f78e751" alt="Screenshot 4" width="200"/>
  <img src="https://github.com/user-attachments/assets/8ded67d7-d532-45fb-9da1-af23a9163815" alt="Screenshot 3" width="200"/>
  <img src="https://github.com/user-attachments/assets/e1331e46-c2ba-499b-a66e-a52cdf72fbb8" alt="Screenshot 1" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/c4bf52f3-6604-4aec-a9c2-e209e9121084" alt="Screenshot 2" width="200"/>
  <img src="https://github.com/user-attachments/assets/694648b3-7216-4415-9e92-3e8a3109dcb6" alt="Screenshot 6" width="200"/>
  <img src="https://github.com/user-attachments/assets/5aeec7ce-7ef2-4db2-9e7c-038c77ad00cd" alt="Screenshot 5" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/f1701018-875b-4614-b0fa-0fd60f9b59fb" alt="Screenshot 9" width="200"/>
  <img src="https://github.com/user-attachments/assets/d941efa7-4d3a-4123-bde8-56191942f7fc" alt="Screenshot 10" width="200"/>
  <img src="https://github.com/user-attachments/assets/524e5268-77fa-4769-b076-4caabdc394e2" alt="Screenshot 12" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/6711193c-40f5-4283-9cea-43d005d88e4d" alt="Screenshot 11" width="200"/>
  <img src="https://github.com/user-attachments/assets/231fe28a-eb4e-4ff6-9221-61b46cc6426e" alt="Screenshot 7" width="200"/>
  <img src="https://github.com/user-attachments/assets/91bc857e-f377-4f4b-b0bb-6aac120af558" alt="Screenshot 8" width="200"/>
</p>

---

## Technologies Used

### Frameworks and Libraries
- **SwiftUI**: For building a modern and responsive user interface.
- **MapKit**: For interactive weather maps and overlays.
- **AVKit & AVFoundation**: For dynamic video backgrounds.
- **Core Location**: To retrieve and use the user’s current location.
- **Core Data**: For persistent storage of favorite cities.
- **Firebase Firestore**: To manage user-submitted reports.

### Tools
- **Xcode**: For development and testing.
- **GitHub**: Version control and collaboration.

---

## Installation

### Prerequisites
- macOS with Xcode installed.
- iOS device or simulator running iOS 15.0 or later.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/WeatherAppPro.git
   ```
2. Open `WeatherAppPro.xcodeproj` in Xcode.
3. Replace the OpenWeatherMap API key in `Shared > Constants > ApiEndPoints` under `apiKey`.
4. Download and insert the `GoogleService-Info.plist` file into the `Firebase` folder in WeatherAppPro.
5. Add the app icon to your Xcode project by dragging it into the asset catalog.
6. Run the project on an iOS simulator or connected device.

---

## API Integration

The app integrates with weather and air quality APIs to provide real-time data. Make sure to add your API keys in the designated configuration files:

- **Weather API**: For current, hourly, and daily weather data.
- **Air Quality API**: For real-time air quality index and components.

---

## Project Structure

- **Models**: Data models for weather, air quality, and favorite cities.
- **Views**: SwiftUI components for displaying data (e.g., `WeatherDashboard`, `MapView`, `ReportIssueView`).
- **ViewModels**: Logic to fetch and bind data to the views (`WeatherViewModel`, `MapViewModel`).
- **Utilities**: Helper functions, extensions, and configuration files.

---

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature description"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a Pull Request.

---

## License

This project is licensed under the [MIT License](https://github.com/Isw200/Apple-Weather-App-Clone/blob/main/LICENSE).

---

## Acknowledgments

- OpenWeatherMap API for weather data.
- Apple Developer Community for guidance and resources.
- Firebase for cloud database support.

---

## Contact

For questions or feedback, please contact [isuruariyarathna.me](https://www.isuruariyarathna.me/).

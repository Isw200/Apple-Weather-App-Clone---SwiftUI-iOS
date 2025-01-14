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
  <img src="https://github.com/user-attachments/assets/ed128056-fc85-4185-b56f-a44abe76dcf3" alt="Image 1" width="200"/>
  <img src="https://github.com/user-attachments/assets/39c662f7-6922-42d2-ac03-3168e7942f95" alt="Image 2" width="200"/>
  <img src="https://github.com/user-attachments/assets/f16ec313-aca3-4b8d-ad10-217a06b58c50" alt="Image 3" width="200"/>
  <img src="https://github.com/user-attachments/assets/952dc40f-32bd-4c4e-93c9-d791d0657f32" alt="Image 4" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/b5a60dfe-5219-41a2-9304-c1bb9919114e" alt="Image 5" width="200"/>
  <img src="https://github.com/user-attachments/assets/3bf84bab-8850-4e95-8f3f-cde4fe4ca792" alt="Image 6" width="200"/>
  <img src="https://github.com/user-attachments/assets/e421d264-c5bd-4a2b-bd82-5ebdc9666df2" alt="Image 7" width="200"/>
  <img src="https://github.com/user-attachments/assets/57a6e525-b174-4167-9193-4afa347a53be" alt="Image 8" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/3c1d13cd-d810-4a11-ad3d-9f3b4c10704b" alt="Image 9" width="200"/>
  <img src="https://github.com/user-attachments/assets/fb26242b-758d-4cdf-956b-da69c29cf1c0" alt="Image 10" width="200"/>
  <img src="https://github.com/user-attachments/assets/e7b53464-facd-4ba7-b11f-1f6b15d2a54a" alt="Image 11" width="200"/>
  <img src="https://github.com/user-attachments/assets/64142b1d-e56e-4be1-a9f2-ef1bfc848414" alt="Image 12" width="200"/>
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
- **API**: OpenWeatherMap's One Call API 3.0.
- **Firebase**
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
   *Ensure you have subscribed to OpenWeatherMap's **One Call API 3.0** to access the necessary weather data.*
5. Download and insert the `GoogleService-Info.plist` file into the `Firebase` folder in WeatherAppPro.
6. Add the app icon to your Xcode project by dragging it into the asset catalog.
7. Run the project on an iOS simulator or connected device.

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

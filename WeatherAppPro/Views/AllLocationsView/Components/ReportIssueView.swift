//
//  ReportIssueView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-03.
//

import SwiftUI
import Firebase

struct ReportIssueView: View {
    @ObservedObject var settingsVM: SettingsViewModel
    @Binding var showReport: Bool

    @State var clear: Bool = false
    @State var clouds: Bool = false
    @State var rain: Bool = false
    @State var sleet: Bool = false
    @State var snow: Bool = false

    @State var selectedTemperatureOption: String = "Seems accurate"
    @State var selectedWindOption: String = "Seems accurate"

    @State var rainbow: Bool = false
    @State var lightning: Bool = false
    @State var hail: Bool = false
    @State var smoke: Bool = false
    @State var fog: Bool = false
    @State var haze: Bool = false

    @State var description: [String] = []

    @State private var isSubmitting = false
    @State private var showSuccessOverlay = false

    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Help improve the Weather app by describing the current conditions at your location.")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.top, 10)
                            .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)

                        Text("Apple collects your feedback and location, but this information is not associated with your Apple Account.")
                            .font(.system(size: 14))
                            .padding(.top, 4)
                            .foregroundStyle(settingsVM.darkMode ? Color.white.opacity(0.5) : Color.black.opacity(0.5))

                        Text("Overall Conditions")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.top)
                        
                        conditionsSection()
                        temperatureSection()
                        windSection()
                        otherConditionsSection()
                        descriptionSection()
                        feedbackLink()
                    }
                    .padding()
                    .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                }
                .navigationTitle("Report an Issue")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            showReport.toggle()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Submit") {
                            submitReport()
                        }
                        .disabled(!isFormValid())
                    }
                }
            }
            .disabled(isSubmitting)

            if isSubmitting {
                VStack {
                    ProgressView("Submitting...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 200)
                .padding(.vertical, 30)
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
                .shadow(radius: 10)
            }

            if showSuccessOverlay {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                    Text("Report Submitted!")
                        .font(.system(size: 16, weight: .semibold))
                        .fontWeight(.bold)
                        .padding(.top, 4)
                        .foregroundColor(.white)
                    Text("Thank you for submitting your report.")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.top, 1)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 240)
                .padding(.vertical, 30)
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
                .shadow(radius: 10)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showSuccessOverlay = false
                        showReport.toggle()
                    }
                }
            }
        }
    }

    private func submitReport() {
        isSubmitting = true

        let reportData: [String: Any] = [
            "clear": clear,
            "clouds": clouds,
            "rain": rain,
            "sleet": sleet,
            "snow": snow,
            "temperatureFeedback": selectedTemperatureOption,
            "windFeedback": selectedWindOption,
            "rainbow": rainbow,
            "lightning": lightning,
            "hail": hail,
            "smoke": smoke,
            "fog": fog,
            "haze": haze,
            "description": description,
            "timestamp": Timestamp(date: Date())
        ]

        let db = Firestore.firestore()
        db.collection("weatherReports").addDocument(data: reportData) { error in
            isSubmitting = false
            if let error = error {
                print("Error submitting report: \(error.localizedDescription)")
            } else {
                showSuccessOverlay = true
            }
        }
    }

    private func isFormValid() -> Bool {
        return clear || clouds || rain || sleet || snow || !description.isEmpty
    }

    @ViewBuilder
    private func conditionsSection() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            toggleRow("Clear", icon: "sun.max.fill", state: $clear)
            Divider()
            toggleRow("Cloudy", icon: "cloud.fill", state: $clouds)
            Divider()
            toggleRow("Rainy", icon: "cloud.drizzle.fill", state: $rain)
            Divider()
            toggleRow("Sleet", icon: "cloud.hail.fill", state: $sleet)
            Divider()
            toggleRow("Snow", icon: "snowflake", state: $snow)
        }
        .font(.system(size: 18))
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func temperatureSection() -> some View {
        Text("Temperature")
            .font(.system(size: 20, weight: .semibold))
            .padding(.top)
        Text("Shown as: 24°")
            .font(.subheadline)
            .foregroundStyle(.secondary)

        VStack(alignment: .leading, spacing: 10) {
            radioButton("It's warmer", isSelected: $selectedTemperatureOption)
            Divider()
            radioButton("Seems accurate", isSelected: $selectedTemperatureOption)
            Divider()
            radioButton("It's colder", isSelected: $selectedTemperatureOption)
        }
        .font(.system(size: 18))
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func windSection() -> some View {
        Text("Wind")
            .font(.system(size: 20, weight: .semibold))
            .padding(.top)
        Text("Shown as: 9 km/h")
            .font(.subheadline)
            .foregroundStyle(.secondary)

        VStack(alignment: .leading, spacing: 10) {
            radioButton("It's windier", isSelected: $selectedWindOption)
            Divider()
            radioButton("Seems accurate", isSelected: $selectedWindOption)
            Divider()
            radioButton("It's less windy", isSelected: $selectedWindOption)
        }
        .font(.system(size: 18))
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func otherConditionsSection() -> some View {
        Text("Other Conditions")
            .font(.system(size: 20, weight: .semibold))
            .padding(.top)

        VStack(alignment: .leading, spacing: 10) {
            toggleRow("Rainbow", icon: "rainbow", state: $rainbow)
            Divider()
            toggleRow("Lightning", icon: "cloud.bolt.fill", state: $lightning)
            Divider()
            toggleRow("Hail", icon: "cloud.hail", state: $hail)
            Divider()
            toggleRow("Smoke", icon: "smoke.fill", state: $smoke)
            Divider()
            toggleRow("Fog", icon: "cloud.fog.fill", state: $fog)
            Divider()
            toggleRow("Haze", icon: "sun.haze.fill", state: $haze)
        }
        .font(.system(size: 18))
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func descriptionSection() -> some View {
        Text("Description")
            .font(.system(size: 20, weight: .semibold))
            .padding(.top)

        Grid {
            GridRow {
                toggleButton("Pleasant")
                toggleButton("Unpleasant")
            }
            GridRow {
                toggleButton("Hot")
                toggleButton("Chill")
            }
            GridRow {
                toggleButton("Muggy")
                toggleButton("Dry")
            }
            GridRow {
                toggleButton("Windy")
                toggleButton("Calm")
            }
        }
    }

    @ViewBuilder
    private func feedbackLink() -> some View {
        VStack {
            Text("If you have comments about the Weather app,")
                .font(.system(size: 14))
                .foregroundColor(.secondary)

            Text("provide feedback online.")
                .font(.system(size: 14))
                .foregroundColor(.blue)
                .underline()
                .onTapGesture {
                    if let url = URL(string: "https://openweathermap.org/feedback") {
                        UIApplication.shared.open(url)
                    }
                }
        }
        .multilineTextAlignment(.center)
        .padding()
    }

    @ViewBuilder
    private func radioButton(_ label: String, isSelected: Binding<String>) -> some View {
        HStack {
            Image(systemName: isSelected.wrappedValue == label ? "checkmark.circle.fill" : "circle")
                .foregroundColor(.blue)
                .onTapGesture {
                    isSelected.wrappedValue = label
                }
            Text(label)
                .onTapGesture {
                    isSelected.wrappedValue = label
                }
        }
    }

    @ViewBuilder
    private func toggleRow(_ label: String, icon: String, state: Binding<Bool>) -> some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .symbolRenderingMode(.multicolor)
            Text(label)
                .font(.body)
            Spacer()
            Toggle("", isOn: state)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .green))
        }
    }

    @ViewBuilder
    private func toggleButton(_ label: String) -> some View {
        Button(label) {
            if description.contains(label) {
                description.removeAll { $0 == label }
            } else {
                description.append(label)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(description.contains(label) ? Color.blue : Color.gray.opacity(0.3))
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

#Preview {
    ReportIssueView(settingsVM: SettingsViewModel(), showReport: .constant(true))
}

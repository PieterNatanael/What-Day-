//
//  ContentView.swift
//  What Day?
//
//  Created by Pieter Yoshua Natanael on 14/05/24.
//

import SwiftUI

// Main view displaying the date picker and resulting day of the week

struct ContentView: View {
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedDay = Calendar.current.component(.day, from: Date())
    @State private var showAdsAndAppFunctionality = false

    var body: some View {
        ZStack {
            // Background color
            Color(UIColor(red: 54/255, green: 57/255, blue: 63/255, alpha: 1))
                .ignoresSafeArea()

            VStack {
                // Info button
                HStack {
                    Spacer()
                    Button(action: {
                        showAdsAndAppFunctionality = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                            .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 2)
                    }
                }

                Spacer()

                // Title
                Text("What Day?")
                    .font(.system(size: 33))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                // Date pickers
                HStack {
                    // Day picker
                    Picker("Day", selection: $selectedDay) {
                        ForEach(1...daysInMonth(year: selectedYear, month: selectedMonth), id: \.self) { day in
                            Text(String(format: "%02d", day))
                                .foregroundColor(.white)
                                .tag(day)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .background(Color.black)
                    .cornerRadius(10)

                    // Month picker
                    Picker("Month", selection: $selectedMonth) {
                        ForEach(1...12, id: \.self) { month in
                            Text(String(format: "%02d", month))
                                .foregroundColor(.white)
                                .tag(month)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80)
                    .background(Color.black)
                    .cornerRadius(10)

                    // Year picker
                    Picker("Year", selection: $selectedYear) {
                        ForEach(1800...2300, id: \.self) { year in
                            Text(yearFormatted(year: year))
                                .foregroundColor(.white)
                                .tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    .background(Color.black)
                    .cornerRadius(10)
                }
                .padding()

                // Display selected date
                Text(getFormattedDate(year: selectedYear, month: selectedMonth, day: selectedDay))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding()

                Spacer()
            }
            .sheet(isPresented: $showAdsAndAppFunctionality) {
                ShowExplainView(onConfirm: {
                    showAdsAndAppFunctionality = false
                })
            }
            .padding()
            .background(Color(UIColor(red: 54/255, green: 57/255, blue: 63/255, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
        }
    }

    // Format the year as a string
    func yearFormatted(year: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.string(from: NSNumber(value: year)) ?? "\(year)"
    }

    // Calculate the number of days in a given month and year
    func daysInMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents), let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 30
    }

    // Get the formatted date string including the day of the week
    func getFormattedDate(year: Int, month: Int, day: Int) -> String {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy EEEE"
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
}

// Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// App entry point
struct WhatDayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Explain View

// View showing information about ads and the app functionality
struct ShowExplainView: View {
    var onConfirm: () -> Void

    var body: some View {
        ScrollView {
            VStack {
                // Section header
                HStack {
                    Text("Ads & App Functionality")
                        .font(.title3.bold())
                    Spacer()
                }
                Divider().background(Color.gray)

                // Ads section
                VStack {
                    // Ads header
                    HStack {
                        Text("Ads")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    // Ad image with link
//                    ZStack {
//                        Image("threedollar")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .cornerRadius(25)
//                            .clipped()
//                            .onTapGesture {
//                                if let url = URL(string: "https://b33.biz/three-dollar/") {
//                                    UIApplication.shared.open(url)
//                                }
//                            }
//                    }
                    
                    // App Cards for ads
                    VStack {
                        
                        Divider().background(Color.gray)
                        AppCardView(imageName: "sos", appName: "SOS Light", appDescription: "SOS Light is designed to maximize the chances of getting help in emergency situations", appURL: "https://apps.apple.com/app/s0s-light/id6504213303")
                        Divider().background(Color.gray)
                        
                        Divider().background(Color.gray)
                        AppCardView(imageName: "takemedication", appName: "Take Medication", appDescription: "Just press any of the 24 buttons, each representing an hour of the day, and you'll get timely reminders to take your medication. It's easy, quick, and ensures you never miss a dose!", appURL: "https://apps.apple.com/id/app/take-medication/id6736924598")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "timetell", appName: "TimeTell", appDescription: "Announce the time every 30 seconds, no more guessing and checking your watch, for time-sensitive tasks.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "SingLoop", appName: "Sing LOOP", appDescription: "Record your voice effortlessly, and play it back in a loop.", appURL: "https://apps.apple.com/id/app/sing-l00p/id6480459464")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "loopspeak", appName: "LOOPSpeak", appDescription: "Type or paste your text, play in loop, and enjoy hands-free narration.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "insomnia", appName: "Insomnia Sheep", appDescription: "Design to ease your mind and help you relax leading up to sleep.", appURL: "https://apps.apple.com/id/app/insomnia-sheep/id6479727431")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "dryeye", appName: "Dry Eye Read", appDescription: "The go-to solution for a comfortable reading experience, by adjusting font size and color to suit your reading experience.", appURL: "https://apps.apple.com/id/app/dry-eye-read/id6474282023")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "iprogram", appName: "iProgramMe", appDescription: "Custom affirmations, schedule notifications, stay inspired daily.", appURL: "https://apps.apple.com/id/app/iprogramme/id6470770935")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "temptation", appName: "TemptationTrack", appDescription: "One button to track milestones, monitor progress, stay motivated.", appURL: "https://apps.apple.com/id/app/temptationtrack/id6471236988")
                        Divider().background(Color.gray)
                    }
                    Spacer()
                }
                .padding()
                .cornerRadius(15.0)

                // App functionality section
                HStack {
                    Text("App Functionality")
                        .font(.title.bold())
                    Spacer()
                }

                Text("""
                • Users can scroll to choose a date.
                • The app displays the corresponding day of the week for the selected date.
                • It can show results for dates ranging from the year 1800 to 2300.
                """)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .padding()

                Spacer()

                HStack {
                    Text("What Day?? is developed by Three Dollar.")
                        .font(.title3.bold())
                    Spacer()
                }

                // Close button
                Button("Close") {
                    onConfirm()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.title3.bold())
                .cornerRadius(10)
                .padding()
                .shadow(color: Color.white.opacity(12), radius: 3, x: 3, y: 3)
            }
            .padding()
            .cornerRadius(15.0)
        }
    }
}

// MARK: - App Card View

// View displaying individual app cards
struct AppCardView: View {
    var imageName: String
    var appName: String
    var appDescription: String
    var appURL: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(7)

            VStack(alignment: .leading) {
                Text(appName)
                    .font(.title3)
                Text(appDescription)
                    .font(.caption)
            }
            .frame(alignment: .leading)

            Spacer()

            // Try button
            Button(action: {
                if let url = URL(string: appURL) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Try")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}


/*
//sudah great tapi mau ada improvement
import SwiftUI

struct ContentView: View {
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedDay = Calendar.current.component(.day, from: Date())
    @State private var showExplain = false
    
    var body: some View {
        ZStack {
            //bg color
            Color(UIColor(red: 54/255, green: 57/255, blue: 63/255, alpha: 1))
                            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                             showExplain = true
                         }) {
                             Image(systemName: "questionmark.circle.fill")
                                 .font(.system(size: 30))
                                 .foregroundColor(Color(.white))
                                 .padding()
                                 .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 2)
                     }
                }
                Spacer()
                HStack {
                    Text("What Day?")
                        .font(.system(size: 33))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
//                    Spacer()
                }
                .padding()
                
                
                HStack {
                    Picker("Day", selection: $selectedDay) {
                        ForEach(1...daysInMonth(year: selectedYear, month: selectedMonth), id: \.self) { day in
                            Text(String(format: "%02d", day))
                                .foregroundColor(.white)
                                .tag(day)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    Picker("Month", selection: $selectedMonth) {
                        ForEach(1...12, id: \.self) { month in
                            Text(String(format: "%02d", month))
                                .foregroundColor(.white)
                                .tag(month)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    Picker("Year", selection: $selectedYear) {
                        ForEach(1800...2300, id: \.self) { year in
                            Text(yearFormatted(year: year))
//                                .font(.footnote)
                                .foregroundColor(.white)
                                .tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    .background(Color.black)
                
                    .cornerRadius(10)
                }
                .padding()
                
                Text(getFormattedDate(year: selectedYear, month: selectedMonth, day: selectedDay))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
            }
            .sheet(isPresented: $showExplain) {
                ShowExplainView(onConfirm: {
                    showExplain = false
                })
            }
            .padding()
            .background(Color(UIColor(red: 54/255, green: 57/255, blue: 63/255, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        }
        
    }
    
    func yearFormatted(year: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.string(from: NSNumber(value: year)) ?? "\(year)"
    }
    
    func daysInMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents), let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 30
    }
    
    func getFormattedDate(year: Int, month: Int, day: Int) -> String {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy EEEE"
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WhatDayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Explain View
struct ShowExplainView: View {
    var onConfirm: () -> Void

    var body: some View {
        ScrollView {
            VStack {
               HStack{
                   Text("Ads & App Functionality")
                       .font(.title3.bold())
                   Spacer()
               }
                Divider().background(Color.gray)
              
                //ads
                VStack {
                    HStack {
                        Text("Ads")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    ZStack {
                        Image("threedollar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(25)
                            .clipped()
                            .onTapGesture {
                                if let url = URL(string: "https://b33.biz/three-dollar/") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                    // App Cards
                    VStack {
                        Divider().background(Color.gray)
                        AppCardView(imageName: "bodycam", appName: "BODYCam", appDescription: "Record videos effortlessly and discreetly.", appURL: "https://apps.apple.com/id/app/b0dycam/id6496689003")
                        Divider().background(Color.gray)
                        // Add more AppCardViews here if needed
                        // App Data
                     
                        
                        AppCardView(imageName: "timetell", appName: "TimeTell", appDescription: "Announce the time every 30 seconds, no more guessing and checking your watch, for time-sensitive tasks.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "SingLoop", appName: "Sing LOOP", appDescription: "Record your voice effortlessly, and play it back in a loop.", appURL: "https://apps.apple.com/id/app/sing-l00p/id6480459464")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "loopspeak", appName: "LOOPSpeak", appDescription: "Type or paste your text, play in loop, and enjoy hands-free narration.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "insomnia", appName: "Insomnia Sheep", appDescription: "Design to ease your mind and help you relax leading up to sleep.", appURL: "https://apps.apple.com/id/app/insomnia-sheep/id6479727431")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "dryeye", appName: "Dry Eye Read", appDescription: "The go-to solution for a comfortable reading experience, by adjusting font size and color to suit your reading experience.", appURL: "https://apps.apple.com/id/app/dry-eye-read/id6474282023")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "iprogram", appName: "iProgramMe", appDescription: "Custom affirmations, schedule notifications, stay inspired daily.", appURL: "https://apps.apple.com/id/app/iprogramme/id6470770935")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "temptation", appName: "TemptationTrack", appDescription: "One button to track milestones, monitor progress, stay motivated.", appURL: "https://apps.apple.com/id/app/temptationtrack/id6471236988")
                        Divider().background(Color.gray)
                    
                    }
                    Spacer()

                   
                   
                }
//                .padding()
//                .cornerRadius(15.0)
//                .padding()
                
                
                //ads end
                
                
                HStack{
                    Text("App Functionality")
                        .font(.title.bold())
                    Spacer()
                }
               
               Text("""
               • Users can scroll to choose a date.
               • The app displays the corresponding day of the week for the selected date.
               • It can show results for dates ranging from the year 1800 to 2300.
               """)
               .font(.title3)
               .multilineTextAlignment(.leading)
               .padding()
               
               Spacer()
                
                HStack {
                    Text("What Day?? is developed by Three Dollar.")
                        .font(.title3.bold())
                    Spacer()
                }

               Button("Close") {
                   // Perform confirmation action
                   onConfirm()
               }
               .font(.title)
               .padding()
               .cornerRadius(25.0)
               .padding()
           }
           .padding()
           .cornerRadius(15.0)
           .padding()
        }
    }
}

// MARK: - App Card View
struct AppCardView: View {
    var imageName: String
    var appName: String
    var appDescription: String
    var appURL: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(7)
            
            VStack(alignment: .leading) {
                Text(appName)
                    .font(.title3)
                Text(appDescription)
                    .font(.caption)
            }
            .frame(alignment: .leading)
            
            Spacer()
            Button(action: {
                if let url = URL(string: appURL) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Try")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

*/

/*

//dah bagus, namun mau tambah ads
import SwiftUI

struct ContentView: View {
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedDay = Calendar.current.component(.day, from: Date())
    
    var body: some View {
        ZStack {
            //bg color
            Color(UIColor(red: 54/255, green: 57/255, blue: 63/255, alpha: 1))
                            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("What Day?")
                        .font(.system(size: 44))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
//                    Spacer()
                }
                .padding()
                
                HStack {
                    Picker("Day", selection: $selectedDay) {
                        ForEach(1...daysInMonth(year: selectedYear, month: selectedMonth), id: \.self) { day in
                            Text(String(format: "%02d", day))
                                .foregroundColor(.white)
                                .tag(day)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    Picker("Month", selection: $selectedMonth) {
                        ForEach(1...12, id: \.self) { month in
                            Text(String(format: "%02d", month))
                                .foregroundColor(.white)
                                .tag(month)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    Picker("Year", selection: $selectedYear) {
                        ForEach(1800...2300, id: \.self) { year in
                            Text(yearFormatted(year: year))
//                                .font(.footnote)
                                .foregroundColor(.white)
                                .tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    .background(Color.black)
                    .cornerRadius(10)
                }
                .padding()
                
                Text(getFormattedDate(year: selectedYear, month: selectedMonth, day: selectedDay))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding()
                
                
            }
            .padding()
            .background(Color(UIColor(red: 54/255, green: 57/255, blue: 63/255, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        }
        
    }
    
    func yearFormatted(year: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.string(from: NSNumber(value: year)) ?? "\(year)"
    }
    
    func daysInMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents), let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 30
    }
    
    func getFormattedDate(year: Int, month: Int, day: Int) -> String {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy EEEE"
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WhatDayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

*/

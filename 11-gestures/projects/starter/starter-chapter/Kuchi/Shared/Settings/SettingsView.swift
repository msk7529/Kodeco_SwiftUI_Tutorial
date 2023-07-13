/// Copyright (c) 2023 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var challengesViewModel: ChallengesViewModel
        
    @State var dailyReminderTime = Date(timeIntervalSince1970: 0)
    
    @State var cardBackgroundColor: Color = .red
    
    @AppStorage("appearance") var appearance: Appearance = .automatic
    @AppStorage("dailyReminderEnabled") var dailyReminderEnabled = false
    @AppStorage("dailyReminderTime") var dailyReminderTimeShadow: Double = 0
    @AppStorage("learningEnabled") var learningEnabled: Bool = true
    @AppStorage("cardBackgroundColor") var cardBackgroundColorInt: Int = 0xFF0000FF

    var body: some View {
        List {
            Text("Settings")
                .font(.largeTitle)
                .padding(.bottom, 8)
            
            Section(header: Text("Appearance")) {
                VStack(alignment: .leading) {
                    Picker("", selection: $appearance) {
                        ForEach(Appearance.allCases) { appearance in
                            Text(appearance.name).tag(appearance)
                        }
                        /* ForEach로 대체 가능
                        Text(Appearance.light.name).tag(Appearance.light)
                        Text(Appearance.dark.name).tag(Appearance.dark)
                        Text(Appearance.automatic.name).tag(Appearance.automatic) */
                    }
                    .pickerStyle(.segmented)    // 디폴트 스타일은 automatic
                    
                    ColorPicker(
                        "Card Background Color",
                        selection: $cardBackgroundColor,
                        supportsOpacity: true  // 불투명도를 지원하는지. 기본값 true
                    )
                }
            }
                        
            Section(header: Text("Game")) {
                VStack(alignment: .leading) {
                    Stepper(
                        "Number of Questions: \(challengesViewModel.numberOfQuestions)",
                        value: $challengesViewModel.numberOfQuestions,
                        in: 3 ... 20
                    )
                    Text("Any change will affect the next game")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Toggle("Learning Enabled", isOn: $learningEnabled)
            }
            
            Section(header: Text("Notifications")) {
                HStack {
                    /* onChange가 추가(iOS14)되기 전 버전에서 사용
                    Toggle("Daily Reminder", isOn:
                            Binding(
                                get: { dailyReminderEnabled },
                                set: { newValue in
                                    dailyReminderEnabled = newValue
                                    configureNotification()
                                })
                    )*/
                    
                    Toggle("Daily Reminder", isOn: $dailyReminderEnabled)
                    
                    DatePicker(
                      "",
                      selection: $dailyReminderTime,
                      displayedComponents: [.hourAndMinute] // 디폴트는 [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact) // 디폴트가 compact. wheel, graphical 두가지 더 있음. wheel이 UIKit이랑 동일
                    .disabled(dailyReminderEnabled == false)
                }
            }
            .onChange(of: dailyReminderEnabled) { _ in
                configureNotification()
            }
            .onChange(of: dailyReminderTime) { newValue in
                dailyReminderTimeShadow = newValue.timeIntervalSince1970
                configureNotification()
            }
            .onChange(of: cardBackgroundColor, perform: { newValue in
                cardBackgroundColorInt = newValue.asRgba
            })
            .onAppear {
                dailyReminderTime = Date(timeIntervalSince1970: dailyReminderTimeShadow)
                cardBackgroundColor = Color(rgba: cardBackgroundColorInt)
            }
        }
    }
    
    func configureNotification() {
        if dailyReminderEnabled {
            // 현재 선택한 시간으로 새 미리 알림을 만든다.
            LocalNotifications.shared.createReminder(time: dailyReminderTime)
        } else {
            // 미리 알림 삭제
            LocalNotifications.shared.deleteReminder()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ChallengesViewModel())
    }
}

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

struct FlightStatusBoard: View {
    
    var shownFlights: [FlightInformation] {
        hidePast ? flights.filter { $0.localTime >= Date() } : flights
    }
    
    @State private var hidePast = false
    
    var flights: [FlightInformation]
    
    var body: some View {
        NavigationStack {
            List(shownFlights, id: \.id) { flight in
                NavigationLink(flight.statusBoardName, value: flight)   // 탐색 presentation을 제어하는 View
            }
            .navigationDestination(
                //  Destination View를 NaviationLink에서 제시된 Data 타입과 연결해주는 메서드
                // List에 여러타입이 들어있으면 navigationDestination을 여러개 쓰면 됨
                for: FlightInformation.self,
                destination: { flight in
                    // 리스트 선택시 화면 이동
                    FlightDetails(flight: flight)
                }
            )
            .navigationTitle("Today's Flight Status")
            .navigationBarItems(
                trailing: Toggle("Hide Past", isOn: $hidePast)
            )
        }
    }
}

struct FlightStatusBoard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FlightStatusBoard(
                flights: FlightData.generateTestFlights(date: Date())
            )
        }
        .environmentObject(FlightNavigationInfo())
    }
}

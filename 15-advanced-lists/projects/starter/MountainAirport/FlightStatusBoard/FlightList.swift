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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct FlightList: View {
    
    private var nextFlightId: Int {
        guard let flight = flights.first(where: { $0.localTime >= Date() }) else {
            return flights.last?.id ?? 0
        }
        return flight.id
    }
        
    var flights: [FlightInformation]
    var flightToShow: FlightInformation?
    
    @State private var path: [FlightInformation] = []
    @Binding var highlightedIds: [Int]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollViewReader { scrollProxy in
                List(flights) { flight in
                    NavigationLink(value: flight) {
                        FlightRow(flight: flight)
                    }
                    .listRowBackground(rowHighlighted(flight.id) ? Color.yellow.opacity(0.6) : Color.clear)
                    .swipeActions(edge: .leading) {
                        HighlightActionView(flightId: flight.id, highlightedIds: $highlightedIds)
                    }
                }
                .navigationDestination(
                    for: FlightInformation.self,
                    destination: { flight in
                        FlightDetails(flight: flight)
                    }
                )
                .onAppear {
                    scrollProxy.scrollTo(nextFlightId, anchor: .center)
                }
                
                /*ScrollView([/*.horizontal,*/ .vertical]) {
                    LazyVStack {
                        // flight가 Identifiable를 채택하면 아래처럼 ForEach에 Id를 명시하지 않고 사용할 수 있음
                        // ForEach(flights, id: \.id) { flight in
                        ForEach(flights) { flight in
                            NavigationLink(value: flight) {
                                FlightRow(flight: flight)
                            }
                        }
                        .navigationDestination(
                            for: FlightInformation.self,
                            destination: { flight in
                                FlightDetails(flight: flight)
                            }
                        )
                    }
                }
                .onAppear {
                    scrollProxy.scrollTo(nextFlightId, anchor: .center)
                }*/
            }
        }
        .onAppear {
            if let flight = flightToShow {
                path.append(flight)
            }
        }
    }
    
    func rowHighlighted(_ flightId: Int) -> Bool {
        return highlightedIds.contains { $0 == flightId }
    }
}

struct FlightList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FlightList(
                flights: FlightData.generateTestFlights(date: Date()),
                highlightedIds: .constant([15])
            )
        }
        .environmentObject(FlightNavigationInfo())
    }
}

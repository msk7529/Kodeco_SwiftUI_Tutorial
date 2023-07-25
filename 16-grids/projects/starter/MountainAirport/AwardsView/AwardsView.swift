/// Copyright (c) 2023 Kodeco Inc
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

struct AwardsView: View {
    
    var awardArray: [AwardInformation] {
        flightNavigation.awardList
    }
    
    var awardColumns: [GridItem] {
        [
            GridItem(.flexible(minimum: 150)),
            GridItem(.flexible(minimum: 150))
        ]
    }
    
    @EnvironmentObject var flightNavigation: AppEnvironment
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: awardColumns, spacing: 15) {
                    // 세로로 확장되는 그리드뷰
                    ForEach(awardArray) { award in
                        NavigationLink(value: award) {
                            AwardCardView(award: award)
                                .foregroundColor(.black)
                                .frame(width: 150, height: 220)
                        }
                    }
                }
                .navigationDestination(for: AwardInformation.self) { award in
                    AwardDetails(award: award)
                }
                .font(.title)
                .foregroundColor(.white)
                .padding()
                
                /*VStack {
                    HStack {
                        NavigationLink(value: awardArray[0]) {
                            AwardCardView(award: awardArray[0])
                                .foregroundColor(.black)
                                .frame(width: 150, height: 220)
                        }
                        
                        Spacer()
                        
                        NavigationLink(value: awardArray[1]) {
                            AwardCardView(award: awardArray[1])
                                .foregroundColor(.black)
                                .frame(width: 150, height: 220)
                        }
                    }
                    HStack {
                        AwardCardView(award: awardArray[2])
                            .foregroundColor(.black)
                            .frame(width: 150, height: 220)
                        
                        Spacer()
                        
                        AwardCardView(award: awardArray[3])
                            .foregroundColor(.black)
                            .frame(width: 150, height: 220)
                    }
                    Spacer()
                }
                .font(.title)
                .foregroundColor(.white)
                .padding()*/
            }
            .navigationTitle("Your Awards")
            .padding()
            .background(
                Image("background-view")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
            .environmentObject(AppEnvironment())
            .previewDevice(.init(rawValue: "iPhone 14 Pro"))
    }
}

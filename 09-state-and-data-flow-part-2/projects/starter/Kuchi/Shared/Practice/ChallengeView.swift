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

struct ChallengeView: View {
    
    let challengeTest: ChallengeTest
    
    @State var showAnswers = false
    @Binding var numberOfAnswered: Int
    
    @Environment(\.verticalSizeClass) var verticalSizeClass     // 디바이스 회전시에 값이 변경됨
    
    var body: some View {
        
        if verticalSizeClass == .compact {
            VStack {
                HStack {
                    Button(action: {
                        showAnswers.toggle()
                    }) {
                        QuestionView(question: challengeTest.challenge.question)
                            .frame(height: 300)
                    }
                    
                    if showAnswers {
                        Divider()
                        ChoicesView(challengeTest: challengeTest)
                            .frame(height: 300)
                            .padding()
                    }
                }
                
                ScoreView(numberOfAnswered: $numberOfAnswered, numberOfQuestions: 5)
            }
        } else {
            VStack {
                Button(action: {
                    showAnswers.toggle()
                }) {
                    QuestionView(question: challengeTest.challenge.question)
                        .frame(height: 300)
                }
                
                ScoreView(numberOfAnswered: $numberOfAnswered, numberOfQuestions: 5)
                
                if showAnswers {
                    Divider()
                    ChoicesView(challengeTest: challengeTest)
                        .frame(height: 300)
                        .padding()
                }
            }
        }
        
        /* Layout for Views With a Single Child 테스트
         Text("A great and warm welcome to Kuchi")
         .background(Color.red)
         .frame(width: 100, height: 50, alignment: .center)
         // Add this scale factor
         .minimumScaleFactor(0.5)
         .background(Color.yellow)
         */
        
        
        /* Layout for Container Views
         HStack {
         // 부모로부터 제안된 크기를 받고 이를 두개의 동일한 부분으로 나눈다.
         // 스택뷰는 자식 중 하나에 첫번째 크기를 제안하는데, 자식이 같기 때문에 왼쪽에 제안을 보낸다.
         // Text는 텍스트를 두 줄로 나타내야 하므로, 첫번째 뷰는 제안된 크기보다 작은 크기만을 필요로 한다.
         // 왼쪽 뷰를 제외한 크기를 오른쪽 뷰에 제안한다.
         Text("A great and warm welcome to Kuchi")
         .background(Color.red)
         Text("A great and warm welcome to Kuchi")
         .background(Color.red)
         }
         .background(Color.yellow)
         */
        
        /* Layout Priority 테스트
         HStack {
         Text("A great and warm welcome to Kuchi")
         .background(Color.red)
         
         Text("A great and warm welcome to Kuchi")
         // 필요한 만큼의 공간을 모두 사용할 수 있게 됨.
         .layoutPriority(1)
         .background(Color.red)
         
         Text("A great and warm welcome to Kuchi")
         .background(Color.red)
         }
         .background(Color.yellow)
         */
        
        /* Layout Priority 테스트
         HStack {
         // 우선순위: 중간 > 오른쪽 > 왼쪽
         Text("A great and warm welcome to Kuchi")
         .layoutPriority(-1)
         .background(Color.red)
         
         Text("A great and warm welcome to Kuchi")
         .layoutPriority(1)
         .background(Color.red)
         
         Text("A great and warm welcome to Kuchi")
         .background(Color.red)
         }
         .background(Color.yellow)
         */
        
        /* alignment 테스트
         HStack(alignment: .firstTextBaseline, spacing: nil) {
         // alignment: default center
         // spacing: default nil. OS에서 자동으로 정해줌
         Text("Welcome to Kuchi").font(.caption)
         Text("Welcome to Kuchi").font(.title)
         Button(action: {}, label: { Text("OK").font(.body) })
         }
         */
    }
}


struct ChallengeView_Previews: PreviewProvider {
    
    @State static var numberOfAnswered: Int = 0
    
    static let challengeTest = ChallengeTest(
        challenge: Challenge(
            question: "おねがい　します",
            pronunciation: "Onegai shimasu",
            answer: "Please"
        ),
        answers: ["Thank you", "Hello", "Goodbye"]
    )
    
    static var previews: some View {
        return ChallengeView(challengeTest: challengeTest, numberOfAnswered: $numberOfAnswered)
            .previewDevice(.init(rawValue: "iPhone 14 Pro"))
    }
}

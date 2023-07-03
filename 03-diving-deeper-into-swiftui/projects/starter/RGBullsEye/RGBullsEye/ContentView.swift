/// Copyright (c) 2023 Kodeco LLC
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

struct ContentView: View {
    
    // @State: 프로퍼티 값이 변경되면 body를 다시 계산한다.
    @State var game = Game()
    @State var guess: RGB
    @State var showScore = false
    
    let circleSize: CGFloat = 0.275
    let labelHeight: CGFloat = 0.06
    let labelWidth: CGFloat = 0.53
    let buttonWidth: CGFloat = 0.87
    
    var body: some View {
        GeometryReader { proxy in
            // proxy.size: safeArea를 제외한 영역의 사이즈
            ZStack {
                Color.element
                    .ignoresSafeArea()  // 화면 전체에 컬러 적용

                VStack {
                    ColorCircle(rgb: game.target, size: proxy.size.height * circleSize)

                    if !showScore {
                        /* Text("R: ??? G: ??? B: ???")
                            .padding()  // padding 값을 지정하지 않으면 content와 디바이스에 따라 자동으로 정해짐 */
                        BevelText(text: "R: ??? G: ??? B: ???", width: proxy.size.width * labelWidth, height: proxy.size.height * labelHeight)
                    } else {
                        BevelText(text: game.target.intString(), width: proxy.size.width * labelWidth, height: proxy.size.height * labelHeight)
                    }
                    
                    ColorCircle(rgb: guess, size: proxy.size.height * circleSize)

                    BevelText(text: guess.intString(), width: proxy.size.width * labelWidth, height: proxy.size.height * labelHeight)

                    ColorSlider(value: $guess.red, trackColor: .red)    // read-write binding
                    ColorSlider(value: $guess.green, trackColor: .green)
                    ColorSlider(value: $guess.blue, trackColor: .blue)
                    
                    Button("Hit Me!") {
                        showScore = true
                        game.check(guess: guess)
                    }
                    .buttonStyle(NeuButtonStyle(width: proxy.size.width * buttonWidth, height: proxy.size.height * labelHeight))
                    .alert(isPresented: $showScore) {
                        Alert(
                            title: Text("Your Score"),
                            message: Text(String(game.scoreRound)),
                            dismissButton: .default(Text("OK")) {
                                game.startNewRound()
                                guess = RGB()
                            })
                    }
                }
                .font(.headline)    // VStack 내의 텍스트에 headline 폰트스타일 적용
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ContentView(guess: RGB())   // 현재 실행중인 시뮬레이터의 디바이스로 설정됨
            ContentView(guess: RGB())
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            ContentView(guess: RGB())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}

struct ColorSlider: View {
    
    @Binding var value: Double  // 부모뷰로부터 초기값을 받아와 조작. 부모뷰에 전달된 값을 넘기기 위해 Binding으로 선언해야 함
    var trackColor: Color
    
    var body: some View {
        HStack {
            Text("0")
            Slider(value: $value)   // read-write binding
                .accentColor(trackColor)    // slider의 minimumTrackTintColor 컬러를 정의
            Text("255")
        }
        .padding(.horizontal)
        .font(.subheadline)
    }
}

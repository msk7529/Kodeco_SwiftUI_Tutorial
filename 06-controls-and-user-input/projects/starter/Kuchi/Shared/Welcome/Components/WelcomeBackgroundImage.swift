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

struct WelcomeBackgroundImage: View {
    var body: some View {
        GeometryReader { geometry in
            Image("welcome-background", bundle: nil)
                .resizable()
                .scaledToFit() // 원본 비율을 유지해서 부모에서 이미지가 완전히 보이도록 함. 바로 아래에서 fill로 채우기 때문에 주석해도 무관함.
                .aspectRatio(1 / 1, contentMode: .fill) // 1 / 1: 기본 설정, fill: 상위 뷰 전체를 채움
                .frame(width: geometry.size.width, alignment: .center)  // 키보드가 올라오면 이미지가 오른쪽으로 밀리는 문제를 방지하기 위함
                .edgesIgnoringSafeArea(.all)
                .saturation(0.5)    // 채도를 낮춘다.
                .blur(radius: 5)
                .opacity(0.08)
        }
    }
}

struct WelcomeBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeBackgroundImage()
    }
}

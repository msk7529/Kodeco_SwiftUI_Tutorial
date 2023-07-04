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

struct RegisterView: View {
    
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            Spacer()
            
            WelcomeMessageView()
            
            /* 커스텀 뷰를 통한 커스터마이징
            TextField("Type your name...", text: $name)
                .textFieldStyle(KuchiTextStyle()) */
            
            TextField("Type your name...", text: $userManager.profile.name)
                .submitLabel(.done)     // 키보드 return 버튼을 done으로 변경
                .bordered()     // ViewModifier을 이용한 커스터마이징
            
            Button(action: registerUser) {
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                    Text("OK")
                        .font(.body)
                        .bold()
                }
                .bordered()
            }
            
            Spacer()
        }
        .padding()  // 텍스트필드 좌우 패딩을 주기 위함
        .background(WelcomeBackgroundImage())
    }
}

extension RegisterView {
    
    func registerUser() {
        userManager.persistProfile()
      }
}

struct KuchiTextStyle: TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))   // 텍스트필드 내에 상하좌우 인셋 적용
            .background(.white)
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 2)   // 스트로크 효과를 추가하여 테두리만 유지하고 뒷 내용은 보이게 한다.
                .foregroundColor(.blue)
            )
            .shadow(color: .gray.opacity(0.4), radius: 3, x: 1, y: 2)
    }
}

struct RegisterView_Previews: PreviewProvider {
    
    static let user = UserManager(name: "Ray")
    
    static var previews: some View {
        RegisterView()
            .environmentObject(user)    // UserManager 주입
    }
}

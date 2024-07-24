//
//  MenuView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI


struct MenuView: View {
    @EnvironmentObject private var coordinator: SceneCoordinator
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State var isOn: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {}
                   , label: {
                CustomText(font: .pretendard, title: "공지사항", textColor: .customGray200, textWeight: .regular, textSize: 16, textAlignment: .leading)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: UIScreen.UIWidth(311), minHeight: UIScreen.UIHeight(52), alignment: .leading)
                    .padding(.leading, UIScreen.UIWidth(16))
                Image("ic_arrowRight")
                    .padding(.trailing, UIScreen.UIWidth(11))
            })
            .background(Color(UIColor.customGray800))
            .cornerRadius(8)
            .padding(.bottom, UIScreen.UIHeight(20))
            
            Button(action: {}
                   , label: {
                CustomText(font: .pretendard, title: "문의사항", textColor: .customGray200, textWeight: .regular, textSize: 16, textAlignment: .leading)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: UIScreen.UIWidth(311), minHeight: UIScreen.UIHeight(52), alignment: .leading)
                    .padding(.leading, UIScreen.UIWidth(16))
                Image("ic_arrowRight")
                    .padding(.trailing, UIScreen.UIWidth(11))
            })
            .background(Color(UIColor.customGray800))
            .cornerRadius(8)
            .padding(.bottom, UIScreen.UIHeight(20))
            
            Button(action: {}
                   , label: {
                CustomText(font: .pretendard, title: "열람실 종료 시간 알림", textColor: .customGray200, textWeight: .regular, textSize: 16, textAlignment: .leading)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: UIScreen.UIWidth(311), minHeight: UIScreen.UIHeight(52), alignment: .leading)
                    .padding(.leading, UIScreen.UIWidth(16))
                Toggle("", isOn: $isOn)
                    .padding(.trailing, UIScreen.UIWidth(14))
                //                    .toggleStyle(SwitchToggleStyle(tint: Color(UIColor.customBlue100)))
                    .toggleStyle(ColoredToggleStyle(onColor:Color(UIColor.customBlue100)))
                
            })
            .background(Color(UIColor.customGray800))
            .cornerRadius(8)
            
            Spacer()
            
            HStack(spacing: 0) {
                Button(action: {authViewModel.send(action: .logOut); coordinator.popToRoot()}, label: {
                    CustomText(font: .pretendard, title: "로그아웃", textColor: .customGray300, textWeight: .regular, textSize: 16)
                        .frame(width: UIScreen.UIWidth(56), height: UIScreen.UIHeight(26))
                })

                CustomText(font: .pretendard, title: "|", textColor: .customGray300, textWeight: .regular, textSize: 16)
                    .padding(.horizontal, UIScreen.UIWidth(24))
                
                Button(action: {}, label: {
                    CustomText(font: .pretendard, title: "회원탈퇴", textColor: .customGray300, textWeight: .regular, textSize: 16)
                        .frame(width: UIScreen.UIWidth(56), height: UIScreen.UIHeight(26))
                })
            }
            
        }
        .customNavigation(left: {
            Button(action: {
                coordinator.pop()
            }, label: {
                Image("ic_back")
            })
        })
    }
}



struct ColoredToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .animation(Animation.easeInOut(duration: 0.2))
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

#Preview {
    MenuView()
}

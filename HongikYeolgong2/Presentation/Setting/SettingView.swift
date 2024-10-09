
import SwiftUI

struct SettingView: View {
    @State private var isOnAlarm = false
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            HStack(spacing: 0) {
                Image(.settingIcon)
                    .padding(.trailing, 19)
                Text("유림")
                    .font(.pretendard(size: 16, weight: .regular))
                    .padding(.trailing, 8)
                    .foregroundStyle(.gray200)
                Text("|")
                    .font(.pretendard(size: 16, weight: .regular))
                    .padding(.trailing, 8)
                    .foregroundStyle(.gray300)
                Text("디자인컨버전스학부")
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(.gray200)
            }
            .padding(.bottom, 20.adjustToScreenHeight)
            
            Button(action: {}
                   , label: {
                Text("공지사항")
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray200)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: .infinity,
                           minHeight: 52.adjustToScreenHeight, alignment: .leading)
                    .padding(.leading, 16.adjustToScreenWidth)
                
                Image(.arrowRight)
                    .padding(.trailing, 11)
            })
            .background(Color.gray800)
            .cornerRadius(8)
            .padding(.bottom, 20.adjustToScreenHeight)
            
            Button(action: {}
                   , label: {
                Text("문의사항")
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray200)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: .infinity,
                           minHeight: 52.adjustToScreenHeight, alignment: .leading)
                    .padding(.leading, 16.adjustToScreenWidth)
                
                Image(.arrowRight)
                    .padding(.trailing, 11)
            })
            .background(Color.gray800)
            .cornerRadius(8)
            .padding(.bottom, 20.adjustToScreenHeight)
            
            Button(action: {}
                   , label: {
                Text("열람실 종료 시간 알림")
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray200)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: .infinity,
                           minHeight: 52.adjustToScreenHeight, alignment: .leading)
                    .padding(.leading, 16.adjustToScreenWidth)
                
                Toggle("", isOn: Binding(
                    get: { isOnAlarm },
                    set: {
                        isOnAlarm = $0
                    }
                ))
                .toggleStyle(ColoredToggleStyle(onColor:Color.blue100))
            })
            .background(Color.gray800)
            .cornerRadius(8)
            .padding(.bottom, 16.adjustToScreenHeight)
            
            HStack(spacing: 0) {
                Image(.icInformation)
                    .padding(.trailing, 6.adjustToScreenWidth)
                Text("열람실 종료 10분, 30분 전에 알림을 보내 연장을 돕습니다.")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(.gray300)
            }
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("로그아웃")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(Color.gray300)
                })
                
                Text("|")
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray300)
                    .padding(.horizontal, 24.adjustToScreenWidth)
                
                Button(action: {
                    
                }, label: {
                    Text("회원탈퇴")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(Color.gray300)
                })
                Spacer()
            }
            .padding(.bottom, 36.adjustToScreenHeight)
        }
        .padding(.top, 16.5.adjustToScreenHeight)
        .padding(.horizontal, 16.adjustToScreenWidth)
        .background(.dark)
    }
}

struct ColoredToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color.green
    var offColor = Color.gray200
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
                    .onChange(of: configuration.isOn) { _ in
                        withAnimation(.easeInOut(duration: 0.25)) {
                        }
                    }
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

#Preview {
    SettingView()
}

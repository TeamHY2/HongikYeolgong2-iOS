
import SwiftUI

struct SettingView: View {
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
                Text("공지사항")
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray200)
                    .minimumScaleFactor(0.2)
                    .frame(maxWidth: .infinity,
                           minHeight: 52.adjustToScreenHeight, alignment: .leading)
                    .padding(.leading, 16.adjustToScreenWidth)
                
                Image(.arrowRight)
                    .padding(.trailing, 11.adjustToScreenWidth)
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

#Preview {
    SettingView()
}

//
//  SharedView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 2/18/25.
//

import SwiftUI
import Photos

struct SharedView: View {
    @Binding var isPresented: Bool
    @Binding var isToastShow: Bool
    // 이미지 저장 실패 애러 토스트 표시
    @State var isErrorToastShow: Bool = false
    // 권한 설정 차단 알림
    @State var isSettingModalPresented: Bool = false
    
    var image: UIImage
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Spacer()
                // 닫기 버튼
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15.adjustToScreenWidth, height: 15.adjustToScreenHeight)
                        .foregroundStyle(.gray100)
                }
                .padding(.vertical, 14.adjustToScreenHeight)
            }
            
            Text("열공 기록을 공유해보세요!")
                .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
                .foregroundStyle(.gray100)
            
            
            Spacer()
                .frame(height: 12.adjustToScreenHeight)
            
            // 미리보기 이미지
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color(.sRGB, red: 82/255, green: 82/255, blue: 82/255, opacity: 1),
                                    Color(.sRGB, red: 60/255, green: 60/255, blue: 60/255, opacity: 1),
                                    Color(.sRGB, red: 46/255, green: 46/255, blue: 46/255, opacity: 1)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            , lineWidth: 1)
                )
            
            
            Spacer()
                .frame(height: 20.adjustToScreenHeight)
            
            // 하단 버튼
            HStack(spacing: 10.adjustToScreenWidth) {
                // 이미지 저장 버튼
                Button {
                    saveImage()
                } label: {
                    HStack(spacing: 4){
                        Image(.downloadSimple)
                        Text("이미지 저장")
                            .font(.pretendard(size: 16, weight: .semibold))
                            .foregroundStyle(.gray100)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 52.adjustToScreenHeight)
                    .background(.gray800)
                    .cornerRadius(4)
                }
                
                // 인스타 공유 버튼
                Button {
                    shareToInstagram()
                } label: {
                    HStack(spacing: 4){
                        Image(.instagramLogo)
                        Text("인스타 공유")
                            .font(.pretendard(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 52.adjustToScreenHeight)
                    .background(.blue100)
                    .cornerRadius(4)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .background {
            Image(.recordShareBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
        .toast(isToastShow: $isErrorToastShow, text: "이미지 저장에 실패했습니다. 다시 시도해주세요.")
        .overlay {
            if isSettingModalPresented {
                ZStack {
                    Color.black.opacity(0.75).ignoresSafeArea(.all)
                ModalView(isPresented: $isSettingModalPresented,
                          title: "사진 저장을 원하시면\n'설정'을 눌러\n'사진'접근을 허용해주세요.",
                          confirmButtonText: "설정",
                          cancleButtonText: "확인",
                          confirmAction: moveToSetting )
                }
            }
        }
    }
    
    /// 이미지 저장
    func saveImage() {
        let status = PHPhotoLibrary.authorizationStatus()
        // 접근 권한 상태 확인
        if status == .authorized {
            // 이미지 저장
            saveToPhotosAlbum()
        } else if status == .denied || status == .restricted {
            isSettingModalPresented.toggle()
        } else {
            // 접근 권한 여부 설정
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    saveToPhotosAlbum()
                } else {
                    isSettingModalPresented.toggle()
                }
            }
        }
    }
    
    // 이미지 앨범 저장 상태 처리
    private func saveToPhotosAlbum() {
        PHPhotoLibrary.shared().performChanges({
            _ = PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { success, error in
            DispatchQueue.main.async {
                if success {
                    // 이미지 저장 완료
                    isToastShow = true
                    isPresented.toggle()
                } else {
                    // 이미지 저장 실패
                    isErrorToastShow = true
                }
            }
        }
    }
    
    // 앱 설정 경로 이동
    func moveToSetting() {
        guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingUrl) {
            UIApplication.shared.open(settingUrl)
        }
    }
    
    /// 인스타 공유
    func shareToInstagram() {
        let appID = SecretKeys.metaAppID
        
        // 인스타 설치 확인
        guard let instagramURL = URL(string: "instagram-stories://share"),
              UIApplication.shared.canOpenURL(instagramURL) else {
            // 인스타 설치 링크
            guard let instagramURL = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252") else {
                return
            }
            return UIApplication.shared.open(instagramURL)
        }
        
        // png파일로 이미지 변환 및 스토리 주소 등록
        guard let stickerData = image.pngData(),
              let urlScheme = URL(string: "instagram-stories://share?source_application=\(appID)") else { return }
        
        let pasteboardItems: [String: Any] = [
            "com.instagram.sharedSticker.backgroundImage": stickerData
        ]
        
        let pasteboardOptions = [
            UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)
        ]
        
        UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
        UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
    }
}

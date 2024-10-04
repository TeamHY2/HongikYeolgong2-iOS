//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI

struct SignInView: View {
    @State private var isDisabled = true
    @State private var selectedDepartment = ""
    @State private var inputDepartment = ""
    @State private var nickname = ""
    
    private let departments = [
        "건설도시공학부",
        "건설환경공학과",
        "건축학부",
        "경영학부",
        "경제학부",
        "공연예술학부",
        "금속조형디자인과",
        "기계시스템디자인공학과",
        "국어교육과",
        "국어국문학과",
        "도시공학과",
        "독어독문학과",
        "동양화과",
        "도예유리과",
        "디자인경영융합학부",
        "디자인·예술경영학부",
        "디자인학부",
        "물리교육과",
        "법학부",
        "불어불문학과",
        "사회교육과",
        "산업디자인학과",
        "산업·데이터공학과",
        "섬유미술패션디자인과",
        "수학교육과",
        "신소재화공시스템공학부",
        "영어교육과",
        "영어영문학과",
        "역사교육과",
        "예술학과",
        "응용미술학과",
        "일본어문학과",
        "전자전기공학부",
        "조소과",
        "컴퓨터공학과",
        "판화과",
        "프랑스어문학과",
        "회화과"
    ]
    
    var body: some View {
        ZStack {
            Color.dark.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                titleView
                
                // 가입폼
                VStack(spacing: 0) {
                    // 닉네임
                    nicknameField
                    
                    selecteDepartment
                }
                .padding(.top, 23)
                
                Spacer()
                
                HY2Button(title: "",
                          style: .imageButton(image: isDisabled ? .submitButtonDisable : .submitButtonEnable)) {
                    
                }
                          .padding(.bottom, 20)
            }
            .padding(.horizontal, 32)
            
        }
    }
    
    private var titleView: some View {
        Text("회원가입")
            .font(.suite(size: 18, weight: .bold))
            .foregroundStyle(.gray100)
            .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
    }
    
    private var nicknameField: some View {
        VStack {
            HStack {
                Text("닉네임")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(.gray200)
                
                Spacer()
            }
            
            HStack {
                HY2TextField(text: $nickname,
                             placeholder: "닉네임을 입력해주세요",
                             isError: false)
                
                HY2Button(title: "중복확인", style: .mediumButton, backgroundColor: .blue100) {
                    isDisabled = false
                }
                .frame(width: 88)
            }
            .padding(.top, 8)
            
            HStack {
                Text("* 한글, 영어, 숫자를 포함하여 2~8자를 입력해 주세요.")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(.gray400)
                    .padding(.top, 4)
                Spacer()
            }
        }
    }
    
    private var selecteDepartment: some View {
        VStack(spacing: 0) {
            HStack {
                Text("학과")
                    .font(.pretendard(size: 16, weight: .bold))
                    .foregroundStyle(.gray200)
                
                Spacer()
            }
            
            DropDownPicker(text: $inputDepartment,
                           seletedItem: $selectedDepartment,
                           placeholder: "학과를 입력해주세요",
                           items: departments)
            .padding(.top, 8)
        }
        .padding(.top, 12)
    }
}

//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.injected) var injected: DIContainer
    @State private var isDisabled = true
    @State private var selectedDepartment: Department = .appliedArts
    @State private var inputDepartment = ""
    @State private var nickname = ""
    
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
        .toolbar(.hidden, for: .navigationBar)
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
                           seletedItem: Binding(get: {
                selectedDepartment.rawValue
            }, set: {
                selectedDepartment = .init(rawValue: $0) ?? .appliedArts
            }),
                           placeholder: "학과를 입력해주세요",
                           items: Department.allCases.map { $0.rawValue })
            .padding(.top, 8)
        }
        .padding(.top, 12)
    }
}

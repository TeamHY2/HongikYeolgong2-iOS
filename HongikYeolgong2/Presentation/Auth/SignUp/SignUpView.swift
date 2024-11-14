//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI

struct SignUpView: View {
   @State private var nickname = ""
   @State private var department = ""
   @FocusState private var focused
   
   var body: some View {
       VStack {
           FormTitle(title: "회원가입")
           
           VStack {
               Spacer()
                   .frame(maxHeight: 23)
               
               VStack(alignment: .leading, spacing: 4.adjustToScreenHeight) {
                   FormLabel(title: "닉네임")
                   
                   HStack(spacing: 10.adjustToScreenHeight) {
                       BaseTextField(text: $nickname,
                                     placeholder: "닉네임을 입력해주세요.",
                                     isError: false)
                       
                       DuplicateCheckButton(action: {},
                                            disabled: false)
                   }
                   
                   FormDescription(message: "설명", color: Color.gray)
               }
               .layoutPriority(1)
               
               VStack(alignment: .leading, spacing: 8.adjustToScreenHeight) {
                   FormLabel(title: "학과")
                   
                   DropDownPicker(text: $department,
                                seletedItem: $department,
                                placeholder: "",
                                items: Department.allDepartments())
               }
               .layoutPriority(2)
           }
           
           Spacer()
           
           SubmitButton(action: {}, disabled: false)
               .padding(.bottom, 20.adjustToScreenHeight)
       }
       .padding(.horizontal, 32.adjustToScreenWidth)
   }
}

struct FormTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.suite(size: 18, weight: .bold))
            .foregroundStyle(.gray100)
            .frame(
                maxWidth: .infinity,
                maxHeight: 52.adjustToScreenHeight,
                alignment: .leading
            )
    }
}

struct FormLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
            .foregroundStyle(.gray200)
    }
}

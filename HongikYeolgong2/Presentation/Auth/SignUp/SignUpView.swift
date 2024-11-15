//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    
    @State private var nickname: Nickname = .none
    @State private var department: Department = .none
    @State private var inputNickname = ""
    @State private var inputDepartment = ""
    
    @FocusState private var focused
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(maxHeight: 52 + 23.adjustToScreenHeight)
                
                VStack(alignment: .leading, spacing: 0) {
                    FormLabel(title: "닉네임")
                    
                    Spacer()
                        .frame(height: 8.adjustToScreenHeight)
                    
                    HStack(spacing: 10.adjustToScreenHeight) {
                        BaseTextField(text: $inputNickname,
                                      placeholder: "닉네임을 입력해주세요.",
                                      isError: nickname.isError)
                        
                        DuplicateCheckButton(action: {},
                                             disabled: !nickname.isCheckable)
                    }
                    
                    Spacer()
                        .frame(height: 4.adjustToScreenHeight)
                    
                    FormDescription(message: nickname.message, color: Color.gray)
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(height: 12.adjustToScreenHeight)
                
                VStack(alignment: .leading, spacing: 8.adjustToScreenHeight) {
                    FormLabel(title: "학과")
                    
                    DropDownPicker(text: $inputDepartment,
                                   seletedItem: Binding(get: {
                        department.rawValue
                    }, set: {
                        department = .init(rawValue: $0) ?? .none
                    }),
                                   placeholder: "",
                                   items: Department.allDepartments())
                }
                .layoutPriority(2)
            }
            
            Spacer()
            
            SubmitButton(action: {
                
            }, disabled: !(nickname == .checkAvailable &&
                           (Department.allDepartments().contains(department.rawValue) ||
                            Department.allDepartments().contains(inputDepartment))))
            .padding(.bottom, 20.adjustToScreenHeight)
        }
        .overlay(alignment: .topLeading, content: {
            FormTitle(title: "회원가입")
        })
        .toolbar(.hidden, for: .navigationBar)
        .padding(.horizontal, 32.adjustToScreenWidth)
        .onChange(of: inputNickname) {
            userDataInteractor.validateUserNickname(inputNickname: $0, nickname: $nickname)
        }
    }
}

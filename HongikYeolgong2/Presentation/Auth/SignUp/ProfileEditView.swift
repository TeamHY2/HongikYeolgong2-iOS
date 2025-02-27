//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI

struct ProfileEditView: View {
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    
    @State private var nickname: Nickname = .none
    @State private var department: Department = .none
    @State private var inputNickname = ""
    @State private var inputDepartment = ""
    @State private var loadState: Loadable<Bool> = .notRequest
    @State private var isPresented: Bool = false
    @State private var isEditing = false
    @Environment(\.presentationMode) var dismiss
    
    let isEdit: Bool
    
    @FocusState private var focused
    
    private var isDepartmentSelecte: Bool {
        (Department.allDepartments.contains(department.rawValue) || Department.allDepartments.contains(inputDepartment))
    }
    
    private var isNicknameCheked: Bool {
        nickname == .available
    }
    
    private var isEditCompleted: Bool {
        isEdit && isEditing
    }
    
    init(nickname: String, department: String) {
        self.inputNickname = nickname
        self.inputDepartment = department
        self.department = Department(rawValue: department) ?? .none
        self.nickname = .none
        self.isEdit = true
    }
    
    init() {
        self.isEdit = false
    }
    
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
                        BaseTextField(
                            text: $inputNickname,
                            placeholder: "닉네임을 입력해주세요.",
                            isError: nickname.isError
                        )
                        
                        DuplicateCheckButton(
                            action: { userDataInteractor.checkUserNickname(inputNickname: inputNickname, nickname: $nickname) },
                            disabled: nickname.isCheckable
                        )
                        .disabled(!(nickname == .checkAvailable))
                    }
                    
                    Spacer()
                        .frame(height: 4.adjustToScreenHeight)
                    
                    FormDescription(
                        message: nickname.message,
                        color: nickname.textColor
                    )
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(height: 12.adjustToScreenHeight)
                
                VStack(alignment: .leading, spacing: 8.adjustToScreenHeight) {
                    FormLabel(title: "학과")
                    
                    DropDownPicker(
                        text: $inputDepartment,
                        seletedItem: Binding(
                            get: { department.rawValue },
                            set: { department = .init(rawValue: $0) ?? .none }
                        ),
                        placeholder: "",
                        items: Department.allDepartments
                    )
                }
                .layoutPriority(2)
            }
            
            Spacer()
            
            SubmitButton(
                isEdit: isEdit,
                action: editButtonTap,
                disabled: !((isNicknameCheked && isDepartmentSelecte) || isEditCompleted)
            )
            .padding(.bottom, 20.adjustToScreenHeight)
        }
        .overlay(alignment: .topLeading, content: {
            if isEdit {
                HStack {
                    Button(action: {
                        dismiss.wrappedValue.dismiss()
                    }, label: {
                        Image(.icProfileLeft)
                        Text("프로필 변경")
                            .font(.suite(size: 18, weight: .bold))
                            .foregroundStyle(.gray100)
                    })
                    Spacer()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 52.adjustToScreenHeight,
                    alignment: .leading
                )
                .background(Color.black)
            } else {
                Text("회원가입")
                    .font(.suite(size: 18, weight: .bold))
                    .foregroundStyle(.gray100)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 52.adjustToScreenHeight,
                        alignment: .leading
                    )
                    .background(Color.black)
            }
        })
        .toolbar(.hidden, for: .navigationBar)
        .padding(.horizontal, 32.adjustToScreenWidth)
        .systemOverlay(isPresented: $isPresented) {
            ModalView(isPresented: $isPresented,
                      title: "프로필 변경을 진행하실건가요?",
                      confirmButtonText: "변경하기",
                      cancleButtonText: "돌아가기",
                      confirmAction: performUpdate )
        }
        .onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
        .onChange(of: inputNickname) {
            userDataInteractor.validateUserNickname(inputNickname: $0, nickname: $nickname)
        }
        .onChange(of: nickname) { nickname in
            if isEdit && nickname == .available {
                isEditing = true
            }
        }
        .onChange(of: inputDepartment) { department in
            guard Department.allDepartments.contains(department) else { return }
            isEditing = true
        }
        .onChange(of: department) { department in
            guard department != .none else {
                isEditing = false
                return
            }
            isEditing = true
        }
        .onChange(of: loadState.value) { value in
            guard let isSuccess = value else { return }
            if isSuccess {
                dismiss.wrappedValue.dismiss()
            }
        }
        
    }
    
    func editButtonTap() {
        if isEdit {
            isPresented = true
        } else {
            userDataInteractor.signUp(nickname: inputNickname, department: department, loadbleSubject: $loadState)
        }
    }
    
    func performUpdate() {
        userDataInteractor.profileEdit(nickname: inputNickname, department: department, loadbleSubject: $loadState)
    }
}

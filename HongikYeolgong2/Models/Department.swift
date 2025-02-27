//
//  Department.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/19/24.
//

import Foundation

enum Department: String, CaseIterable {
    case none = ""
    case constructionUrban = "건설도시공학부"
    case civilEnvironmental = "건설환경공학과"
    //    case architecture = "건축학부"
    case business = "경영학부"
    case economics = "경제학부"
    case performingArts = "공연예술학부"
    case metalDesign = "금속조형디자인과"
    case mechanicalSystem = "기계시스템디자인공학과"
    case koreanEdu = "국어교육과"
    case koreanLit = "국어국문학과"
    case urbanPlanning = "도시공학과"
    case germanLit = "독어독문학과"
    case orientalPainting = "동양화과"
    case ceramics = "도예유리과"
    case designManagement = "디자인경영융합학부"
    case designArtManagement = "디자인·예술경영학부"
//    case design = "디자인학부"
    case physicsEdu = "물리교육과"
    case law = "법학부"
    case frenchLit = "불어불문학과"
    case socialEdu = "사회교육과"
//    case industrialDesign = "산업디자인학과"
    case industrialData = "산업·데이터공학과"
    case textileFashion = "섬유미술패션디자인과"
    case mathEdu = "수학교육과"
    //    case materials = "신소재화공시스템공학부"
    case englishEdu = "영어교육과"
    case englishLit = "영어영문학과"
    case historyEdu = "역사교육과"
    case artStudies = "예술학과"
    case appliedArts = "응용미술학과"
    case electricalElectronic = "전자전기공학부"
    case sculpture = "조소과"
    case computerScience = "컴퓨터공학과"
    case frenchStudies = "프랑스어문학과"
    case painting = "회화과"
    case architecture5Years = "건축학전공(5년제)"
    case interiorArchitecture = "실내건축학전공"
    case materialsEngineering = "신소재공학전공"
    case chemicalEngineering = "화학공학전공"
    case japaneseLiterature = "일본어문학과"
//    case printmaking = "판화과"
    case visualDesign = "시각디자인전공"
    case industrialDesignMajor = "산업디자인전공"
    case autonomousMajor = "캠퍼스자율전공"
    
    static var allDepartments: [String] {
        Self.allCases.filter { $0 != .none }.map { $0.rawValue }
    }
}

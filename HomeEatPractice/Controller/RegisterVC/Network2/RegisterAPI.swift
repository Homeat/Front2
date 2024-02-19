//
//  RegisterAPI.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/19/24.
//

import Foundation
import Alamofire
import UIKit

class RegisterAPI{
    
    
    
    static let baseURL = "https://dev.homeat.site/"
    
    
    static func verification(email : String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = "v1/members/email-verification"
        let url = baseURL + endpoint
        
        let verifyInfo = verifyRequest(email: email)
        //post요청 생성
        AF.request(url, method: .post, parameters: verifyInfo, encoder: JSONParameterEncoder.default).responseDecodable(of: verifyResponse.self) { response in
            //api호출에 대한 응답처리
            switch response.result {
            case .success(let verifyresponse):
                print("인증 api 연결 성공")
                if verifyresponse.isSuccess{
                    print("인증 번호 받기 성공")
                    print(verifyresponse.data?.authCode ?? "123")
                    UserDefaults.standard.set(verifyresponse.data?.authCode, forKey: "verifyCode")
                    completion(.success(""))
                    
                }else{
                    print("인증번호 받기 실패")
                }
            
                

            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    static func addExtraData(gender : String, birth : String, income : Int, goalPrice : Int, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = "v1/members/mypage"
        let url = baseURL + endpoint
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "registerToken") {
            // 옵셔널이 nil이 아닌 경우에만 이 코드 블록이 실행됩니다.
            // token을 안전하게 사용할 수 있습니다.
            loginToken = token
        } else {
            // 옵셔널이 nil인 경우에는 이 코드 블록이 실행됩니다.
            print("토큰이 없습니다.")
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
        ]
        
        
        let extraInfo = extraRequest(gender: gender, birth: birth, income: income, goalPrice: goalPrice)
        //post요청 생성
        AF.request(url, method: .post, parameters: extraInfo, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: extraResponse.self){ response in
            // 네트워크 요청에 대한 응답 처리
            switch response.result {
            case .success(let extraResponse):
                if extraResponse.isSuccess {
                    // 성공적으로 응답을 받았을 때 처리할 내용
                    print(extraResponse)
                    completion(.success(""))
                } else {
                    // 실패했을 때 처리할 내용
                    // 실패 이유는 expenseResponse.message 등에서 확인할 수 있음
                    let error = NSError(domain: "v1/members/mypage", code: 0, userInfo: [NSLocalizedDescriptionKey: extraResponse.message])
                    completion(.failure(error))
                    print(error)
                    print(extraResponse.code)
                    print(extraResponse.data)
                }
            case .failure(let error):
                // 네트워크 요청 실패 처리
                print(error)
                completion(.failure(error))
            }
        }
        
    }
    
}


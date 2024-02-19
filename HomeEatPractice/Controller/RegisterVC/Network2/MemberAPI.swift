//
//  MemberAPI.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/4/24.
//

// GeneralAPI.swift

import Alamofire

class MemberAPI {
    static let baseURL = "https://dev.homeat.site/"
    
//    static func saveMemberInfo(email : String, password : String, nickname : String,  completion: @escaping (Result<Void, Error>) -> Void) {
//        let endpoint = "v1/members/join"
//        let url = baseURL + endpoint
//        
//        let registerInfo = RegisterData(email: email, password: password, nickname: nickname)
//        //post요청 생성
//        
//        AF.request(url, method: .post, parameters: registerInfo, encoder: JSONParameterEncoder.default)
//            .response { response in
//                //api호출에 대한 응답처리
//                switch response.result {
//                    
//                case .success:
//                    completion(.success(()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
    
    static func saveMemberInfo(email : String, password : String, nickname : String,  completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = "v1/members/join"
        let url = baseURL + endpoint
        
        let registerInfo = RegisterData(email: email, password: password, nickname: nickname)
        //post요청 생성
        
        AF.request(url, method: .post, parameters: registerInfo, encoder: JSONParameterEncoder.default).responseDecodable(of: RegisterResponse.self){
            response in
            switch response.result {
            case .success(let registerResponse):
                print(registerResponse)
                print("registerAPI 호출 성공")
                if registerResponse.isSuccess, let tokenData = registerResponse.data {
                    UserDefaults.standard.set(tokenData.token, forKey: "registerToken")
                    print(UserDefaults.standard.string(forKey: "registerToken"))
                    print("등록 완료")
                    completion(.success(()))
                } else {
                    print("등록 실패")
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "등록 실패"]) // 실패 시 오류 반환
                                    completion(.failure(error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print("registerAPI 호출 실패")
                completion(.failure(error))
            }
        }
    }
    
    static func postLoginInfo(email : String, password : String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = "v1/members/login"
        let url = baseURL + endpoint
        
        let loginInfo = LoginData(email: email, password: password)
        //post요청 생성
        AF.request(url, method: .post, parameters: loginInfo, encoder: JSONParameterEncoder.default).responseDecodable(of: LoginResponse.self) { response in
            //api호출에 대한 응답처리
            switch response.result {
            case .success(let loginResponse):
                if loginResponse.isSuccess, let tokenData = loginResponse.data {
                    UserDefaults.standard.set(tokenData.token, forKey: "loginToken")
                    UserDefaults.standard.set(tokenData.expiredAt, forKey: "loginTokenExpired")
                    print(UserDefaults.standard.string(forKey: "loginToken"))
                    print(UserDefaults.standard.string(forKey: "loginTokenExpired"))
                    completion(.success(tokenData.token))
                } else {
                    let error = NSError(domain: "LoginError", code: -1, userInfo: [NSLocalizedDescriptionKey: loginResponse.message])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getUserInfo(jwtToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = "v1/members/mypage"
        let url = baseURL + endpoint
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(jwtToken)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: MypageResponse.self){ response in
            switch response.result{
            case . success(let mypageResponse) :
                print("호출 성공")
                print(mypageResponse)
                //homeItem부분을 userdefaults에 저장
                if let userItem = mypageResponse.data {
                    do {
                        let encodedData = try JSONEncoder().encode(userItem)
                        UserDefaults.standard.set(encodedData, forKey: "userInfo")
                        UserDefaults.standard.set(userItem.nickname, forKey: "userNickname")
                        UserDefaults.standard.set(userItem.email, forKey: "userEmail")
                        UserDefaults.standard.set(userItem.address.fullNm, forKey: "userAddress")
                        UserDefaults.standard.synchronize()
                    } catch {
                        print("Error encoding HomeItem:", error)
                    }
                } else {
                    print("No HomeItem found in HomeResponse.")
                }
                completion(.success(""))
            case .failure(let error):
                print("호출 실패")
                completion(.failure(error))
            }
        }
        
    }
}

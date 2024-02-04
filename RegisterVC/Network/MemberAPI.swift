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

    static func saveMemberInfo(email : String, password : String, nickname : String,  completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = "v1/members/join"
        let url = baseURL + endpoint

        let memberInfo = MemberData(email: email, password: password, nickname: nickname)
        //post요청 생성
        
        AF.request(url, method: .post, parameters: memberInfo, encoder: JSONParameterEncoder.default)
            .response { response in
                //api호출에 대한 응답처리
                switch response.result {
                
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

//
//  FoodGeneralAPI.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/28.
//

import Alamofire

class FoodGeneralAPI {
    static let baseURL = "https://dev.homeat.site/"

    static func saveFoodTalk(name: String, memo: String, tag: String, completion: @escaping (Result<FoodId, Error>) -> Void) {
        let endpoint = "v1/foodTalk/save"
        let url = baseURL + endpoint
 
        let parameters: [String: Any] = [
            "name": name,
            "memo": memo,
            "tags": tag
        ]
        //post요청 생성
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: FoodId.self) { response in
                switch response.result {
                case .success(let foodTalk):
                    completion(.success(foodTalk))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    static func uploadImages(foodTalkID: Int, images: [UIImage], completion: @escaping (Result<Void, Error>) -> Void) {
            let endpoint = "v1/foodTalk/upload/images/\(foodTalkID)"
            let url = baseURL + endpoint

            let headers: HTTPHeaders = [
                "Content-Type": "multipart/form-data"
            ]

            AF.upload(multipartFormData: { multipartFormData in
                for (index, image) in images.enumerated() {
                    guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
                    // "imgUrl" 키에 대한 배열 형식으로 이미지 데이터를 전송
                    multipartFormData.append(imageData, withName: "imgUrl", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            }, to: url, method: .post, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

import UIKit
import Alamofire

class GeneralAPI {
    static let baseURL = "https://dev.homeat.site/"

    static func saveInfoTalk(title: String, content: String, tags: [String], accessToken: String,completion: @escaping (Result<InfoTalk, Error>) -> Void) {
        let endpoint = "v1/infoTalk/save"
        let url = baseURL + endpoint

        let parameters: [String: Any] = [
            "title": title,
            "content": content,
            "tags": tags
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
            ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: InfoTalk.self) { response in
                switch response.result {
                case .success(let infoTalk):
                    completion(.success(infoTalk))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    static func uploadImages(infoTalkID: Int, images: [UIImage], completion: @escaping (Result<Void, Error>) -> Void) {
            let endpoint = "v1/infoTalk/upload/images/\(infoTalkID)"
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


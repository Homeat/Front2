import UIKit
import Alamofire

class HomeAPI {
    static let baseURL = "https://dev.homeat.site/"
    
    static func postExpense(money : Int, type : String, memo : String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = "v1/home/add-expense"
        let url = baseURL + endpoint
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
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
        
        
        let expenseInfo = ExpenseData(money: money, type: type, memo: memo)
        //post요청 생성
        AF.request(url, method: .post, parameters: expenseInfo, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: ExpenseResponse.self){ response in
            // 네트워크 요청에 대한 응답 처리
            switch response.result {
            case .success(let expenseResponse):
                if expenseResponse.isSuccess {
                    // 성공적으로 응답을 받았을 때 처리할 내용
                    completion(.success(""))
                } else {
                    // 실패했을 때 처리할 내용
                    // 실패 이유는 expenseResponse.message 등에서 확인할 수 있음
                    let error = NSError(domain: "v1/home/add-expense", code: 0, userInfo: [NSLocalizedDescriptionKey: expenseResponse.message])
                    completion(.failure(error))
                    print(error)
                    print(expenseResponse.code)
                    print(expenseResponse.data)
                }
            case .failure(let error):
                // 네트워크 요청 실패 처리
                completion(.failure(error))
            }
        }
        
    }
    
    static func uploadImage(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = "v1/home/receipt"
        let url = baseURL + endpoint
        var loginToken = ""
        
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
            loginToken = token
        } else {
            // 옵셔널이 nil인 경우에는 이 코드 블록이 실행됩니다.
            print("토큰이 없습니다.")
            return
            
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(loginToken)",
            "Content-Type": "multipart/form-data"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    // 이미지 데이터를 추가합니다.
                    multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }, to: url, method: .post, headers: headers)
        .validate()
        .responseDecodable(of: ExpenseResponse.self) { response in
            switch response.result {
            case .success(let data):
                print("api 호출 성공")
                // 성공적으로 디코딩된 데이터를 처리합니다.
                if data.isSuccess{
                    print("이미지 업로드 성공")
//                    postExpense(money: <#T##Int#>, type: <#T##String#>, memo: <#T##String#>, completion: <#T##(Result<String, Error>) -> Void#>)
                    print(data.data)
                    completion(.success(()))
                }else{
                    print("이미지 업로드 실패:")
                    print(data.code)
                    print(data.data)
                }
            case .failure(let error):
                print("api호출 실패")
                completion(.failure(error))
            }
        }
    }


    
    
    static func getHomeData(completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = "v1/home/"
        let url = baseURL + endpoint
        var loginToken = ""
        if let token = UserDefaults.standard.string(forKey: "loginToken") {
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
        
        AF.request(url, headers: headers).responseDecodable(of: HomeResponse.self){ response in
            switch response.result{
            case . success(let homeResponse) :
                
                //homeItem부분을 userdefaults에 저장
                if let homeItem = homeResponse.data {
                    do {
                        let encodedData = try JSONEncoder().encode(homeItem)
                        UserDefaults.standard.set(encodedData, forKey: "homeItemData")
                        UserDefaults.standard.synchronize()
                    } catch {
                        print("Error encoding HomeItem:", error)
                    }
                } else {
                    print("No HomeItem found in HomeResponse.")
                }
                completion(.success(""))
            case .failure(let error):
                completion(.failure(error))
            }}
        
    }
    
}

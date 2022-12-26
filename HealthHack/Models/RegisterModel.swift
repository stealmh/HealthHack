//
//  RegisterModel.swift
//  HealthHack
//
//  Created by kimminho on 2022/12/26.
//

import Foundation
import Firebase
import FirebaseAuth


final class RegisterModel: ObservableObject {
    @Published var currentUser: Firebase.User?
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    //회원가입
    func registerUser(userID: String, userPW: String) async{
        
        do {
            let result = try await Auth.auth().createUser(withEmail: userID, password: userPW)
            let user = result.user
            print(user.uid)
        }
        
        catch {
            let code = (error as NSError).code
            switch code {
            case 17007:
                print("이미 있는 아이디")
            case 17008:
                print("올바름 이메일 형식이 아님")
            case 17026:
                print("비밀번호가 6자리 미만")
            default:
                return
            }
            
        }
    }
    
    // 로그인
    func login(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.currentUser = result?.user
                
                //나중에 document 접근할 때 사용할 유저 uid
                print(self.currentUser!.uid)

        }
    }
    
    // 로그아웃
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
}

//
//  FirebaseManager.swift
//  Diff App
//
//  Created by Jacob Goldfarb on 2019-01-19.
//  Copyright © 2018 Jacob Goldfarb. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

//MARK: - Custom Errors
enum BackendError: Error {
    case userFetchError
    case articleFetchError
    case topicFetchError
}
extension BackendError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userFetchError:
            return "Could not find the user's information."
        case .articleFetchError:
            return "Could not get the article information."
        case .topicFetchError:
            return "Could not get the topic information."
        }
    }
}
//TODO: change completion to return optionals
///Singleton responsible for handling calls to firebase backend.
class FirebaseManager {

    static let shared = FirebaseManager()

    //MARK: - Private references to database and userID
    private var ref: DatabaseReference {
        return Database.database().reference()
    }
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }
    private var currentDate: String{
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return "\(month)-\(day)-\(year)"
    }
    
    func addEmotionRecognitionAttempt(_ correct: Bool) {
        guard let userid = userID else { return }
       ref.child("users").child(userid).child("facialExpressionProgress").child(currentDate).child("date").setValue(currentDate)
        ref.child("users").child(userid).child("facialExpressionProgress").child(currentDate).child("totalAttempts").observeSingleEvent(of: .value) { (snapshot) in
            if let attempts = snapshot.value as? Int{
                self.ref.child("users").child(userid).child("facialExpressionProgress").child(self.currentDate).child("totalAttempts").setValue(attempts + 1)
                
            }
            else{
                self.ref.child("users").child(userid).child("facialExpressionProgress").child(self.currentDate).child("totalAttempts").setValue(1)
            }
        }
        guard correct else { return }
        ref.child("users").child(userid).child("facialExpressionProgress").child(currentDate).child("correctAttempts").observeSingleEvent(of: .value) { (snapshot) in
            if let attempts = snapshot.value as? Int{
                self.ref.child("users").child(userid).child("facialExpressionProgress").child(self.currentDate).child("correctAttempts").setValue(attempts + 1)
                
            }
            else{
                self.ref.child("users").child(userid).child("facialExpressionProgress").child(self.currentDate).child("correctAttempts").setValue(1)
            }
        }
    }
    func addObjectDetectionAttempt(_ correct: Bool) {
        guard let userid = userID else { return }
        ref.child("users").child(userid).child("objectDectionProgress").child(currentDate).child("date").setValue(currentDate)
        ref.child("users").child(userid).child("objectDectionProgress").child(currentDate).child("totalAttempts").observeSingleEvent(of: .value) { (snapshot) in
            if let attempts = snapshot.value as? Int{
                self.ref.child("users").child(userid).child("objectDectionProgress").child(self.currentDate).child("totalAttempts").setValue(attempts + 1)
                
            }
            else{
                self.ref.child("users").child(userid).child("objectDectionProgress").child(self.currentDate).child("totalAttempts").setValue(1)
            }
        }
        guard correct else { return }
        ref.child("users").child(userid).child("objectDectionProgress").child(currentDate).child("correctAttempts").observeSingleEvent(of: .value) { (snapshot) in
            if let attempts = snapshot.value as? Int{
                self.ref.child("users").child(userid).child("objectDectionProgress").child(self.currentDate).child("correctAttempts").setValue(attempts + 1)
                
            }
            else{
                self.ref.child("users").child(userid).child("objectDectionProgress").child(self.currentDate).child("correctAttempts").setValue(1)
            }
        }
    }
    func setNewUser(userName: String) {
        guard let userid = userID else { return }
        ref.child("users").child(userid).setValue([
            "userName": userName,
            "avatar": "empty",
            "facialExpressionProgress": "empty",
            "objectDectionProgress": "empty",
        ]){
            (error: Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be save: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
    func getUserName(completion: @escaping (String?)->()) {
        guard let userid = userID else { return}
        ref.child("users").child(userid).observeSingleEvent(of: .value){ (snapshot) in
            if let snapshotValue = snapshot.value as? [String: Any]{
                for (key, value) in snapshotValue{
                    if key == "userName"{
                        completion(value as? String)
                    }
                }
            }
        }
    }

}


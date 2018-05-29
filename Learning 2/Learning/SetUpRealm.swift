//
//  SetUpRealm.swift
//  VuforiaSampleSwift
//
//  Created by sara alhasan on 5/9/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import RealmSwift

class SetUpRealm {
    
    static var realm : Realm?
    
    static func setupRealm(completion: @escaping (_ realm: Realm?) -> Void) {
        
        let username = "rawan.abdullah.bs@hotmail.com"
        let password = "FerasA123"
        
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://54.86.92.188:9080/")!) { user, error in
            
            guard let user = user else {
                completion(nil)
                print("no completion")
                fatalError(String(describing: error))
                
            }
            
            DispatchQueue.main.async {
                
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://54.86.92.188:9080/fe533bbd57b525833ed3618a28abb009")!)
                )
                completion(try? Realm(configuration: configuration))
                
            }
        }
}

}

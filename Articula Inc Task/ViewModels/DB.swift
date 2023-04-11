//
//  DB.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation
import FirebaseFirestore


class DB {
    
    static var  shared = DB()
    private init(){}
    
    var firebase = Firestore.firestore()
    
}

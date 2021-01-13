//
//  TestDataObjectChange.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/4/21.
//

import Foundation
import Combine

class Submodel1: ObservableObject {
  @Published var count = 0
}


class MainModel: ObservableObject {
  @Published var submodel1: Submodel1 = Submodel1()

    var anyCancellable: AnyCancellable? = nil

    init() {
        anyCancellable = submodel1.objectWillChange.sink { (_) in
            self.objectWillChange.send()
        }
    }
}

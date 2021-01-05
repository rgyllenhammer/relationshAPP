//
//  TestView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/4/21.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var session : MainModel = MainModel()
    
    var body: some View {
        VStack {
            Text("\(session.submodel1.count)")
            Button(action: {
                session.submodel1.count += 1
            }, label : {
                Text("Update")
            })
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

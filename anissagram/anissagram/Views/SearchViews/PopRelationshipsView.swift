//
//  PopRelationshipsView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/12/21.
//

import SwiftUI

struct PopRelationshipsView: View {
    @EnvironmentObject var session : SessionStore
    @Binding var lastConversation : String
    @Binding var show : Bool
    
    func createUserNames(relationships: NSDictionary?) -> [String]{
        return relationships?.allKeys as? [String] ?? Array(repeating: "nil", count: 25)
    }
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack {
                VStack {
                    PoplistView(userNames: createUserNames(relationships: session.session?.relationships), lastConversation: $lastConversation, show: $show)
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(Color.black)
                            .frame(width: 15, height: 15, alignment: .center)
                            .padding(20)
                    })
                    .background(Color.white)
                    .clipShape(Circle())
                }
            }
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
    
    
    }
}

//struct PopRelationshipsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopRelationshipsView()
//    }
//}

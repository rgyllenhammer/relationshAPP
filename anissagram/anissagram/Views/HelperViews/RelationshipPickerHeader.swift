//
//  RelationshipPickerHeader.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/14/21.
//

import SwiftUI

struct RelationshipPickerHeader: View {
    @Binding var show : Bool
    @Binding var lastConversation : String
    var descriptor : String // one word such as "With" or "For" or "And" or "From"
    var body: some View {
        VStack{
            HStack{
                Text(descriptor)
                Text("@\(lastConversation)").foregroundColor(.aYellow)
                    .foregroundColor(.aYellow)
                    .onTapGesture {
                        self.show.toggle()
                    }
                Spacer()
            }.font(.title3)
        }
        .padding(.bottom)
    }
}

//struct RelationshipPickerHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        RelationshipPickerHeader()
//    }
//}

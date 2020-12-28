////
////  TestView.swift
////  anissagram
////
////  Created by Reese Gyllenhammer on 12/27/20.
////
//
//import SwiftUI
//
//struct TestView: View {
//
//    @State var show = false
//    var body: some View {
//        ZStack {
//            ZStack(alignment: .bottomTrailing) {
//
//                NavigationView {
//                    List(0..<5, id:\.self) { _ in
//                        HStack {
//                            Image("anissagram").resizable().frame(width: 50, height: 50)
//                            Text("Testing")
//                        }
//                    }.navigationBarTitle("Home")
//                }
//                Button(action: {
//
//                    withAnimation {
//                        self.show.toggle()
//                    }
//
//                }, label: {
//                    Text("Button")
//                })
//
//            }.background(Color.black)
//
//            if self.show {
//                GeometryReader{ geometry in
//                    VStack {
//                        VStack {
//                            PoplistView()
//                            Button(action: {
//                                self.show.toggle()
//                            }, label: {
//                                Image(systemName: "xmark")
//                                    .resizable()
//                                    .foregroundColor(Color.black)
//                                    .frame(width: 15, height: 15, alignment: .center)
//                                    .padding(20)
//                            })
//                            .background(Color.white)
//                            .clipShape(Circle())
//                        }
//                    }
//                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
//                }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
//            }
//
//
//        }
//    }
//}
//
//struct PoplistView: View {
//    var body : some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack {
//                ForEach(0..<25, id: \.self) { i in
//                    ZStack(alignment: .trailing) {
//                        HStack {
//                            Image("anissagram").resizable()
//                                .frame(width: 55, height: 55)
//                                .clipShape(Circle())
//                            VStack(alignment: .leading) {
//                                Text("@ranchgod\(i)").fontWeight(.semibold)
//                                Text("Hello reese")
//                                Divider()
//                            }
//                            .padding(.top)
//
//                        }
//                        Image(systemName: "arrow.right").foregroundColor(.gray)
//                    }
//
//                }
//            }
//            .padding()
//        }
//        .background(Color.white)
//        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height - 400 , alignment: .center)
//    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}

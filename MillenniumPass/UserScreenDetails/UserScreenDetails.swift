//
//  UserScreenDetails.swift
//  MillenniumPass
//
//  Created by Szymon Szysz on 09/10/2021.
//

import SwiftUI

struct UserScreenDetails: View {

    var user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20, content: {
                Image(uiImage: user.uiImage ?? UIImage())

                VStack(alignment: .leading, spacing: 0, content: {

                    Text("Department")
                        .font(.system(.callout))

                    Text("Departament rozwoju aplikacji")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)

                    VSPacer()

                    Text("Name")
                        .font(.system(.callout))

                    Text("\(user.name) \(user.surname)")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)

                    VSPacer()

                    Text("Email")
                        .font(.system(.callout))

                    Text("szymon.szysz@bankmillennium.pl")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .foregroundColor(.magenta)

                })
                .frame(width: .infinity, height: .infinity, alignment: .top)
            })
            .padding()
        }
    }
}

fileprivate struct VSPacer: View {

    var height: CGFloat = 20.0

    var body: some View {
        HStack { }.frame(width: .infinity, height: height, alignment: .top)
    }
}

struct UserScreenDetails_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(name: "Name", surname: "Surname", imageBase64: "")
        UserScreenDetails(user: user)
    }
}

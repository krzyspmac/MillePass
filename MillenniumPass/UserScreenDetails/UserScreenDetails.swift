//
//  UserScreenDetails.swift
//  MillenniumPass
//
//  Created by Szymon Szysz on 09/10/2021.
//

import SwiftUI

struct UserScreenDetails: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Image("mille_icon-colorful")
            
            VStack(alignment: .leading, spacing: 20, content: {
              
                Text("Departament rozwoju aplikacji")
                    .font(.system(.title2, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                HStack {
                    Text("Imię i nazwisko:")
                        .font(.system(.title2, design: .rounded))
                        .bold()
                        .multilineTextAlignment(.leading)
                    Text("Szymon Szysz")
                        .font(.system(.title2, design: .rounded))
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    Text("E-mail:")
                        .font(.system(.title2, design: .rounded))
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("szymon.szysz@bankmillennium.pl")
                        .font(.system(.title2, design: .rounded))
                        .multilineTextAlignment(.center)
                }
                
                HStack {
                    Text("XNUC:")
                        .font(.system(.title2, design: .rounded))
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("X170213")
                        .font(.system(.title2, design: .rounded))
                        .multilineTextAlignment(.center)
                }
            })
        })
    }
}

struct UserScreenDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserScreenDetails()
    }
}
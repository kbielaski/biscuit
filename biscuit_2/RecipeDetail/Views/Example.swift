//
//  Example.swift
//  biscuit_2
//
//  Created by kelly on 7/20/25.
//

import SwiftUI

struct LoginForm: View {
    enum Field: Hashable {
        case username
        case password
    }

    @State private var username = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .focused($focusedField, equals: .username)

            SecureField("Password", text: $password)
                .focused($focusedField, equals: .password)

            Button("Sign In") {
                if username.isEmpty {
                    print("In here")
                    focusedField = .username
                } else if password.isEmpty {
                    focusedField = .password
                } else {
                    //
                }
                print(focusedField as Any)
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height,
            alignment: .center
        )
    }
}

struct LoginForm_Previews:
    PreviewProvider
{
    static var previews: some View {
        LoginForm()
    }
}

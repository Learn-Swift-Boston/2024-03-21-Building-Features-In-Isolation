import SwiftUI

public struct AuthModel {
    var email: String
    var password: String

    var isValid = true
    var credentialsWrong = false
//    var signUpForMailingList: Bool = false

    public init(
        email: String = "",
        password: String = "",
        isValid: Bool = true
    ) {
        self.email = email
        self.password = password
        self.isValid = isValid
    }
}

// pale imitation of the "controlling the world" approach from Point-Free
// see also: https://github.com/pointfreeco/swift-dependencies
public struct AuthClient {
    public var signIn: (_ email: String, _ password: String) async -> Bool = { _, _ in fatalError("Implement signIn") }

    public func signIn(email: String, password: String) async -> Bool {
        await signIn(email, password)
    }

    public static var shared = AuthClient()
}


public struct AuthView: View {

    @State private var model: AuthModel

    private var didSignIn: () -> Void

    public init(
        initialModel: AuthModel = .init(),
        didSignIn: @escaping () -> Void
    ) {
        _model = .init(initialValue: initialModel)
        self.didSignIn = didSignIn
    }

    public var body: some View {
        Form {
            TextField("Email", text: $model.email)
            SecureField("Password", text: $model.password)
//            Toggle("Get spam?", isOn: $model.signUpForMailingList)
            Button("Sign In") {
                guard !model.email.isEmpty, !model.password.isEmpty else {
                    model.isValid = false
                    return
                }
                Task {
                    print("tapped")
                    if await AuthClient.shared.signIn(email: model.email, password: model.password) {
                        didSignIn()
                        model.credentialsWrong = false
                    } else {
                        model.credentialsWrong = true
                    }
                }
            }
            if !model.isValid {
                Text("Form is invalid")
                    .foregroundStyle(.red)
            }
            if model.credentialsWrong {
                Text("Form is invalid")
                    .foregroundStyle(.pink)
            }
        }
        .onChange(of: model.email + model.password) { oldValue, newValue in
            print("changed")
            validate()
        }
    }

    func validate() {
        model.isValid = !model.email.isEmpty && !model.password.isEmpty
    }
}

#Preview("Default") {
    AuthClient.shared.signIn = { user, pass in
        print("tried to sign in with \(user) and \(pass)")
        return true
    }
    return AuthView {
        print("did sign in")
    }
}

#Preview("Invalid") {
    AuthView(
        initialModel: .init(email: "a@b.c", password: "", isValid: false),
        didSignIn: {
            print("did sign in")
        }
    )
}

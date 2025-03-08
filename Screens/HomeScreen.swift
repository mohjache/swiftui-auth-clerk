import SwiftUI

struct HomeScreen : View{
    var data = ["Hello", "World"]
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(data, id: \.self) { d in
                        Text(d)
                    }
                }
            }

        }
    }
}


#Preview {
    HomeScreen()
}

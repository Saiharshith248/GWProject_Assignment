import SwiftUI
import _PhotosUI_SwiftUI


struct ImageView: View {
    
    let item: PhotosPickerItem
    @State private var uiImage: UIImage?
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 50, height: 50)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    uiImage = UIImage(data: data)
                }
            }
        }
        .onChange(of: item) { newItem in
            // Handle changes to the item, like loading a new image
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    uiImage = UIImage(data: data)
                }
            }
        }
    }
}

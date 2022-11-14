//
//  AsyncImageView.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI
import CachedAsyncImage

struct AsyncImageView: View {
    let url: String
    
    var body: some View {
        
        CachedAsyncImage(url: URL(string: url), urlCache: .imageCache) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 80)
            case .success(let image):
                image
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 80)
            case .failure:
                Image(systemName: "questionmark")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 80)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: "ss")
    }
}

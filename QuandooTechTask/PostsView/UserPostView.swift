//
//  UserPostView.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 28/02/2024.
//

import SwiftUI
import Services

struct UserPostView: View {
    @ObservedObject var viewModel: UserPostsViewModel
    var body: some View {
        VStack {
            switch viewModel.fetchingStatus {
            case .fetched:
                ScrollView {
                    ForEach(viewModel.posts, id: \.id) { post in
                        PostCell(
                            viewModel: post
                        )
                    }
                }.refreshable {
                    viewModel.fetchPosts()
                }
                .padding(.bottom)
            case .loading:
                ProgressView()
                    .scaleEffect(1.0, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
            case .empty:
                InfoView(action: { viewModel.fetchPosts() }, type: .noData)
            case .error:
                InfoView(action: { viewModel.fetchPosts() }, type: .error)
            }
        }
        .background(.black)
        .navigationTitle("Posts")
    }
}

fileprivate struct PostCell: View {
    let viewModel: Post
    
    var body: some View {
        HStack {
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Title").font(.caption2).foregroundStyle(.gray)
                    Text(viewModel.title).font(.headline)
                    Text("Content").font(.caption2).foregroundStyle(.gray)
                    Text(viewModel.body).font(.headline)
                }
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            .padding(16)
            .frame(maxWidth: .greatestFiniteMagnitude)
            .foregroundColor(Color.white)
            .cornerRadius(8)
            .multilineTextAlignment(.leading)
        }
        .background(Color(uiColor: UIColor(red: 0.19, green: 0.18, blue: 0.11, alpha: 1.00)))
        .cornerRadius(8)
        .padding()
        .padding(.horizontal, 16)
    }
}

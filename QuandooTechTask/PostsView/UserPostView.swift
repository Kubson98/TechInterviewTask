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
    var backButtonTapped: () -> ()
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.posts, id: \.id) { post in
                    LargeCell(
                        viewModel: post
                    )
                }
            }.refreshable {
                viewModel.fetchPosts()
            }
            .padding(.bottom)
        }
        .background(.black)
    }
}


fileprivate struct LargeCell: View {
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

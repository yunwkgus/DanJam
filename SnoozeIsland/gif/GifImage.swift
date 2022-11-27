//
//  GifImage.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/02/04.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String
    
    init(_ name:String){
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
//        if name.contains("sleep") {return}
        
        let webView = WKWebView()
        
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        webView.isOpaque = true
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context){
        uiView.reload()
    }

}

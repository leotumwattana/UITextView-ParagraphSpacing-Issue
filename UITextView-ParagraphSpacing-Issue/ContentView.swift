//
//  ContentView.swift
//  UITextView-ParagraphSpacing-Issue
//
//  Created by Leo Tumwattana on 13/9/2022.
//

import SwiftUI
import UIKit

/**
 # The issue:
 When UITextView using TextKit2 has:
 
 1. content with paragraphSpacing that is greater than zero.
 2. TextLayoutFragment with marginTop / marginBottom that is greater than zero.
 
 then behaviour of keyboard navigation moving up / down line fragments is incorrect.
 
 ## Issue 1: (Screen recording: https://www.dropbox.com/s/7wd8cgy6pd1tu1n/1%20-%20Incorrect%20Up%20Arrow%20Caret%20Navigation%20Behavior.mp4?dl=0)
 For example, try running this project and then placing the caret at the end of the 4th paragraph and then trying to press up arrow to move the caret to the 3rd
 paragraph. The caret will not move to the 3rd paragraph, but instead cycles around the 4th paragraph.
 
 ## Issue 2: (Screen recording: https://www.dropbox.com/s/clvo4qdt1w5walc/2%20-%20Buggy%20Caret%20Drag%20Navigation%20Behavior.mp4?dl=0)
 Furthermore, dragging the caret between paragraphs will cause the caret to jump to the end of the document and the intended location. This causes a problem if the document is long enough to be scrolled as the UITextView's content offset will jump erratically as the caret moves around.
 */

struct ContentView: View {
    var body: some View {
        TextView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView(usingTextLayoutManager: true)
        view.attributedText = NSAttributedString(
            string: "1. This is a sample project\n2. to illustrate the issue of UITextView (TextKit2) caret navigation when\n3. it's content has paragraph spacing that is greater than zero.\n4. This issue also happens if the TextLayoutFragment has non-zero top or bottom margin set. The quick brown fox jumps over the lazy dog.",
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .body),
                .paragraphStyle: NSParagraphStyle.paragraphStyleWithParagraphSpacing
            ]
        )
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) { }
}

extension NSParagraphStyle {
    static var paragraphStyleWithParagraphSpacing: NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.paragraphSpacing = 16
        return style
    }
}

//
//  LinguaDeLadeiraWidget.swift
//  LinguaDeLadeiraWidget
//
//  Created by Juliano Vaz on 11/02/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
//    let titulo: Text
//    let tipoCarta: Text
//    let historiaCarta: Text
//    let nomeDaImagem: Text
    
}

struct LinguaDeLadeiraWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
//        Text(entry.date, style: .time)
        GeometryReader { geometry in
            HStack(alignment: .center){
                Image("Forms")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
//                    .padding(.trailing, -iconPadding(width: geometry.size.width))
                    .frame(width: UIScreen.main.bounds.width*0.4, height:UIScreen.main.bounds.width*0.3)
            
                
                VStack (alignment: .leading){
                    Spacer()
                    
                    Image("Tag Item")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 20)
                        
                    
                    Text("Cheiroso Bigode")
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding(.bottom, 2)
                    
                    Text("Depois de passar um ano na vontade, você finalmente pode ir pular carnaval com a galera da Academy, hosteados no Bigode pelo ilustre Forminhos.")
                        .font(.caption)
                    
                  
                    Spacer()
                }
                Spacer()
            }
            .font(.title)
            .foregroundColor(.black)
            .frame(minWidth: geometry.size.width)
            .background(Color.white)
        }
    }
}

@main
struct LinguaDeLadeiraWidget: Widget {
    let kind: String = "LinguaDeLadeiraWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LinguaDeLadeiraWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct LinguaDeLadeiraWidget_Previews: PreviewProvider {
    static var previews: some View {
        LinguaDeLadeiraWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

//
//  SmallTimeTableWidget.swift
//  SmallTimeTableWidget
//
//  Created by 김도훈 on 3/4/24.
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
}

struct SmallTimeTableWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                HStack {
                    Text(entryDateFormatted)
                        .font(Font.custom("Noto Sans KR", size: 48).weight(.bold))
                        .multilineTextAlignment(.leading)
                        .frame(width: nil, height: 42.0)
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Spacer()
                }
                Spacer()
                Text("1교시")
                    .font(Font.custom("Noto Sans KR", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .opacity(0.50)
            }
            Spacer()
            HStack(alignment: .center, spacing: 8) {
                Text("언어와 매체")
                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(8)
            .frame(width: 126, height: 34, alignment: .leading)
            .background(Color(red: 0.99, green: 0.99, blue: 0.99))
            .cornerRadius(8)
        }
        .padding(0)
    }
    var entryDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: entry.date)
    }
}

struct SmallTimeTableWidget: Widget {
    let kind: String = "SmallTimeTableWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, iOS 17.0, *) {
                SmallTimeTableWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SmallTimeTableWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("시간표")
        .description("시간에 따라 해당 교시에 맞는 교시와 과목을 표시해요.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    SmallTimeTableWidget()
} timeline: {
    SimpleEntry(date: .now)
}

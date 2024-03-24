//
//  TimeTable.swift
//  TimeTable
//
//  Created by 김도훈 on 3/21/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), period: ["1","2","3","4","5","6"], subject: ["스포츠 생활","합주","영어 독해와 작문","지구과학Ⅱ","세계시민","화학Ⅱ","자율활동"])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        fetchTimeTableData { timeTableData in
            let entry = SimpleEntry(date: timeTableData.date, period: timeTableData.period, subject: timeTableData.subject)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        fetchTimeTableData { timeTableData in
            let entries = [SimpleEntry(date: timeTableData.date, period: timeTableData.period, subject: timeTableData.subject)]

            let now = Date()
            let calendar = Calendar.current

            let updateTimes = [
                (hour: 0, minute: 0),
                (hour: 9, minute: 20),
                (hour: 10, minute: 20),
                (hour: 11, minute: 20),
                (hour: 12, minute: 20),
                (hour: 14, minute: 0),
                (hour: 15, minute: 0),
            ]

            var nextUpdateTime = Date.distantFuture
            for updateTime in updateTimes {
                var dateComponents = DateComponents()
                dateComponents.hour = updateTime.hour
                dateComponents.minute = updateTime.minute
                
                let potentialNextUpdateTime = calendar.nextDate(after: now, matching: dateComponents, matchingPolicy: .nextTime)!
                if potentialNextUpdateTime < nextUpdateTime {
                    nextUpdateTime = potentialNextUpdateTime
                }
            }

            if nextUpdateTime == .distantFuture {
                var nextDayComponents = DateComponents()
                nextDayComponents.day = 1
                let startOfNextDay = calendar.startOfDay(for: calendar.date(byAdding: nextDayComponents, to: now)!)
                nextUpdateTime = calendar.date(byAdding: .minute, value: 20, to: startOfNextDay)!
            }
            
            let timeline = Timeline(entries: entries, policy: .after(nextUpdateTime))
            completion(timeline)
        }
    }


    func fetchTimeTableData(completion: @escaping (TimeTableData) -> ()) {
        let prefs = UserDefaults(suiteName: "group.studentinfo")
        let api_url = prefs?.string(forKey: "api_url") ?? ""
        let grade = prefs?.integer(forKey: "grade") ?? 1
        let classNumber = prefs?.integer(forKey: "classNumber") ?? 1
        let url = URL(string: "\(api_url)/getTodayTimeTable/\(grade)/\(classNumber)")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(TimeTableData(date: Date(), period: ["", "", "", ""], subject: ["정보를 가져오지 못했어요.", "인터넷 연결 상태에", "문제가 없다면,", "개발자에게 문의해주세요."]))
                return
            }
            
            do {
                let timeTableResponses = try JSONDecoder().decode([TimeTableResponse].self, from: data)
                guard let timeTableResponse = timeTableResponses.first else {
                    completion(TimeTableData(date: Date(), period: ["", "", "", ""], subject: ["정보가 존재하지 않아요.", "오류라고 생각된다면,", "개발자에게 문의해주세요."]))
                    return
                }
                                
                let date = Date()
                let period = timeTableResponse.RESULT_DATA.period
                let subject = timeTableResponse.RESULT_DATA.subject

                completion(TimeTableData(date: date, period: period, subject: subject))
            } catch {
                completion(TimeTableData(date: Date(), period: ["", "", "", ""], subject: ["정보를 가져오지 못했어요.", "인터넷 연결 상태에", "문제가 없다면,", "개발자에게 문의해주세요."]))
            }
        }
        task.resume()
    }
}

struct TimeTableResponse: Codable {
    struct ResultData: Codable {
        let date: String
        let period: [String]
        let subject: [String]
    }
    let RESULT_CODE: Int
    let RESULT_MSG: String
    let RESULT_DATA: ResultData
}

struct TimeTableData {
    let date: Date
    let period: [String]
    let subject: [String]
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let period: [String]
    let subject: [String]
}

struct TimeTableEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if widgetFamily == .systemSmall {
                smallWidgetView
            } else if widgetFamily == .systemMedium {
                mediumWidgetView
            } else if widgetFamily == .systemLarge {
                largeWidgetView
            }
        }
    }
    
    private var smallWidgetView: some View {
        VStack(alignment: .leading) {
            headerView
            Spacer()
            timeTableListView()
        }
        .padding(0)
    }

    private var mediumWidgetView: some View {
        timeTableListView()
    }

    private var largeWidgetView: some View {
        VStack(spacing: 8) {
            headerView
            timeTableListView()
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .top) {
            if widgetFamily == .systemSmall {
                Text(formatDate(entry.date))
                    .font(Font.custom("Noto Sans KR", size: 48).weight(.bold))
                    .multilineTextAlignment(.leading)
                    .frame(width: nil, height: 42.0)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                Spacer()
                Text("\(entry.period[timeIndex()])교시")
                    .font(Font.custom("Noto Sans KR", size: 16).weight(.medium))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                    .opacity(0.50)
            } else {
                Image(colorScheme == .dark ? "today_white" : "today_black")
                Text("오늘의 시간표")
                    .font(Font.custom("Noto Sans KR", size: 14).weight(.bold))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                Spacer()
                Text(formatDate(entry.date))
                    .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                    .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
            }
        }
    }

    private func timeTableListView() -> some View {
        Group {
            if widgetFamily == .systemSmall {
                smallLayout
            } else if widgetFamily == .systemMedium {
                mediumLayout
            } else {
                largeLayout
            }
        }
    }

    private var smallLayout: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("\(entry.subject[timeIndex()])")
                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
        .cornerRadius(8)
    }
    
    private var mediumLayout: some View {
        VStack(spacing: 8) {
            if entry.period.count == 7 {
                HStack(spacing: 8) {
                    ForEach(0..<min(entry.period.count, 3), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(3..<min(entry.period.count, 6), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }

                HStack(spacing: 8)  {
                    Text(entry.period[6])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                        .lineLimit(1)
                    
                    Text(entry.subject[6])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                        .lineLimit(1)
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                .cornerRadius(8)
            } else if entry.period.count == 6 {
                HStack(spacing: 8) {
                    ForEach(0..<min(entry.period.count, 2), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(2..<min(entry.period.count, 4), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(4..<min(entry.period.count, 6), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
            } else if entry.period.count == 5 {
                HStack(spacing: 8) {
                    ForEach(0..<min(entry.period.count, 2), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(2..<min(entry.period.count, 4), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
                
                HStack(spacing: 8)  {
                    Text(entry.period[4])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                        .lineLimit(1)
                    
                    Text(entry.subject[4])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                        .lineLimit(1)
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                .cornerRadius(8)
            } else if entry.period.count == 4 {
                HStack(spacing: 8) {
                    ForEach(0..<min(entry.period.count, 2), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(2..<min(entry.period.count, 4), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
            } else if entry.period.count == 3 {
                VStack(spacing: 8) {
                    ForEach(0..<min(entry.period.count, 2), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
                
                HStack(spacing: 8)  {
                    Text(entry.period[3])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                        .lineLimit(1)
                    
                    Text(entry.subject[3])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                        .lineLimit(1)
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                .cornerRadius(8)
            } else if entry.period.count == 2 {
                VStack(spacing: 8) {
                    ForEach(0..<min(entry.period.count, 2), id: \.self) { index in
                        HStack(spacing: 8)  {
                            Text(entry.period[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                                .lineLimit(1)
                            
                            Text(entry.subject[index])
                                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                                .lineSpacing(22)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineLimit(1)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(8)
                    }
                }
            } else {
                HStack(spacing: 8)  {
                    Text(entry.period[1])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                        .lineLimit(1)
                    
                    Text(entry.subject[1])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                        .lineLimit(1)
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
                .cornerRadius(8)
            }
        }
    }
    
    private var largeLayout: some View {
        ForEach(Array(entry.period.enumerated()), id: \.0) { index, period in
            HStack(spacing: 8)  {
                Text(period)
                    .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
                    .lineLimit(1)
                
                if index < entry.subject.count {
                    Text(entry.subject[index])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
                        .lineLimit(1)
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(colorScheme == .dark ? Color(red: 0.10, green: 0.10, blue: 0.10) : Color(red: 0.99, green: 0.99, blue: 0.99))
            .cornerRadius(8)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        if widgetFamily == .systemSmall {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter.string(from: date)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "M월 d일 E요일"
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter.string(from: date)
        }
    }
    
    func timeIndex() -> Int {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)

        switch (hour, minute) {
        case (0...8, _), (9, 0...20):
            return 0
        case (9, 21...), (10, 0...20):
            return 1
        case (10, 21...), (11, 0...20):
            return 2
        case (11, 21...), (12, 0...20):
            return 3
        case (12, 21...), (13...13, _), (14, 0):
            return 4
        case (14, 1...59), (15, 0):
            return 5
        case (15, 1...), (16...23, _):
            return 6
        default:
            return 6
        }
    }
}

struct TimeTable: Widget {
    let kind: String = "TimeTable"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TimeTableEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TimeTableEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("시간표")
        .description("오늘의 시간표를 표시하는 위젯이에요.")
    }
}

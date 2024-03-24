//
//  Meal.swift
//  Meal
//
//  Created by 김도훈 on 3/19/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), meals: ["곤드레밥 (5.6.13.16.)", "얼큰순두부찌개 (1.5.6.9.10.13.18.)", "달래양념간장 (5.6.13.)", "<자율>오이탕탕이 (9.13.)", "양념파닭 (1.2.4.5.6.12.13.15.)", "총각김치 (9.)", "<음료>달콤전통식혜 (13.)"], calorie: "939.2 kcal")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        fetchMealData { mealData in
            let entry = SimpleEntry(date: mealData.date, meals: mealData.meals, calorie: mealData.calorie)
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        fetchMealData { mealData in
            let entries = [SimpleEntry(date: mealData.date, meals: mealData.meals, calorie: mealData.calorie)]
            
            let calendar = Calendar.current
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
            let nextMidnight = calendar.startOfDay(for: tomorrow)
            
            let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
            completion(timeline)
        }
    }

    func fetchMealData(completion: @escaping (MealData) -> ()) {
        let prefs = UserDefaults(suiteName: "group.studentinfo")
        let api_url = prefs?.string(forKey: "api_url") ?? ""
        let url = URL(string: "\(api_url)/getTodayMeal")!
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(MealData(date: Date(), meals: ["정보를 가져오지 못했어요.", "인터넷 연결 상태에", "문제가 없다면,", "개발자에게 문의해주세요."], calorie: "000.0 kcal"))
                return
            }
            
            do {
                let mealResponses = try JSONDecoder().decode([MealResponse].self, from: data)
                guard let mealResponse = mealResponses.first else {
                    completion(MealData(date: Date(), meals: ["정보가 존재하지 않아요.", "오류라고 생각된다면,", "개발자에게 문의해주세요."], calorie: "000.0 kcal"))
                    return
                }
                                
                let date = Date()
                let meals = mealResponse.RESULT_DATA.dish.joined(separator: "\n").components(separatedBy: "\n")
                let calorie = mealResponse.RESULT_DATA.calorie.joined()

                completion(MealData(date: date, meals: meals, calorie: calorie))
            } catch {
                completion(MealData(date: Date(), meals: ["정보를 가져오지 못했어요.", "인터넷 연결 상태에", "문제가 없다면,", "개발자에게 문의해주세요."], calorie: "000.0 kcal"))
            }
        }
        task.resume()
    }
}

struct MealResponse: Codable {
    struct ResultData: Codable {
        let date: String
        let dish: [String]
        let calorie: [String]
    }
    let RESULT_CODE: Int
    let RESULT_MSG: String
    let RESULT_DATA: ResultData
}

struct MealData {
    let date: Date
    let meals: [String]
    let calorie: String
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let meals: [String]
    let calorie: String
}

struct MealEntryView: View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Group {
            if widgetFamily == .systemMedium {
                mediumWidgetView
            } else if widgetFamily == .systemLarge {
                largeWidgetView
            }
        }
    }

    private var mediumWidgetView: some View {
        VStack(spacing: 8) {
            headerView
            mealListView()
        }
    }

    private var largeWidgetView: some View {
        VStack(spacing: 8) {
            headerView
            VStack(spacing: 16) {
                calorieView
                mealListView()
            }
            Spacer()
        }
    }

    private var headerView: some View {
        HStack {
            Image(colorScheme == .dark ? "restaurant_white" : "restaurant_black")
            Text("오늘의 급식")
                .font(Font.custom("Noto Sans KR", size: 14).weight(.bold))
                .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.07, green: 0.07, blue: 0.07))
            Spacer()
            if widgetFamily == .systemMedium {
                Text("점심 \(entry.calorie)")
                    .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                    .lineSpacing(22)
                    .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
            } else {
                Text(formatDate(entry.date))
                    .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                    .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
            }
        }
    }
    
    private func mealListView() -> some View {
        Group {
            if widgetFamily == .systemMedium {
                mediumLayout
            } else {
                largeLayout
            }
        }
    }
    
    private var mediumLayout: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(0..<min(entry.meals.count, 4), id: \.self) { index in
                    Text(entry.meals[index])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.19, green: 0.19, blue: 0.19))
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 4) {
                ForEach(4..<min(entry.meals.count, 8), id: \.self) { index in
                    Text(entry.meals[index])
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.19, green: 0.19, blue: 0.19))
                        .lineLimit(1)
                }

                if entry.meals.count > 8 {
                    Text("\(entry.meals.count - 8)개 더보기")
                        .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                        .lineSpacing(22)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.19, green: 0.19, blue: 0.19))
                        .opacity(0.50)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var largeLayout: some View {
        VStack(alignment: .leading) {
            ForEach(entry.meals, id: \.self) { meal in
                Text(meal)
                    .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                    .lineSpacing(22)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 0.19, green: 0.19, blue: 0.19))
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var calorieView: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("점심")
                .font(Font.custom("Noto Sans KR", size: 14).weight(.medium))
                .lineSpacing(22)
                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
            Spacer()
            Text("\(entry.calorie)")
                .font(Font.custom("Noto Sans KR", size: 14))
                .foregroundColor(colorScheme == .dark ? Color(red: 0.72, green: 0.72, blue: 0.72) : Color(red: 0.47, green: 0.47, blue: 0.47))
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 E요일"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

struct Meal: Widget {
    let kind: String = "MealWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MealEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MealEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("급식")
        .description("오늘의 급식 메뉴를 표시하는 위젯이에요.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

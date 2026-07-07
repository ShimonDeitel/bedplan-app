import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [BedPlot] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "bedplan_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([BedPlot].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: BedPlot) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: BedPlot) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: BedPlot) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [BedPlot] {
        [
        BedPlot(bedName: "North Bed", season: "Spring", cropList: "Lettuce, Peas, Radish"),
        BedPlot(bedName: "South Bed", season: "Summer", cropList: "Tomato, Basil, Pepper"),
        BedPlot(bedName: "North Bed", season: "Fall", cropList: "Lettuce, Peas, Radish"),
        BedPlot(bedName: "South Bed", season: "Spring", cropList: "Tomato, Basil, Pepper")
        ]
    }
}

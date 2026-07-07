import Foundation

struct BedPlot: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var bedName: String
    var season: String
    var cropList: String

    init(id: UUID = UUID(), bedName: String = "", season: String = "", cropList: String = "") {
        self.id = id
        self.bedName = bedName
        self.season = season
        self.cropList = cropList
    }
}

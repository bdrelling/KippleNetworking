import KippleNetworking
import XCTest

final class ISO8601ExtensionsTests: XCTestCase {
    // MARK: Formatter Extensions
    
    func testISO8601Formatter() {
        let dateString = "2024-02-29T12:34:56Z"
        guard let date = Formatter.iso8601.date(from: dateString) else {
            XCTFail("Failed to parse date from ISO8601 string: \(dateString)")
            return
        }
        let formattedDateString = Formatter.iso8601.string(from: date)
        XCTAssertEqual(formattedDateString, dateString)
    }
    
    func testISO8601FormatterWithFractionalSeconds() {
        let dateString = "2024-02-29T12:34:56.789Z"
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: dateString) else {
            XCTFail("Failed to parse date from ISO8601 string: \(dateString)")
            return
        }
        let formattedDateString = Formatter.iso8601withFractionalSeconds.string(from: date)
        XCTAssertEqual(formattedDateString, dateString)
    }
    
    // MARK: JSONDecoder Extensions
    
    func testSafeISO8601DateDecodingStrategy() {
        let decoder = JSONDecoder.safeISO8601
        let dateString = "2024-02-29T12:34:56.789Z"
        let jsonData = "{\"date\":\"\(dateString)\"}".data(using: .utf8)!
        
        struct Model: Decodable {
            let date: Date
        }
        
        do {
            let model = try decoder.decode(Model.self, from: jsonData)
            let formattedDateString = Formatter.iso8601withFractionalSeconds.string(from: model.date)
            XCTAssertEqual(formattedDateString, dateString)
        } catch {
            XCTFail("Failed to decode date with safe ISO8601 strategy: \(error)")
        }
    }
    
    // MARK: JSONEncoder Extensions
    
    func testSafeISO8601DateEncodingStrategy() {
        let encoder = JSONEncoder.safeISO8601
        let date = Date(timeIntervalSince1970: 1672744496.789)
        
        struct Model: Codable {
            let date: Date
        }
        
        let model = Model(date: date)
        
        do {
            let jsonData = try encoder.encode(model)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            let expectedDateString = Formatter.iso8601withFractionalSeconds.string(from: date)
            XCTAssertTrue(jsonString.contains(expectedDateString), "JSON string should contain the formatted date string: \(expectedDateString)")
        } catch {
            XCTFail("Failed to encode date with safe ISO8601 strategy: \(error)")
        }
    }
}

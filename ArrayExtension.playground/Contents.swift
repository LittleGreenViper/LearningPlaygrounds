import PlaygroundSupport
import UIKit
import MapKit

// This can be messy. It will work, but...ick:
extension Array {
    // ERROR: This will not work
    //    var description: String {
    //        return self.joined(separator: ",")
    //    }
    // Simple CSV line.
    var description1: String {
        if let selfie = self as? [String] { // Filter for a certain type of element.
            return selfie.joined(separator: ",")    // Now, since it's a String, we can join the party.
        }
        
        return "UN-STRING"  // This is not a joiner.
    }
    
    // Creates a CSV string from multiple contained Arrays.
    var description: String {
        if let selfie = self as? [String] { // Simple CSV.
            return selfie.joined(separator: ",")
        } else if let selfie = self as? [[String]] {    // An Array of Arrays of String can be CSVed.
            return selfie.reduce(into: [String]()) { (accumulator: inout [String], element) in  // Pile each line on top of the other.
                let line = element.description  // This asks each line to render as CSV.
                accumulator.append(line)
                }.joined(separator: "\n")   // Join the lines by linefeeds.
        }
        
        return "HUH?"   // Can't CSV.
    }
}

// These are test datasets for the CSV functionality.
let testArray0 = [["One", "Two", "Three"],["Four", "Five", "Six"],["Seven","eight","Nine"]]
let testArray1 = ["One", "Two", "Three"]

let description = testArray0.description1   // Contains "UN-STRING"
let description0 = testArray1.description1  // Contains "One,Two,Three"
let description1 = testArray0.description   // Contains "One,Two,Three\nFour,Five,Six\nSeven,eight,Nine"
let description2 = testArray1.description   // Contains "One,Two,Three"

let csv0 = testArray0.description           // Contains "One,Two,Three\nFour,Five,Six\nSeven,eight,Nine"
let csv1 = testArray0[0].description        // Contains "One,Two,Three"
let csv2 = testArray1.description           // Contains "One,Two,Three"

// Now, with type-constrained extensions, we can get the same functionality with drastically less code.
extension Array where Element == String {
    var csvLine: String {   // Since this is type-constrained, we don't need to take a selfie.
        return self.joined(separator: ",")
    }
}

extension Array where Element == [String] {
    var csv: String {
        return self.reduce(into: [String]()) { (accumulator: inout [String], element) in
            let element2 = element.csvLine
            accumulator.append(element2)
            }.joined(separator: "\n")
    }
}

let csv3 = testArray0.csv               // Contains "One,Two,Three\nFour,Five,Six\nSeven,eight,Nine"
let csv4 = testArray0[0].csvLine        // Contains "One,Two,Three"
let csv5 = testArray1.csvLine           // Contains "One,Two,Three"

// This demonstrates the capability using a protocol. We extend Array for elements of the Equatable protocol.
extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {   // This allows us to remove an object by value.
        if let index = self.firstIndex(of: object) {
            self.remove(at: index)
        }
    }
}

// These tests apply to the above protocol-based extension.
var testArray = [1,2,3,4,5,6,7,8,9,0]
testArray.removeObject(object: 6)
let newArray = testArray    // Contains [1,2,3,4,5,7,8,9,0]

var testArray2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
testArray2.removeObject(object: "6")
let newArray2 = testArray2  // Contains ["1", "2", "3", "4", "5", "7", "8", "9", "0"]

var testArray3 = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
testArray3.removeObject(object: ["4", "5", "6"])
let newArray3 = testArray3  // Contains [["1", "2", "3"], ["7", "8", "9"]]

var testArray4 = [CLLocationCoordinate2D(latitude: 36, longitude: -77), CLLocationCoordinate2D(latitude: 26, longitude: -80), CLLocationCoordinate2D(latitude: -26, longitude: 33)]
// This will not work. CLLocationCoordinate2D is not Equatable
//testArray4.removeObject(object: CLLocationCoordinate2D(latitude: 26, longitude: -80))

extension Array where Element == CLLocationCoordinate2D {
    /* ################################################################## */
    /**
     - returns: An MKMapRect, containing all the points in the Array.
     Nil, if the Array has less than 2 points, or does not contain coordinates.
     */
    var rect: MKMapRect! {
        if 1 < self.count {
            let result = self.reduce(into: (maxLong: -180, maxLat: -180, minLong: 180, minLat: 180)) { (result: inout (maxLong: Double, maxLat: Double, minLong: Double, minLat: Double), inLocationCoords) in
                result.maxLong = Swift.max(inLocationCoords.longitude, result.maxLong)
                result.maxLat = Swift.max(inLocationCoords.latitude, result.maxLat)
                result.minLong = Swift.min(inLocationCoords.longitude, result.minLong)
                result.minLat = Swift.min(inLocationCoords.latitude, result.minLat)
            }
            
            let topLeft = MKMapPoint(CLLocationCoordinate2D(latitude: result.maxLat, longitude: result.minLong))
            let bottomRight = MKMapPoint(CLLocationCoordinate2D(latitude: result.minLat, longitude: result.maxLong))
            let size = MKMapSize(width: abs(bottomRight.x - topLeft.x), height: abs(bottomRight.y - topLeft.y))
            return MKMapRect(origin: topLeft, size: size)
        }
        
        return nil
    }
    
    /* ################################################################## */
    /**
     - returns: The center coordinate of the group of coordinates.
     */
    var center: CLLocationCoordinate2D! {
        let result = self.reduce(into: (maxLong: -180, maxLat: -180, minLong: 180, minLat: 180)) { (result: inout (maxLong: Double, maxLat: Double, minLong: Double, minLat: Double), inLocationCoords) in
            result.maxLong = Swift.max(inLocationCoords.longitude, result.maxLong)
            result.maxLat = Swift.max(inLocationCoords.latitude, result.maxLat)
            result.minLong = Swift.min(inLocationCoords.longitude, result.minLong)
            result.minLat = Swift.min(inLocationCoords.latitude, result.minLat)
        }
        
        return CLLocationCoordinate2D(latitude: (result.maxLat + result.minLat) / 2, longitude: (result.maxLong + result.minLong) / 2)
    }
    
    /* ################################################################## */
    /**
     - returns: A coordinate span, encompassing all of the coordinates in the Array.
     Nil, if the span cannot be calculated for any reason.
     */
    var span: MKCoordinateSpan! {
        if 1 < self.count {
            let result = self.reduce(into: (maxLong: -180, maxLat: -180, minLong: 180, minLat: 180)) { (result: inout (maxLong: Double, maxLat: Double, minLong: Double, minLat: Double), inLocationCoords) in
                result.maxLong = Swift.max(inLocationCoords.longitude, result.maxLong)
                result.maxLat = Swift.max(inLocationCoords.latitude, result.maxLat)
                result.minLong = Swift.min(inLocationCoords.longitude, result.minLong)
                result.minLat = Swift.min(inLocationCoords.latitude, result.minLat)
            }
            
            return MKCoordinateSpan(latitudeDelta: result.maxLat - result.minLat, longitudeDelta: result.maxLong - result.minLong)
        }
        
        return nil
    }
    
    /* ################################################################## */
    /**
     - returns: A region, encompassing all of the elements in the Array.
     Nil, if the region cannot be calculated for any reason.
     */
    var region: MKCoordinateRegion! {
        if let center = self.center, let span = self.span {
            return MKCoordinateRegion(center: center, span: span)
        }
        
        return nil
    }
    
}

extension CLLocationCoordinate2D {
    init(_ inLocationArray: [CLLocationCoordinate2D]) {
        self.init(latitude: inLocationArray.center.latitude, longitude: inLocationArray.center.longitude)
    }
}

// Example dataset:

let washingtonMonument = CLLocationCoordinate2D(latitude: 38.9072, longitude: -77.0369)
let whiteHouse = CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365)
let capitolBuilding = CLLocationCoordinate2D(latitude: 38.8899, longitude: -77.0091)
let lincolnMemorial = CLLocationCoordinate2D(latitude: 38.8893, longitude: -77.0502)
let jeffersonMemorial = CLLocationCoordinate2D(latitude: 38.8814, longitude: -77.0365)
let airAndSpaceMuseum = CLLocationCoordinate2D(latitude: 38.8882, longitude: -77.0199)
let ronaldReaganAirport = CLLocationCoordinate2D(latitude: 38.8512, longitude: -77.0402)
let pentagon = CLLocationCoordinate2D(latitude: 38.8719, longitude: -77.0563)
let arlingtonCemetery = CLLocationCoordinate2D(latitude: 38.8783, longitude: -77.0687)
let airAndSpaceMuseumAnnex = CLLocationCoordinate2D(latitude: 38.9109, longitude: -77.4442)

let arrayOfCoordinates = [washingtonMonument,
                          whiteHouse,
                          capitolBuilding,
                          lincolnMemorial,
                          jeffersonMemorial,
                          airAndSpaceMuseum,
                          ronaldReaganAirport,
                          pentagon,
                          arlingtonCemetery,
                          airAndSpaceMuseumAnnex
]

let rectThatWillEncloseAllLocations = arrayOfCoordinates.rect   // Remember that this is in map points (not coordinates), so the numbers will be big:
// left: 76471147.05123556
// top: 102675876.5094804
// width: 324434.0747377872
// height: 57184.79726368189

let greatLocationForAHotel = arrayOfCoordinates.center          // This will contain (38.88105, -77.22665000000001), which is a mean of all the data points in the Array.

let aSpanThatIsBigEnoughForEverything = arrayOfCoordinates.span // This contains (0.05969999999999942, 0.4350999999999914), which is in long/lat coordinates.

let aRegionThatFitsEverything = arrayOfCoordinates.region       // This is a region, made up of the center and span. It will enclose all the points.

let anotherGreatLocationForAHotel = CLLocationCoordinate2D(arrayOfCoordinates)  // In this trick, we simply assign the center (38.88105, -77.22665000000001) to the property.

// This should display the map, centered, with markers for each location.
class MapViewController: UIViewController {
    var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView = MKMapView()
        self.view.addSubview(self.mapView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mapView.frame = self.view.bounds
        self.mapView.mapType = .standard
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        arrayOfCoordinates.forEach { [unowned self] coordinate in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.mapView.addAnnotation(annotation)
        }
        
        self.mapView.setRegion(self.mapView.regionThatFits(arrayOfCoordinates.region), animated: true)
    }
}

let controller = MapViewController()

PlaygroundPage.current.liveView = controller
PlaygroundPage.current.needsIndefiniteExecution = true

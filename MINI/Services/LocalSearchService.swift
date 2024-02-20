//
//  LocalSearchService.swift
//  MINI
//
//  Created by Yanis on 06.12.2023.
//

import MapKit

// MARK: - Input protocol

public struct LocalSearchResult {
    var title: String
    var subtitle: String
}

public protocol LocalSearchService: AnyObject {
    var output: LocalSearchOutput? { get set }
    
    func searchLocations(localRegion: MKCoordinateRegion, query: String)
    func getLocalPlace(from location: LocalSearchResult, completion: @escaping MKLocalSearch.CompletionHandler)
}

// MARK: - Output protocol

public protocol LocalSearchOutput: AnyObject {
    func didUpdateResults(_ results: [LocalSearchResult])
    func didFailWithError(_ error: Error)
}


final public class LocalSearchServiceImpl: NSObject, LocalSearchService {
    weak public var output: LocalSearchOutput?
    
    private var completer: MKLocalSearchCompleter?
    
    override public init() {
        super.init()
        completer = MKLocalSearchCompleter()
        completer?.delegate = self
    }
    
    /// Search for locations
    public func searchLocations(localRegion: MKCoordinateRegion, query: String) {
        completer?.region = localRegion
        completer?.queryFragment = query
    }
    
    /// Search 
    public func getLocalPlace(
        from location: LocalSearchResult,
        completion: @escaping MKLocalSearch.CompletionHandler
    ) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = location.title.appending(location.subtitle)
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completion)
    }
}

// MARK: - MKLocalSearchCompleterDelegate

public extension LocalSearchServiceImpl: MKLocalSearchCompleterDelegate {
    
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.map { result in
            return LocalSearchResult(
                title: result.title,
                subtitle: result.subtitle
            )
        }
        output?.didUpdateResults(results)
    }
    
    public func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        output?.didFailWithError(error)
    }
    
}


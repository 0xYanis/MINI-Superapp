//
//  LocalSearchService.swift
//  MINI
//
//  Created by Yanis on 06.12.2023.
//

import MapKit

// MARK: - Input protocol

struct LocalSearchResult {
    var title: String
    var subtitle: String
}

protocol LocalSearchService: AnyObject {
    var output: LocalSearchOutput? { get set }
    
    func searchLocations(localRegion: MKCoordinateRegion, query: String)
    func getLocalPlace(from location: LocalSearchResult, completion: @escaping MKLocalSearch.CompletionHandler)
}

// MARK: - Output protocol

protocol LocalSearchOutput: AnyObject {
    func didUpdateResults(_ results: [LocalSearchResult])
    func didFailWithError(_ error: Error)
}


final class LocalSearchServiceImpl: NSObject, LocalSearchService {
    
    weak var output: LocalSearchOutput?
    
    private var completer: MKLocalSearchCompleter?
    
    override init() {
        super.init()
        completer = MKLocalSearchCompleter()
        completer?.delegate = self
    }
    
    /// Search for locations
    func searchLocations(localRegion: MKCoordinateRegion, query: String) {
        completer?.region = localRegion
        completer?.queryFragment = query
    }
    
    /// Search 
    func getLocalPlace(
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

extension LocalSearchServiceImpl: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.map { result in
            return LocalSearchResult(
                title: result.title,
                subtitle: result.subtitle
            )
        }
        output?.didUpdateResults(results)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        output?.didFailWithError(error)
    }
    
}


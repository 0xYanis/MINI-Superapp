//
//  LocalSearchService.swift
//  MINI
//
//  Created by Yanis on 06.12.2023.
//

import MapKit

// MARK: - Input protocol

protocol LocalSearchService: AnyObject {
    func queryFragment(query: String)
}

// MARK: - Output protocol

protocol LocalSearchOutput: AnyObject {
    func didUpdateResults(_ results: [MKLocalSearchCompletion])
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
    
    public func queryFragment(query: String) {
        completer?.queryFragment = query
    }
    
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocalSearchServiceImpl: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        output?.didUpdateResults(completer.results)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        output?.didFailWithError(error)
    }
    
}


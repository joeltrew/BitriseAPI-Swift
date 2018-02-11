//
//  BitriseService.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

public class BitriseService {
    
    var userToken: String
    
    var apiConfig: APIConfig = APIConfig(baseUrl: "api.bitrise.io", version: "v0.1")
    
    var networkClient: NetworkClient
    
    public init(userToken: String) {
        self.userToken = userToken
        self.networkClient = NetworkClient(token: userToken)
    }
    
    /// Performs a network request with a given request object, and returns a result containing the requested data or an error
    ///
    /// - Parameters:
    ///   - request: A request object conforming to APIRequest containing all the data needed to perform a request
    ///   - completion: A completion closure to call when the network request completes, the closure is returned with a 'result' object which contains either the requested data decoded or an error
    private func perform<T: APIRequest>(request: T, completion: @escaping ResultCompletion<T.ResponseType>) {
        
        networkClient.send(request) { (result) in
            
            // Unwrap the value and return that in a result
            let mappedResult = result.map({ (container) -> T.ResponseType in
                return container.value
            })
            
            completion(mappedResult)
        }
    }
    
    /// Performs a network request with a given paged request object, and returns a result containing the requested paged data or an error
    /// This method works the same as perform:completion: however allows for additional pagination metadata to be included, the result will be wrapped in a PagedData object which contains the next set of data
    ///
    /// - Parameters:
    ///   - request: A request object conforming to PagedAPIRequest containing all the data needed to perform a request, including a limit and next paramaters for pagination
    ///   - pagination: A pagination data object for providing the request with
    ///   - completion: A completion closure to call when the network request completes, the closure is returned with a 'result' object which contains either the requested data wrapped in a PagedData object or an error
    private func perform<T: PagedAPIRequest>(request: T, pagination: Pagination?, completion: @escaping ResultCompletion<PagedData<T.ResponseType>>) {
        
        // Make a copy of the request so we can mutate
        var _request = request
        
        // Set the limit and next proeprty if they exist
        if let nextPage = pagination {
            _request.limit = nextPage.pageItemLimit
            _request.next = nextPage.next
        }
        
        // Send the request
        networkClient.send(_request) { (result) in
            
            // Convert the response into a PagedData object containing the paging metadata
            let mappedResult = result.map({ (container) -> PagedData<T.ResponseType> in
                return PagedData(data: container.value, pagination: container.pagination)
            })
            
            completion(mappedResult)
        }
    }
    
    // MARK: - Get user methods
    public func getUser(completion: @escaping ResultCompletion<User>) {
        
        let request = GetUserRequest(baseUrl: apiConfig.url)
    
        self.perform(request: request, completion: completion)
    }
    
    // MARK: - Get app methods
    public func getApps(nextPage: Pagination? = nil, completion: @escaping ResultCompletion<PagedData<[App]>>) {
        
        let request = GetAppsRequest(baseUrl: apiConfig.url)
        
        self.perform(request: request, pagination: nextPage, completion: completion)
    }
    
    
    public func getAppBySlug(_ slug: String, completion: @escaping ResultCompletion<App>) {
        
        let request = GetAppBySlugRequest(baseUrl: apiConfig.url, slug: slug)
        
        self.perform(request: request, completion: completion)
    }
    
    // MARK: - Get build methods
}

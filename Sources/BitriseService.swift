//
//  BitriseService.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

/// Provides access to all of the endpoints in the bitrise system
/// You will need to configure this object with a valid API key
public class BitriseService {
    
    public typealias PagedDataResultCompletion<T: Decodable> = ResultCompletion<PagedData<[T]>>
    
    // Configuration object used to define the properties of the bitrise API
    var apiConfig: APIConfig = APIConfig(baseUrl: "api.bitrise.io", version: "v0.1")
    
    // Client used to perform network requests
    var networkClient: NetworkClient
    
    public init(userToken: String) {
        self.networkClient = NetworkClient(token: userToken)
    }
    
    /// Performs a network request with a given request object, and returns a result containing the requested data or an error
    ///
    /// - Parameters:
    ///   - request: A request object conforming to APIRequest containing all the data needed to perform a request
    ///   - completion: A completion closure to call when the network request completes, the closure is returned with a 'result' object which contains either the requested data decoded or an error
    private func perform<T: APIRequest>(request: T, completion: @escaping ResultCompletion<T.ResponseType>) {
        
        networkClient.send(request) { (result: Result<DataContainer<T.ResponseType>>) in
            
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
        networkClient.send(_request) { (result: Result<DataContainer<T.ResponseType>>) in
            
            // Convert the response into a PagedData object containing the paging metadata
            let mappedResult = result.map({ (container) -> PagedData<T.ResponseType> in
                return PagedData(data: container.value, pagination: container.pagination)
            })
            
            completion(mappedResult)
        }
    }
    
    // MARK: - Get user methods
    // Gets the current user, this will be the account which created the API token
    public func getUser(completion: @escaping ResultCompletion<User>) {
        
        let request = GetUserRequest(baseUrl: apiConfig.url)
    
        self.perform(request: request, completion: completion)
    }
    
    // MARK: - Get app methods
    
    /// Gets all the apps for the current user
    ///
    /// - Parameters:
    ///   - pagination: An optional pagination object which defines which page and the number of item to appear on each page
    ///   - completion: A completion handler which returns an array of apps along with pagination data
    public func getApps(pagination: Pagination? = nil, completion: @escaping PagedDataResultCompletion<App>) {
        
        let request = GetAppsRequest(baseUrl: apiConfig.url)
        
        self.perform(request: request, pagination: pagination, completion: completion)
    }
    
    
    /// Gets a single app by its specific slug(identifier)
    ///
    /// - Parameters:
    ///   - slug: A unique identifier to a specific app
    ///   - completion: A completion handler which returns a single app
    public func getAppBySlug(_ slug: String, completion: @escaping ResultCompletion<App>) {
        
        let request = GetAppBySlugRequest(baseUrl: apiConfig.url, slug: slug)
        
        self.perform(request: request, completion: completion)
    }
    
    // MARK: - Get build methods
    
    /// Gets all the builds for a given app, builds will be paginated if there are too many
    ///
    /// - Parameters:
    ///   - app: The app the build belong to
    ///   - pagination: An optional pagination object which defines which page and the number of item to appear on each page
    ///   - filterQuery: An optional filterquery object which allows finer control over the builds which are returned
    ///   - completion: A completion handler which returns an array of builds along with pagination data
    public func getBuildsForApp(_ app: App,
                                pagination: Pagination? = nil,
                                filterQuery: BuildFilterQuery? = nil,
                                completion: @escaping PagedDataResultCompletion<Build>) {
        
        let request = GetBuildsByAppSlugRequest(baseUrl: apiConfig.url, appSlug: app.slug, filterQuery: filterQuery)
        
        self.perform(request: request, pagination: pagination, completion: completion)
    }
    
    /// Gets a single app by its specific slug(identifier)
    ///
    /// - Parameters:
    ///   - buildSlug: A unique identifier to a specific build
    ///   - app: The app which the builds belong to
    ///   - completion: A completion handler which returns a single build
    public func getBuildBySlug(_ buildSlug: String, in app: App, completion: @escaping ResultCompletion<Build>) {
        
        let request = GetBuildBySlugRequest(baseUrl: apiConfig.url, appSlug: app.slug, buildSlug: buildSlug)
        
        self.perform(request: request, completion: completion)
    }
    
    /// Aborts a build if it is currently running
    ///
    /// - Parameters:
    ///   - options: A object which allows you define extra data when aborting a build such as a reason
    ///   - buildSlug: The unique slug/identifier of a build
    ///   - app: The app which the build belongs to
    ///   - completion: A compeltion handler containing the response of the abort request
    public func abortBuild(with options: AbortBuildOptions? = nil, buildSlug: String, app: App, completion: @escaping ResultCompletion<AbortRequestResponse>) {
        
        var request = AbortBuildRequest(baseUrl: apiConfig.url, appSlug: app.slug, buildSlug: buildSlug, body: nil)
        if let options = options {
            request.setBody(with: options)
        }
        // Send the request
        networkClient.send(request) { (result: Result<AbortRequestResponse>) in
            completion(result)
        }
    }
    
    // A convience method which allows you to abort a build and easily provide a reason
    public func abortBuild(with reason: String, buildSlug: String, app: App, completion: @escaping ResultCompletion<AbortRequestResponse>) {
        
        let options = AbortBuildOptions(reason: reason)
        
        self.abortBuild(with: options, buildSlug: buildSlug, app: app, completion: completion)
    }
    
    // MARK: - Get artifacts methods
    
    /// Gets all artifacts for a specific build
    ///
    /// - Parameters:
    ///   - buildSlug: The slug/identifier of the build the artifact was created from
    ///   - app: The app that the artifact was created for
    ///   - pagination: An optional pagination object which defines which page and the number of items to appear on each page
    ///   - completion: A completion handler which returns an array of build artifacts along with pagination data
    public func getArtifactsForBuild(_ buildSlug: String, app: App, pagination: Pagination?, completion: @escaping PagedDataResultCompletion<Artifact>) {
        
        let request = GetArtifactsByBuildSlugRequest(baseUrl: apiConfig.url, appSlug: app.slug, buildSlug: buildSlug)
        
        self.perform(request: request, pagination: pagination, completion: completion)
    }
    
    /// Gets a specific artifact by its slug/identifier
    ///
    /// - Parameters:
    ///   - artifactSlug: The slug/identifier of the artifact
    ///   - buildSlug: The slug/identifier of the build the artifact was created from
    ///   - appSlug: The app that the artifact was created for
    ///   - completion: A completion handler which returns the requested artifact
    public func getArtifactBySlug(_ artifactSlug: String, buildSlug: String, appSlug: String, completion: @escaping ResultCompletion<Artifact>) {
        
        let request = GetArtifactBySlug(baseUrl: apiConfig.url, appSlug: appSlug, buildSlug: buildSlug, artifactSlug: artifactSlug)
        
        self.perform(request: request, completion: completion)
    }
}

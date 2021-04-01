//
//  Service.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation
import Apollo

class Service {
    static let shared = Service()
    
    private(set) lazy var apollo: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        let url = URL(string: "https://api.github.com/graphql")!
        let requestChainTransport = RequestChainNetworkTransport(
            interceptorProvider: NetworkInterceptorProvider(store: store),
            endpointURL: url)
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
}

private class RequestInterceptor: ApolloInterceptor {
    func interceptAsync<Operation>(chain: RequestChain,
                                   request: HTTPRequest<Operation>,
                                   response: HTTPResponse<Operation>?,
                                   completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
        request.addHeader(name: "Authorization", value: "Bearer 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")
        chain.proceedAsync(request: request, response: response, completion: completion)
    }
}

private class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(RequestInterceptor(), at: 0)
        return interceptors
    }
}

class CoordinatorsFactory: CoordinatorsFactoryProtocol {
    
    func makeSearchCoordinator(with router: Routable) -> Coordinatable {
        SearchCoordinator(router: router, factory: SearchFlowFactory())
    }
}

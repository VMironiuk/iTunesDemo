final class SearchFlowFactory: SearchFlowFactoryProtocol {
    
    func makeSearchView() -> Presentable {
        SearchViewController.instantiateFromStoryboard(R.storyboard.main())
    }
}
final class SearchFlowFactory: SearchFlowFactoryProtocol {
    
    func makeSearchView() -> Presentable {
        SearchViewController.instantiateFromStoryboard(R.storyboard.main())
    }
    
    func makeTrackDetailsView() -> Presentable {
        DetailsViewController.instantiateFromStoryboard(R.storyboard.main())
    }
}

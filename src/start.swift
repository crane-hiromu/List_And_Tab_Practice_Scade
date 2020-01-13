import ScadeKit

class List_And_Tab_Practice_Scade: SCDApplication {
	
	// MARK: Properties

	private let window = SCDLatticeWindow()
	
	private lazy var mainAdapter: MainPageAdapter = {
		let adapter = MainPageAdapter()
		adapter.load(MainPageAdapter.pageName)
		return adapter
	}()
	
	override func onFinishLaunching() {	
		mainAdapter.show(window)
	}
}

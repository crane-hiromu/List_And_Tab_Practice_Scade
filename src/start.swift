import ScadeKit

class List_And_Tab_Practice_Scade: SCDApplication {
	
	// MARK: Properties

	private let window = SCDLatticeWindow()
	
	private lazy var mainAdapter: MainPageAdapter = {
		let adapter = MainPageAdapter()
		debugPrint("---before load---")
		adapter.load(MainPageAdapter.pageName)
		debugPrint("---after load---")
		return adapter
	}()
	
	// MARK: Overrides
		
	override func onFinishLaunching() {	
		super.onFinishLaunching()
		debugPrint("---\(#function)---")
		mainAdapter.show(window)
	}
	
	override func launch() {
		super.launch()
		debugPrint("---\(#function)---")
	}
	
	override func onEnterBackground() {
		super.onEnterBackground()
		debugPrint("---\(#function)---")
	}
	override func onEnterForeground() {
		super.onEnterForeground()
		debugPrint("---\(#function)---")
	}
	
	override func onOpen(with url: String) {
		super.onOpen(with: url)
		debugPrint("---\(#function)---")
	}
}


import ScadeKit

class List_And_Tab_Practice_Scade: SCDApplication {
	
	// MARK: Properties

	private let window = SCDLatticeWindow()
	
	private lazy var mainAdapter: MainPageAdapter = {
		let adapter = MainPageAdapter()
		debugPrint("---before load---", MainPageAdapter.pageName, ChildPageAdapter.pageName)
		adapter.load(MainPageAdapter.pageName)
		debugPrint("---after load---")
		return adapter
	}()
	
//	private lazy var childAdapter: ChildPageAdapter = {
//		let adapter = ChildPageAdapter()
//		debugPrint("---before load---")
////		adapter.load(ChildPageAdapter.pageName)
//		debugPrint("---after load---")
//		return adapter
//	}()
//	
	// MARK: Overrides
		
	override func onFinishLaunching() {	
		super.onFinishLaunching()
		debugPrint("---\(#function)---")

		mainAdapter.show(window)
		
//		childAdapter.load(ChildPageAdapter.pageName)
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


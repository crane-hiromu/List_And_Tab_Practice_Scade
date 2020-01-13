import ScadeKit

// MARK: - Adapter

final class MainPageAdapter: SCDLatticePageAdapter {

	// MARK: Properties
	
	#if(os(iOS))
	private lazy var statusVar: SCDLayoutGridData? = {
		let widget = self.page?.getWidgetByName("viewareaStatusbar")
		let container = widget as? SCDWidgetsContainer
		let grid = widget?.layoutData as? SCDLayoutGridData
		return grid
	}()
	#endif
	
	
	// MARK: Overrides
	
	override func load(_ path: String) {		
		super.load(path)
		
		#if(os(iOS))
		statusVar?.isExclude.toggle()
		#endif
		
		
	}
}
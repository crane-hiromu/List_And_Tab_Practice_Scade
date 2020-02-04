import ScadeKit

class ChildPageAdapter: SCDLatticePageAdapter {

	// page adapter initialization
	override func load(_ path: String) {		
		super.load(path)
		
		debugPrint("---\(#function)---")
		
		let button = self.page?.getWidgetByName("backButton") as? SCDWidgetsClickable
		button?.onClick.append(SCDWidgetsEventHandler{ [weak self] _ in 
			self?.navigation?.go("main.page")
		})
	}
	
	override func show(_ view: SCDLatticeView?) {
		super.show(view)
		
		debugPrint("---\(#function)---")
	}
}

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
	
	private lazy var listControl: SCDWidgetsList? = {
	   let widget = self.page?.getWidgetByName("mainList")
	   let list = widget as? SCDWidgetsList
//	   list?.items = ["hoge", "huga", "fizz", "buzz"]
//	   list?.elements
//	   list?.template.element.children
	   return list
	}()
	
//	private lazy var row: SCDWidgetsRowView? = {
//	   let widget = self.page?.getWidgetByName("mainListRow")
//	   let row = widget as? SCDWidgetsRowView
//	   return row
//	}()

	private var viewModel: MainPageViewModel?
	
	// MARK: Overrides
	
	override func load(_ path: String) {		
		super.load(path)
		
		#if(os(iOS))
		statusVar?.isExclude.toggle()
		#endif
	}
	
	override func show(_ view: SCDLatticeView?) {
		super.show(view)
	
		listControl?.items = ["hoge", "huga", "fizz", "buzz", "hoge", "huga", "fizz", "buzz", "hoge", "huga", "fizz", "buzz"]
		listControl?.elements.enumerated().forEach { i, row in
			let label = ((row.children.first as? SCDWidgetsListView)?.children.first as? SCDWidgetsRowView)?.children.first
			(label as? SCDWidgetsLabel)?.text = listControl?.items[i] as? String ?? ""
			
//			print("---element0", (($0.children[0] as? SCDWidgetsListView)?.children[0] as? SCDWidgetsRowView)?.children)
//			print("---element1", (($0.children[0] as? SCDWidgetsListView)?.children[1] as? SCDWidgetsRowView)?.children)
		}
	}
}

final class MainPageViewModel: EObject {
	let txt: String
	
	init(txt: String) {
		self.txt = txt
	}
	
	convenience init(txt2: String) {
		self.init(txt: txt2)
	}
}
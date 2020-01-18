import ScadeKit

// MARK: - Adapter

final class MainPageAdapter: SCDLatticePageAdapter {

	// MARK: Properties
	
	#if(os(iOS))
	private lazy var statusVar: SCDLayoutGridData! = {
		let widget = self.page?.getWidgetByName("viewareaStatusbar")
		let container = widget as? SCDWidgetsContainer
		let grid = widget?.layoutData as? SCDLayoutGridData
		return grid
	}()
	#endif
	
	private lazy var listControl: SCDWidgetsList! = {
	   let widget = self.page?.getWidgetByName("mainList")
	   let list = widget as? SCDWidgetsList
//	   list?.items = ["hoge", "huga", "fizz", "buzz"]
//	   list?.elements
//	   list?.template.element.children
	   return list
	}()
	
	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
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
		
		// todo
		#if(os(iOS))
		statusVar.isExclude.toggle()
		#endif
	}
	
	override func show(_ view: SCDLatticeView?) {
		super.show(view)
		
    let url = URL(string: "https://api.droidkaigi.jp/2020/speakers/")!
    let session = URLSession.shared
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    let task = session.dataTask(with:request,completionHandler: { [weak self] data, response, error in
    	guard let self = self else { return }
      print(data, response, error.debugDescription, error?.localizedDescription)
      
      if let d = data, let result = try? self.decoder.decode([Speaker].self, from: d) {
          print("----result", result)
        DispatchQueue.main.sync {
        	  
          self.listControl.items = result.map { $0.fullName }
          self.listControl.elements.enumerated().forEach { i, row in
    	 			let label = row.children.first?.asList?.children.first?.asRow?.children.first?.asLabel 
    	  		label?.text = self.listControl.items[i] as? String ?? ""
        	}
        }
      }
    })
    task.resume()
//		
//	
//		listControl.items = ["hoge", "huga", "fizz", "buzz", "hoge", "huga", "fizz", "buzz", "hoge", "huga", "fizz", "buzz"]
//		listControl.elements.enumerated().forEach { i, row in
//			let label = row.children.first?.asList?.children.first?.asRow?.children.first?.asLabel
//			label?.text = listControl.items[i] as? String ?? ""
//			
//			
////			print("---element0", (($0.children[0] as? SCDWidgetsListView)?.children[0] as? SCDWidgetsRowView)?.children)
////			print("---element1", (($0.children[0] as? SCDWidgetsListView)?.children[1] as? SCDWidgetsRowView)?.children)
//		}
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

struct Speaker: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let bio: String
    let tagLine: String
    let profilePicture: String?
    let isTopSpeaker: Bool
    let sessions: [String]
    let fullName: String
}

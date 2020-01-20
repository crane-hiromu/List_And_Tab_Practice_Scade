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
	   return list
	}()
	
	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()
	
	// MARK: Overrides
	
	override init() {
		super.init()
		debugPrint("---\(#function)---")
	}
	
	override func load(_ path: String) {		
		super.load(path)
		debugPrint("---\(#function)---")
	
		// todo
		#if(os(iOS))
		statusVar.isExclude.toggle()
		debugPrint("---iOS---")
		#endif
	}
	
	override func activate(_ view: SCDLatticeView?) {
		super.activate(view)
		
		debugPrint("---\(#function)---")
		debugPrint("---\(view?.page),\(view?.onSizeChanged),\(view?.adapter),\(view?.navigation)---")
	}
	
	override func show(_ view: SCDLatticeView?, data: Any?) {
		super.show(view, data: data)
		
		debugPrint("---\(#function)---")
		debugPrint("---\(view?.page),\(view?.onSizeChanged),\(view?.adapter),\(view?.navigation)---")
	}
	
	override func show(_ view: SCDLatticeView?) {
		super.show(view)
		
		debugPrint("---\(#function)---")
		debugPrint("---\(view?.page),\(view?.onSizeChanged),\(view?.adapter),\(view?.navigation)---")
		
    let url = URL(string: "https://api.droidkaigi.jp/2020/speakers/")!
    let session = URLSession.shared
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    /// 描画が遅いためAPIを叩いてるんかと思ったが、描画が遅いだけであった
    guard SpeakerManager.shared.names.isEmpty else { 
			updateList()
			print("---exec cache---")
			return 
		}
    
    let task = session.dataTask(with:request,completionHandler: { [weak self] data, response, error in
    	guard let self = self else { return }

      if let d = data, let result = try? self.decoder.decode([Speaker].self, from: d) {
        SpeakerManager.shared.names = result.map { $0.fullName }
				self.updateList()
      }
    })
    task.resume()
	}
	
	func updateList() {
		DispatchQueue.main.sync {        	  
			self.listControl.items = SpeakerManager.shared.names
			self.listControl.elements.enumerated().forEach { i, row in
				let label = row.children.first?.asList?.children.first?.asRow?.children.first?.asLabel 
				label?.text = self.listControl.items[i] as? String ?? ""
			}
		}
	}
	
	deinit {
		debugPrint("---\(#function)---")
	}
}

final class SpeakerManager {
	
	static let shared = SpeakerManager()
	private init() {}
	
	var names: [String] = []
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

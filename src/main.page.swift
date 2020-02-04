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
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
        	self?.onItemSelected(with: event)
        })
        return list
    }()
    
    private lazy var childAdapter: ChildPageAdapter = {
		let adapter = ChildPageAdapter()
		debugPrint("---before load---")
//		adapter.load(ChildPageAdapter.pageName)
		debugPrint("---after load---")
		return adapter
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
        
        childAdapter.load(ChildPageAdapter.pageName)
        
        self.page?.onEnter.append(SCDWidgetsEnterEventHandler { [weak self] ev in
        	debugPrint("---onEnter---", ev)
        })
        
        self.page?.onExit.append(SCDWidgetsExitEventHandler { [weak self] ev in
        	debugPrint("---onExit---", ev)
        })
    }
    
    override func activate(_ view: SCDLatticeView?) {
        super.activate(view)
        
        debugPrint("---\(#function)---", view)
    }
    
    override func show(_ view: SCDLatticeView?, data: Any?) {
        super.show(view, data: data)
        
        debugPrint("---\(#function)---", view, data)
    }
    
    override func show(_ view: SCDLatticeView?) {
        super.show(view)
        
        debugPrint("---\(#function)---")
        
        let url = URL(string: "https://api.droidkaigi.jp/2020/speakers/")!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with:request,completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
        
            debugPrint("---session---")
            
            if let d = data, let result = try? self.decoder.decode([Speaker].self, from: d) {
                self.updateList(names: result.map { $0.fullName })
            }
        })
        task.resume()
    }
    
    func updateList(names: [String]) {
        self.listControl.items = names
        
        self.listControl.elements.enumerated().forEach { i, row in
            let label = row.children.first?.asList?.children.first?.asRow?.children.first?.asLabel
            DispatchQueue.main.sync {
                label?.text = self.listControl.items[i] as? String ?? ""
            }
        }
    }
    
    func onItemSelected(with event: SCDWidgetsItemEvent?) {
    	debugPrint("----onItemSelected", event?.item)
    	
    	self.navigation?.push(page: ChildPageAdapter.pageName, transition: .forward)
    }
    
    deinit {
        debugPrint("---\(#function)---")
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

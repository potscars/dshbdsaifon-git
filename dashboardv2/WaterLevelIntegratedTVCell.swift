//
//  WaterLevelIntegratedTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import WebKit

class WaterLevelIntegratedTVCell: UITableViewCell, WKNavigationDelegate {
    
    //RiverInfo
    @IBOutlet weak var uilWLITVCRiverName: UILabel!
    @IBOutlet weak var uilWLITVCRiverReportDate: UILabel!
    @IBOutlet weak var uilWLITVCRiverCurrLevel: UILabel!
    @IBOutlet weak var uilWLITVCRiverLevelDiff: UILabel!
    @IBOutlet weak var uilWLITVCRiverPrevLevel: UILabel!
    @IBOutlet weak var uivWLITVCRiverDangerIndicator: UIView!
    @IBOutlet weak var uivWLITVCRiverWarningIndicator: UIView!
    @IBOutlet weak var uivWLITVCRiverCautionIndicator: UIView!
    @IBOutlet weak var uivWLITVCRiverSafeIndicator: UIView!

    @IBOutlet weak var uilWLITVCLoadingText: UILabel!
    @IBOutlet weak var uiaivWLITVCLoadingIndicator: UIActivityIndicatorView!
    
    //Graph
    @IBOutlet weak var uivWLITVCGraphView: UIView!
    @IBOutlet weak var uivWLITVCLoadingView: UIView!
    var graphWebView: WKWebView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateRiverLevelCell(data: NSDictionary) {
        
        uilWLITVCRiverName.text = data.value(forKey: "RIVER_NAME") as? String ?? "Tiada maklumat"
        uilWLITVCRiverReportDate.text = data.value(forKey: "RIVER_REPORT_DATE") as? String ?? "Tiada tarikh"
        uilWLITVCRiverCurrLevel.text = data.value(forKey: "RIVER_CURR_LEVEL") as? String ?? "N/A"
        uilWLITVCRiverLevelDiff.text = data.value(forKey: "RIVER_LEVEL_DIFF") as? String ?? "N/A"
        uilWLITVCRiverPrevLevel.text = data.value(forKey: "RIVER_PREV_LEVEL") as? String ?? "N/A"
        let riverStatus: NSArray = data.value(forKey: "RIVER_STATUS") as! NSArray
        
        indicatorSet(indicatorNumber: DBWaterLevel.detectIndicatorNumber(status: riverStatus.object(at: 0) as! String))
        
    }
    
    func indicatorSet(indicatorNumber: Int)
    {
        uivWLITVCRiverSafeIndicator.layer.borderColor = UIColor.gray.cgColor
        uivWLITVCRiverSafeIndicator.layer.borderWidth = 1
        uivWLITVCRiverCautionIndicator.layer.borderColor = UIColor.gray.cgColor
        uivWLITVCRiverCautionIndicator.layer.borderWidth = 1
        uivWLITVCRiverWarningIndicator.layer.borderColor = UIColor.gray.cgColor
        uivWLITVCRiverWarningIndicator.layer.borderWidth = 1
        uivWLITVCRiverDangerIndicator.layer.borderColor = UIColor.gray.cgColor
        uivWLITVCRiverDangerIndicator.layer.borderWidth = 1
        
        if(indicatorNumber == 0)
        {
            uivWLITVCRiverSafeIndicator.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverCautionIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
            uivWLITVCRiverWarningIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.8, blue: 1.0, alpha: 1.0).cgColor
            uivWLITVCRiverDangerIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        }
        else if(indicatorNumber == 1)
        {
            uivWLITVCRiverSafeIndicator.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverCautionIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverWarningIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
            uivWLITVCRiverDangerIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        }
        else if(indicatorNumber == 2)
        {
            uivWLITVCRiverSafeIndicator.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverCautionIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverWarningIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverDangerIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        }
        else if(indicatorNumber == 3)
        {
            uivWLITVCRiverSafeIndicator.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverCautionIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverWarningIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor
            uivWLITVCRiverDangerIndicator.layer.backgroundColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        }
    }
    
    func updateGraph(viewController:UIViewController , urlInString:String) {
        
        //self.uivRLCLGDWDTVCGraphView.bounds = CGRectMake(uivRLCLGDWDTVCGraphView.bounds.origin.x, uivRLCLGDWDTVCGraphView.bounds.origin.y, UIScreen.mainScreen().fixedCoordinateSpace.bounds.width, uivRLCLGDWDTVCGraphView.bounds.size.height)
        
        let frameOriginX: CGFloat = uivWLITVCGraphView.bounds.origin.x
        let frameOriginY: CGFloat = uivWLITVCGraphView.bounds.origin.y
        let frameSizeWidth: CGFloat = UIScreen.main.fixedCoordinateSpace.bounds.width
        let frameSizeHeight: CGFloat = uivWLITVCGraphView.bounds.size.height
        
        print("[WLITVCell] Graph view initiated...")
        
        //WaterLevelLibrary.graphFrameByPhoneSize(self.uivRLCLGDWDTVCGraphView)
        
        let viewBounds: CGRect = CGRect(x: frameOriginX, y: frameOriginY, width: frameSizeWidth, height: frameSizeHeight)
        
        let jScript: String = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=\(frameSizeWidth+100)'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        let wkUScript: WKUserScript = WKUserScript.init(source: jScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let wkUCController: WKUserContentController = WKUserContentController.init()
        wkUCController.addUserScript(wkUScript)
        
        let webConfig = WKWebViewConfiguration()
        webConfig.userContentController = wkUCController
        
        let graphURL: NSURL = NSURL(string: urlInString)!
        let graphRequest: NSURLRequest = NSURLRequest(url: graphURL as URL)
        self.graphWebView = WKWebView(frame: viewBounds, configuration: webConfig)
        self.graphWebView?.navigationDelegate = self
        self.graphWebView!.load(graphRequest as URLRequest)
        self.uivWLITVCGraphView.layer.borderWidth = 1
        self.uivWLITVCGraphView.layer.borderColor = UIColor.lightGray.cgColor
        self.uivWLITVCGraphView.addSubview(self.graphWebView!)
        self.uivWLITVCGraphView.sendSubview(toBack: self.graphWebView!)
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("[RLCLGDWDTVC] Graph load error: \(error.localizedDescription)")
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("[RLCLGDWDTVC] Loading graph...")
        uivWLITVCLoadingView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("[RLCLGDWDTVC] Graph loaded")
        uivWLITVCLoadingView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

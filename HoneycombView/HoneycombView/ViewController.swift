//
//  ViewController.swift
//  HoneycombView
//
//  Created by Abhishek Shinde on 19/11/15.
//  Copyright © 2015 Abhishek Shinde. All rights reserved.
//

import UIKit

var polyWidth : CGFloat = 0.0
var polyHeight : CGFloat = 0.0
var startingPtX:CGFloat = 0
var startingPtY:CGFloat = 0
let getWidthOfScreen = UIScreen.mainScreen().bounds.size.width
var userArray:[String]!
var arrayToShow:[String]!


public struct Constants {
    
    static let Bottom = "Bottom"
    static let Middle = "Middle"
    static let MiddleTop = "MiddleTop"
    static let Top = "Top"
    static let LeftTop = "LeftTop"
 
}

public class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate , cellhandleTap{
    
    //Starting point of initial View
    var tempTitleView:UIView!
    var filteredData:[String]=[]
    var filteredTableData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        arrayToShow = ["one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one"]
        userArray = ["one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one"]
        tableView.registerNib(UINib(nibName: "HexagonCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    //MARK: - TableViewDelegateMethods
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

            let cell:HexagonCell? =  tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? HexagonCell
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            cell?.backgroundColor = UIColor.clearColor()
            if  cell != nil {
                var userArrayNew = userArray

                //print(userArray.count)
                if (indexPath.row*3+3 > userArrayNew.count){ //last row
                    //arrayToShowUser.removeAll(keepCapacity: false)
                     cell?.renderUI(arrayToShow, emptyViews: [ true , true ,true ,true,true])
                    cell?.separatorInset = UIEdgeInsetsMake(0.0, cell!.bounds.size.width, 0.0, 0.0);
                    
                 }
                
                if indexPath.row*3+3 < userArrayNew.count{
                    
                    
                    arrayToShow.removeAll(keepCapacity: false)
                    arrayToShow = Array(userArrayNew[indexPath.row*3..<indexPath.row*3+3])
                    arrayToShow.insert(userArrayNew[0], atIndex: 1)
                    cell?.separatorInset = UIEdgeInsetsMake(0.0, cell!.bounds.size.width, 0.0, 0.0);
                    
                    cell!.renderUI(arrayToShow, emptyViews: [false, false,false,false,false])
                    
                }
                else if (indexPath.row*3+3 == userArrayNew.count){
                    arrayToShow.removeAll(keepCapacity: false)
                    arrayToShow = Array(userArrayNew[indexPath.row*3..<indexPath.row*3+3])
                    arrayToShow.insert(userArrayNew[0], atIndex: 1)
                    cell?.separatorInset = UIEdgeInsetsMake(0.0, cell!.bounds.size.width, 0.0, 0.0);
                    
                    cell!.renderUI(arrayToShow, emptyViews: [false, false,false,false,false])
                    
                }
                else if ((indexPath.row*3+3 - userArrayNew.count ) == 1 ){
                    
                    arrayToShow.removeAll(keepCapacity: false)
                    arrayToShow = Array(userArrayNew[indexPath.row*3..<userArrayNew.count])
                    arrayToShow.insert(userArrayNew[0], atIndex: 1)
                    cell?.separatorInset = UIEdgeInsetsMake(0.0, cell!.bounds.size.width, 0.0, 0.0);
                    
                    cell!.renderUI(arrayToShow, emptyViews: [true, true,true,false,true])
                    
                    
                }
                else if ((indexPath.row*3+3 - userArrayNew.count ) == 2 ){
                    
                    arrayToShow.removeAll(keepCapacity: false)
                    arrayToShow = Array(userArrayNew[indexPath.row*3..<userArrayNew.count])
                    arrayToShow.insert(userArrayNew[0], atIndex: 1)
                    cell?.separatorInset = UIEdgeInsetsMake(0.0, cell!.bounds.size.width, 0.0, 0.0);
                    
                    cell!.renderUI(arrayToShow, emptyViews: [false, false,false,false,false])
                    
                    
                }

            cell!.assingTagValue(indexPath)
            cell?.separatorInset = UIEdgeInsetsMake(0.0, cell!.bounds.size.width, 0.0, 0.0);
            
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            cell!.opaque = true
            
            cell?.delegate = self
            return cell!;
                
         }
        return cell!
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let getWidthOfScreen = UIScreen.mainScreen().bounds.size.width
        polyWidth =  (getWidthOfScreen / 2.5 )
        let sagitta = (polyWidth/2) - sqrt(pow((polyWidth/2), 2) - pow((polyWidth/4), 2))
        let tableCellHeight = ( getWidthOfScreen / 2.5 ) - (sagitta * 2)
        return tableCellHeight
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        if self.resultSearchController.active{
//            self.performSegueWithIdentifier("evaluate", sender:indexPath.row)
//        }
        
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        return userArray.count
        let noOfRow:Float = Float(userArray.count)/3
        
        
            if userArray.count > 0{
                    if(userArray.count % 3 == 0 || userArray.count % 3 == 2){
                        return Int(ceil(noOfRow)+1)
                    }else{
                        return Int(ceil(noOfRow))
                    }
                }
            else {
                return Int(ceil(noOfRow))
          }
    }
    

    
    
    
    //MARK: - Method For Navigating To Detailed View
    func cellTapOnSpecificView(tagVal: Int) {
        print(tagVal)
        if (tagVal  >= 0){
            
            self.performSegueWithIdentifier("detailView", sender: tagVal)
        }
    }
    

    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "detailView" {
            
//            let evaluateViewController = segue.destinationViewController as! GtUserDetailsViewController
////            evaluateViewController.title = NSLocalizedString("Evaluate",comment: "")
////            if resultSearchController.active == true{
////                evaluateViewController.evaluatee = usersList[sender as! Int] as! GtPerson
////            }else{
////                if segmentControl.selectedSegmentIndex == 0{
////                    
////                    evaluateViewController.evaluatee = userDetail[sender as! Int]
////                }
////                else{
////                    evaluateViewController.evaluatee = userDetailSortedOrder[sender as! Int]
////                }
////                
////            }
        }
    }
    
    
    

    
    
    
}


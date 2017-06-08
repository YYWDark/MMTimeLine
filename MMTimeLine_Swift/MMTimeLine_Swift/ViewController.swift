//
//  ViewController.swift
//  MMTimeLine_Swift
//
//  Created by wyy on 2017/6/8.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

let CellID = "MMTimeLineCell"
let AnimationDuring = 0.5

class ViewController: UIViewController {
    var sourceArray: [MMTimeLineModel] = [
        MMTimeLineModel("8:00","1: 上班打卡"),
        MMTimeLineModel("8:30","2: 今天天气不错呢，美好的一天。"),
        MMTimeLineModel("9:00","3: 开始要工作了呢，今天要做好多事请，先列个计划吧，嗯，开始工作。为了加长这个字符串，继续写以下废话，废话很多，用来占位置的，方便测试，嘻嘻哈哈，(*^__^*) 嘻嘻……"),
        MMTimeLineModel("9:30","4: 开一会儿小差吧，吃个点心啥的"),
        MMTimeLineModel("10:00","5: 哦，还有好多工作啊，别吃了"),
        MMTimeLineModel("10:30","6: 嗯，休息时间到了，今天是睡觉呢还是玩儿游戏呢，这是个问题,还是先玩一会游戏吧"),
        MMTimeLineModel("11:00","7: 继续工作，坑爹了，这个bug不好解决呀"),
        MMTimeLineModel("11:30","8: 先热个饭"),
        MMTimeLineModel("12:00","9: 吃饭，散步，一条龙"),
        MMTimeLineModel("12:30","10: 看会NBA,骑士这都能输？看来这周就要结束总决赛了"),
        MMTimeLineModel("13:00","11: 睡觉,想妹子"),
        MMTimeLineModel("14:00","12: 起来做事，bug修不完回不了家"),
        MMTimeLineModel("15:00","13: 下午茶时间到了,拿根香蕉和牛奶吧，反正也没有什么好吃的"),
        MMTimeLineModel("16:00","14: 继续工作"),
        MMTimeLineModel("17:00","15: 赶紧做完事情，免得又要加班。"),
        MMTimeLineModel("18:00","16: 约妹子吃饭看电影打豆豆一起学习swift,少壮不努力，老大喜当爹"),
        MMTimeLineModel("23:00","17: 至今思项羽，不肯喜当爹。睡觉"),
    ]
    var dataArrays:[MMTimeLineLayout] = []
    let tableView = UITableView(frame: kScreenRect, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        animationDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//MARK: -- Private Method
    func requesetData() {
        sourceArray.forEach { (model) in
            dataArrays.append(MMTimeLineLayout.init(model: model))
        }
    }
    
    func setUpSubViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MMTimeLineCell.classForCoder(), forCellReuseIdentifier: CellID)
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    func animationDisplay() {
        if self.dataArrays.count >= self.sourceArray.count {
            return
        }
        let model = self.sourceArray[self.dataArrays.count]
        dataArrays.append(MMTimeLineLayout.init(model: model))
//        self.sourceArray.remove(at: 0)
        
        let lastIndexPath = NSIndexPath(row: (self.dataArrays.count - 1), section: 0) as IndexPath
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [lastIndexPath], with: .none)
        self.tableView.endUpdates()
        self.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        self.tableView.separatorStyle = .none;
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationDuring) {
           self.animationDisplay()
        }
    }
}
//MARK: -- MMTimeLineCellDelegate
extension ViewController: MMTimeLineCellDelegate {
    func orderTrackingCellDidFnishedLoad(cell: MMTimeLineCell) {
        let layout = self.dataArrays[cell.tag]
        layout.model.iscellAlreadyLoad = true
    }
}

//MARK: -- UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let timeLineCell = (cell as!MMTimeLineCell)
        timeLineCell.configurationCell(layout: self.dataArrays[indexPath.row])
        timeLineCell.tag = indexPath.row
        timeLineCell.delegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataArrays[indexPath.row].totalHeight
    }
}

//MARK: -- UITableViewDataSource
extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrays.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as!MMTimeLineCell
        return cell
    }
}



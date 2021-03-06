//
//  LogTableViewCell.swift
//  APP-JI
//
//  Created by 黄鹏昊 on 2018/6/5.
//  Copyright © 2018年 黄鹏昊. All rights reserved.
//

import Foundation

class LogTableViewCell:UITableViewCell{
    
    var logContent:Log?
    
    var timeLab:UILabel?
    var bgLab:UILabel?
    
    var cellHeight:CGFloat?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if bgLab == nil{
            bgLab = UILabel.init()
            self.contentView.addSubview(bgLab!)
            bgLab!.backgroundColor = UIColor.init(named: "NormalYellow")
            bgLab!.layer.cornerRadius = 7
            bgLab!.layer.masksToBounds = true
            
            
            timeLab = UILabel.init()
            self.contentView.addSubview(timeLab!)
            timeLab?.font = UIFont.boldSystemFont(ofSize: 21)
            timeLab?.textAlignment = NSTextAlignment.center

            self.backgroundColor = UIColor.init(named: "LightYellow")
            self.selectionStyle = .none
            
        }

        return
    }
    
    func setContent() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日"
        timeLab?.text = formatter.string(from: (logContent!.time)! as Date)
        
    }
}

class TextLogTableViewCell:LogTableViewCell{

    var contentBG:UILabel?
    var contentLab:UILabel?

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if contentLab == nil {
            contentLab = UILabel.init()
            contentBG = UILabel.init()
            self.addSubview(contentBG!)
            self.addSubview(contentLab!)
            contentBG!.backgroundColor = UIColor.init(named: "DarkYellow")
            contentLab!.font = UIFont.systemFont(ofSize: 17)
            contentLab!.textColor = UIColor.white
            contentLab!.numberOfLines = 0
            contentBG!.layer.cornerRadius = 7
            contentBG!.layer.masksToBounds = true
        }
        
    }
    
    override func setContent() {
        super.setContent()
        let answerSize = logContent?.content!.boundingRect(with: CGSize.init(width: UIScreen.main.bounds.size.width-76, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 17)], context: nil).size
        contentBG!.frame = CGRect.init(x: 28, y: 23, width: UIScreen.main.bounds.size.width-56, height: answerSize!.height+27)
        timeLab?.frame = CGRect.init(x: 16, y: answerSize!.height+58, width: UIScreen.main.bounds.size.width-32, height: 26)
        contentLab!.frame = CGRect.init(x: 38, y: 37, width: UIScreen.main.bounds.size.width-76, height: answerSize!.height)
        bgLab!.frame = CGRect.init(x: 16, y: 10, width: UIScreen.main.bounds.size.width-32, height: answerSize!.height+87)
        contentLab!.text = logContent?.content
        
        cellHeight = (answerSize?.height)!+107
    }
}

class SwitchLogTableViewCell: LogTableViewCell {
    
    var contentBG:UILabel?
    var contentLab:UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if contentLab == nil {
            contentBG = UILabel.init()
            self.addSubview(contentBG!)
            contentLab = UILabel.init()
            self.addSubview(contentLab!)
            contentBG!.backgroundColor = UIColor.init(named: "DarkYellow")
            contentBG!.layer.cornerRadius = 7
            contentBG!.layer.masksToBounds = true
            contentLab!.font = UIFont.systemFont(ofSize: 53)
            contentLab!.textColor = UIColor.white
            contentLab!.numberOfLines = 0
            contentLab!.textAlignment = NSTextAlignment.center
            bgLab?.frame = CGRect.init(x: 16, y: 10, width: UIScreen.main.bounds.size.width-32, height: 222)
            timeLab?.frame = CGRect.init(x: 16, y: 193, width: UIScreen.main.bounds.size.width-32, height: 26)
        }

    }
    
    override func setContent() {
        super.setContent()
        contentBG!.frame = CGRect.init(x: 28, y: 23, width: UIScreen.main.bounds.size.width-56, height: 162)
        contentLab!.frame = CGRect.init(x: 28, y: 23, width: UIScreen.main.bounds.size.width-56, height: 162)
        switch logContent!.content! {
        case "yes":
            contentLab!.text = "是"
        case "no":
            contentLab!.text = "不是"
        default:
            contentLab!.text = "数据出错"
        }
        cellHeight = 242
        
    }

}

class PhotoLogTableViewCell:LogTableViewCell {
    
    var contentImageView: UIImageView?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if contentImageView == nil {
            contentImageView = UIImageView.init()
            contentImageView!.frame = CGRect.init(x: 28, y: 23, width: UIScreen.main.bounds.size.width-56, height: UIScreen.main.bounds.size.width-56)
            contentImageView!.layer.cornerRadius = 7
            contentImageView!.layer.masksToBounds = true
            self.addSubview(contentImageView!)
            bgLab!.frame = CGRect.init(x: 16, y: 10, width: UIScreen.main.bounds.size.width-32, height: 380)
            timeLab!.frame = CGRect.init(x: 16, y: 352, width: UIScreen.main.bounds.size.width-32, height: 26)
        }

    }
    
    override func setContent() {
        super.setContent()
        contentImageView?.image = UIImage.init(contentsOfFile: (logContent?.content)!)
        
        cellHeight = 400
    }
    
}

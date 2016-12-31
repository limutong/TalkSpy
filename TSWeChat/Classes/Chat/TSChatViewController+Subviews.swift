//
//  TSChatViewController+Subviews.swift
//  TSWeChat
//
//  Created by Hilen on 1/7/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import Foundation

private let kCustomKeyboardHeight: CGFloat = 216

// MARK: - @extension TSChatViewController
extension TSChatViewController {
    /**
     创建聊天的各种子 view
     */
    func setupSubviews(_ delegate: UITextViewDelegate) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1 >> subview setupActionBar")
        self.setupActionBar(delegate)
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.2 >> subview initListTableView")
        self.initListTableView()
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.3 >> subview setupKeyboardInputView")
        self.setupKeyboardInputView()
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.4 >> subview setupVoiceIndicatorView")
        self.setupVoiceIndicatorView()
    }
    
    fileprivate func initListTableView() {
        //点击 UITableView 隐藏键盘
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        self.listTableView.addGestureRecognizer(tap)
        tap.rx.event.subscribe {[weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.hideAllKeyboard()
        }.addDisposableTo(self.disposeBag)
        
        self.view.addSubview(self.listTableView)
        
        self.listTableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.chatActionBarView.snp.top)
        }
    }
    
    /**
     初始化操作栏
     */
    fileprivate func setupActionBar(_ delegate: UITextViewDelegate) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1.1 >> actionBar ts_viewFromNib")
        self.chatActionBarView = UIView.ts_viewFromNib(TSChatActionBarView.self)
        self.chatActionBarView.delegate = self
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1.2 >> talkSpyBar ts_viewFromNib")
        self.chatTalkSpyBarView = UIView.ts_viewFromNib(TSChatTalkSpyBarView.self)
        self.chatTalkSpyBarView.delegate = self
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1.3 >> actionBar addSubview ")
        self.chatActionBarView.inputTextView.delegate = delegate
        self.view.addSubview(self.chatActionBarView)
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1.4 >> talkSpyBar addSubview ")
        //self.chatTalkSpyBarView.inputTextView.delegate = delegate
        self.view.addSubview(self.chatTalkSpyBarView)
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1.4 >> actionBar makeConstraints ")
        self.chatActionBarView.snp.makeConstraints { [weak self] (make) -> Void in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.view.snp.left)
            make.right.equalTo(strongSelf.view.snp.right)
            strongSelf.actionBarPaddingBottomConstranit = make.bottom.equalTo(strongSelf.view.snp.bottom).constraint
            make.height.equalTo(kChatActionBarOriginalHeight)
        }
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1.5 >> talkSpyBar makeConstraints ")
        self.chatTalkSpyBarView.snp.makeConstraints { [weak self] (make) -> Void in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.view.snp.left)
            make.right.equalTo(strongSelf.view.snp.right)
            
            //strongSelf.actionBarPaddingBottomConstranit = make.bottom.equalTo(strongSelf.view.snp.bottom).constraint
            make.height.equalTo(kChatTalkSpyBarOriginalHeight)
        }
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3.0.1.6 >> talkSpyBar Done ")
    }
    
    /**
     初始化表情键盘，分享更多键盘
     */
    fileprivate func setupKeyboardInputView() {
        //emotionInputView init
        self.emotionInputView = UIView.ts_viewFromNib(TSChatEmotionInputView.self)
        self.emotionInputView.delegate = self
        self.view.addSubview(self.emotionInputView)
        self.emotionInputView.snp.makeConstraints {[weak self] (make) -> Void in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.view.snp.left)
            make.right.equalTo(strongSelf.view.snp.right)
            make.top.equalTo(strongSelf.chatActionBarView.snp.bottom).offset(0)
            make.height.equalTo(kCustomKeyboardHeight)
        }
        
        //shareMoreView init
        self.shareMoreView = UIView.ts_viewFromNib(TSChatShareMoreView.self)
        self.shareMoreView!.delegate = self
        self.view.addSubview(self.shareMoreView)
        self.shareMoreView.snp.makeConstraints {[weak self] (make) -> Void in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.view.snp.left)
            make.right.equalTo(strongSelf.view.snp.right)
            make.top.equalTo(strongSelf.chatActionBarView.snp.bottom).offset(0)
            make.height.equalTo(kCustomKeyboardHeight)
        }
    }
    
    /**
     初始化 VoiceIndicator
     */
    fileprivate func setupVoiceIndicatorView() {
        //voiceIndicatorView init
        self.voiceIndicatorView = UIView.ts_viewFromNib(TSChatVoiceIndicatorView.self)
        self.view.addSubview(self.voiceIndicatorView)
        self.voiceIndicatorView.snp.makeConstraints {[weak self] (make) -> Void in
            guard let strongSelf = self else { return }
            make.top.equalTo(strongSelf.view.snp.top).offset(100)
            make.left.equalTo(strongSelf.view.snp.left)
            make.bottom.equalTo(strongSelf.view.snp.bottom).offset(-100)
            make.right.equalTo(strongSelf.view.snp.right)
        }
        self.voiceIndicatorView.isHidden = true
    }
}



//
//  UIComponentSampleViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/25.
//

import UIKit
import UIComponent
import FloatingPanel

fileprivate enum UIComponentSampleSectionKey: String {
    case selfRecommendation
    case resumeNotes
    case avator
    case workExperience
    case personalConditions
    case educations
    case personalBasicInformations
    case personalContacts
    case biographic
    case attachments
    case recommender
    case simularResumes
    
    var sectionName: String {
        return rawValue
    }
    
    var key: String {
        return rawValue
    }
}

final class UIComponentSampleViewController: UIViewController {
    
    private var hashTags: [String] = ["顏值擔當", "顏值擔當", "顏值擔當"] {
        didSet { componentView.component = component }
    }
    
    private let componentView = ComponentScrollView()
    private var component: Component {
        VStack {
            HStack(justifyContent: .center, alignItems: .center) {
                Text("自我推薦")
                    .textColor(.red1)
                Image("icon _arrow right 1_")
            }
            .size(width: .fill)
            .inset(h: 20, v: 8)
            .view()
            .backgroundColor(.background)
            .cornerRadius(10)
            .shadow(4)
            .tappableView { [unowned self] _ in
                self.hashTags = ["顏值擔當", "顏值擔當", "顏值擔當"]
            }
            .id(UIComponentSampleSectionKey.selfRecommendation.key)
            .inset(h: 20)
            
            Space(height: 12)
            
            HStack(spacing: 2, justifyContent: .end, alignItems: .center) {
                Image("icon _edit 2_")
                Text("履歷備註").textColor(.red1)
                    .tappableView { [unowned self] tappable in
                        self.hashTags.removeAll()
                    }
            }
            .view()
            .id(UIComponentSampleSectionKey.resumeNotes.key)
            .inset(h: 20)
            
            HStack(justifyContent: .center) {
                SimpleViewComponent(view: UIView())
                    .cornerRadius(10)
                    .backgroundColor(.background)
                    .shadow(4, opacity: 0.25)
                    .size(width: 76, height: 96)
                    .id(UIComponentSampleSectionKey.avator.key)
                .overlay(
                    Image("cute_snow_white")
                        .size(width: 76, height: 96)
                        .clipsToBounds(true)
                        .cornerRadius(10)
                        .borderColor(.systemGray)
                        .borderWidth(1)
                )
            }
            
            Space(height: 6)
            
            if hashTags.count > 0 {
                HStack(spacing: 2, justifyContent: .center, alignItems: .center) {
                    Text("少女星 氣質型", font: .systemFont(ofSize: 10))
                        .textColor(.red1)
                    Image("icon _question mark circle_")
                        .size(width: 10, height: 10)
                }
                Space(height: 12)
            }
            
            VStack {
                HStack(alignItems: .end) {
                    Text("顏值擔當-白雪公主", font: .systemFont(ofSize: 18, weight: .bold))
                    Text("(12345678)", font: .systemFont(ofSize: 14, weight: .bold))
                }
                
                Space(height: 4)
                
                HStack(spacing: 8) {
                    ForEach(hashTags) { tag in
                        Text("#\(tag)")
                            .textColor(.systemBlue)
                            .tappableView { [unowned self] tappable in
                                self.hashTags.remove(at: 0)
                            }
                    }
                }
                
                Space(height: 8)
                
                HStack(spacing: 12) {
                    Text("女性")
                    Text("18歲")
                }
                
                Space(height: 8)
                
                Text("xxx 學校")
            }
            .inset(h: 24)
            
            Space(height: 12)
            
            VStack(spacing: 8) {
                HStack {
                    Text("工作性質")
                        .textColor(.systemGray)
                    Space(width: 12)
                    Text("兼職")
                }
                HStack {
                    Text("累積年資")
                        .textColor(.systemGray)
                    Space(width: 12)
                    Text("1~2年")
                }
                HStack {
                    Text("理想職缺")
                        .textColor(.systemGray)
                    Space(width: 12)
                    Text("躺著等養")
                }
                HStack {
                    Text("就業狀況")
                        .textColor(.systemGray)
                    Space(width: 12)
                    Text("待業中")
                }
            }
            .inset(12)
            .size(width: .fill)
            .view()
            .cornerRadius(10)
            .backgroundColor(.background)
            .shadow(4)
            .inset(h: 20)
            
            Space(height: 8)
            
            HStack(justifyContent: .end) {
                Text("最新動態: 2023/08/25").textColor(.systemGray)
            }
            .inset(right: 24)
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("工作經驗", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                
                VStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("累積年資")
                            .textColor(.systemGray)
                        Text("無 | 待業中")
                    }
                    VStack(spacing: 4) {
                        Text("累積經驗")
                            .textColor(.systemGray)
                        Text("無")
                    }
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.workExperience.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("求職條件", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                
                VStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("理想職稱")
                            .textColor(.systemGray)
                        Text("求職者未提供")
                    }
                    VStack(spacing: 4) {
                        Text("應徵類別")
                            .textColor(.systemGray)
                        Text("活動企劃人員、婚禮企劃人員、公關企劃人員、環境維護人員")
                    }
                    VStack(spacing: 4) {
                        Text("期望薪資")
                            .textColor(.systemGray)
                        Text("面議")
                    }
                    VStack(spacing: 4) {
                        Text("上班地點")
                            .textColor(.systemGray)
                        Text("台北市中山區、台北市大同區")
                    }
                    VStack(spacing: 4) {
                        Text("可上班日")
                            .textColor(.systemGray)
                        Text("隨時")
                    }
                    VStack(spacing: 4) {
                        Text("理想產業")
                            .textColor(.systemGray)
                        Text("任何產業")
                    }
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.personalConditions.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("教育程度", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                
                HStack(spacing: 8) {
                    Image("icon _degree hat_")
                        .offset(CGPoint(x: 0, y: 2))
                    VStack(spacing: 12) {
                        VStack(spacing: 4) {
                            Text("最高學歷")
                                .textColor(.systemGray)
                            Text("錯錯錯(大學在學)")
                        }
                        VStack(spacing: 4) {
                            Text("就讀科系")
                                .textColor(.systemGray)
                            Text("測試")
                        }
                        VStack(spacing: 4) {
                            Text("就讀時間")
                                .textColor(.systemGray)
                            Text("~(台灣)")
                        }
                    }
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.educations.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("基本資料", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                
                VStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("身高體重")
                            .textColor(.systemGray)
                        Text("100公分/30公斤")
                    }
                    VStack(spacing: 4) {
                        Text("年次星座")
                            .textColor(.systemGray)
                        Text("1995年|豬|天蠍座")
                    }
                    VStack(spacing: 4) {
                        Text("駕照")
                            .textColor(.systemGray)
                        Text("輕型機車|普通重型機車")
                    }
                    VStack(spacing: 4) {
                        Text("其他分身")
                            .textColor(.systemGray)
                        Text("身心障礙者")
                    }
                    VStack(spacing: 4) {
                        Text("殘障手冊")
                            .textColor(.systemGray)
                        Text("無")
                    }
                    VStack(spacing: 4) {
                        Text("輔助工具")
                            .textColor(.systemGray)
                        Text("金點一號")
                    }
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.personalBasicInformations.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("聯絡資訊", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                
                VStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("國籍")
                            .textColor(.systemGray)
                        Text("韓國")
                    }
                    VStack(spacing: 4) {
                        Text("聯絡方式")
                            .textColor(.systemGray)
                        Text("00:00 ~ 24:00")
                    }
                    VStack(spacing: 4) {
                        Text("聯絡電話")
                            .textColor(.systemGray)
                        Text("09123456789")
                            .textColor(.systemBlue)
                            .tappableView {
                                print("09123456789")
                            }
                        Text("(02)123456")
                            .textColor(.systemBlue)
                            .tappableView {
                                print("(02)123456")
                            }
                    }
                    VStack(spacing: 4) {
                        Text("電子郵件")
                            .textColor(.systemGray)
                        Text("abc@example.com")
                            .textColor(.systemBlue)
                            .tappableView {
                                print("abc@example.com")
                            }
                    }
                    VStack(spacing: 4) {
                        Text("聯絡地址")
                            .textColor(.systemGray)
                        Text("708 台南市安平區")
                    }
                    VStack(spacing: 4) {
                        Text("其他聯絡方式")
                            .textColor(.systemGray)
                        Text("測試")
                    }
                    VStack(spacing: 4) {
                        Text("兵役狀況")
                            .textColor(.systemGray)
                        Text("役畢(退伍: 2022/04)")
                    }
                    VStack(spacing: 4) {
                        Text("履歷更新")
                            .textColor(.systemGray)
                        Text("2023/07/04")
                    }
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.personalContacts.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("自傳", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                
                VStack(spacing: 12) {
                    Text("中文字傳")
                        .textColor(.systemGray)
                    Text("""
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""")
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.biographic.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("附件作品", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                VStack(spacing: 12) {
                    ForEach(1...10) { index in
                        HStack(justifyContent: .spaceBetween, alignItems: .center) {
                            Text("附件 \(index)")
                                .textColor(.systemGray)
                                .flex()
                            Image(UIImage(named: "icon_arrow_right_8")!.withRenderingMode(.alwaysTemplate))
                                .tintColor(.systemGray)
                        }
                        .tappableView {
                            print("附件 \(index)")
                        }
                    }
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.attachments.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("推薦人", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                VStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("推薦人")
                            .textColor(.systemGray)
                        Text("推薦人名稱")
                    }
                    
                    VStack(spacing: 4) {
                        Text("服務單位")
                            .textColor(.systemGray)
                        Text("服務單位名稱")
                    }
                    
                    VStack(spacing: 4) {
                        Text("電話")
                            .textColor(.systemGray)
                        Text("0912345678")
                            .textColor(.systemBlue)
                            .tappableView {
                                print("0912345678")
                            }
                    }
                    
                    VStack(spacing: 4) {
                        Text("電子郵件")
                            .textColor(.systemGray)
                        Text("abc@example.com")
                            .textColor(.systemBlue)
                            .tappableView {
                                print("abc@example.com")
                            }
                    }
                }
                .inset(12)
                .size(width: .fill)
                .view()
                .cornerRadius(10)
                .backgroundColor(.background)
                .shadow(4)
                .id(UIComponentSampleSectionKey.recommender.key)
                .inset(h: 20)
            }
            
            Space(height: 20)
            
            VStack(spacing: 8) {
                Text("相似履歷", font: .systemFont(ofSize: 16, weight: .bold))
                    .textColor(.red1)
                    .inset(left: 28)
                VStack(spacing: 12) {
                    ForEach(0...3) { index in
                        HStack(spacing: 12) {
                            Image("cute_snow_white")
                                .size(width: 64, height: 80)
                                .cornerRadius(10)
                                .clipsToBounds(true)
                            VStack(spacing: 8) {
                                Text("People \(index)")
                                HStack(spacing: 12) {
                                    Text("最高學歷")
                                        .textColor(.systemGray)
                                    Text("xxx 大學")
                                }
                                HStack(spacing: 12) {
                                    Text("主修學系")
                                        .textColor(.systemGray)
                                    Text("xxx 一般學類")
                                }
                                HStack(spacing: 12) {
                                    Text("工作經驗")
                                        .textColor(.systemGray)
                                    Text("xxx 大學")
                                }
                            }
                        }
                        .inset(h: 20, v: 12)
                        .size(width: .fill)
                        .badge(offset: CGPoint(x: -12, y: 12)) {
                            Text("3\(index)歲 | 男")
                        }
                        .view()
                        .cornerRadius(10)
                        .backgroundColor(.background)
                        .shadow(4)
                        .tappableView { [unowned self] _ in
                            let id = UIComponentSampleSectionKey.selfRecommendation.key
                            self.componentView.scrollTo(id: id, animated: true)
                        }
                    }
                }
                .view()
                .id(UIComponentSampleSectionKey.simularResumes.key)
                .inset(h: 20)
            }
        }
        .inset(bottom: 64)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func bindingUI() {
        view.backgroundColor = .white
        view.addSubview(componentView)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "UIComponent Sample"
        
        componentView.component = component
        componentView.animator = AnimatedReloadAnimator(duration: 0.2, cascade: true)
        
        let bottomContent = UIComponentSampleBottomViewController()
        bottomContent.component = Flow(justifyContent: .center, alignContent: .center) {
            Text("Button A")
                .textAlignment(.center)
                .tappableView {
                    
                }
                .flex()
            Text("Button B")
                .textAlignment(.center)
                .tappableView {
                    
                }
                .flex()
            Text("Button C")
                .textAlignment(.center)
                .tappableView {
                    
                }
                .flex()
        }
        
        let fpc = FloatingPanelController()
        fpc.set(contentViewController: bottomContent)
        fpc.addPanel(toParent: self)
        fpc.layout = BottomSheetPanelLayout()
        fpc.panGestureRecognizer.isEnabled = false
        fpc.surfaceView.appearance = BottomSheetFloatingPanelStyle(shadowOpacity: 0, backgroundColor: .clear, cornerRadius: 0).asSurfaceAppearance()
        fpc.surfaceView.grabberHandle.alpha = 0
        fpc.invalidateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        componentView.frame = view.bounds
    }
}

private class UIComponentSampleBottomViewController: UIViewController {
    
    private let componentView = ComponentScrollView()
    private let lineView = UIView()
    
    var component: Component? {
        didSet { componentView.component = component }
    }
    
    override func bindingUI() {
        view.addSubview(componentView)
        view.addSubview(lineView)
        view.backgroundColor = .background
        lineView.backgroundColor = .systemGray3
        lineView.cornerRadius = 0.5
        
        componentView.component = component ?? Flow(justifyContent: .center, alignContent: .center) {
            Text("`place your custom view`")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineView.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 1))
        componentView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }
}

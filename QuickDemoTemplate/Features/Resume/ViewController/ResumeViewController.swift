//
//  ResumeViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/17.
//

import UIKit

private enum ResumeSectionKeys: String {
    case avator
    case name
    case tags
    case simpleInfo
    case workExperience
    case conditions
    case educations
    case basicInfomations
    case contactInformations
}

final class ResumeViewController: UIViewController {
    
    static func instantiate() -> ResumeViewController {
        return Storyboard.resume.instantiate(ResumeViewController.self)
    }
    
    @IBOutlet weak var collectionView: CollectionView!
    
    var provider: ComposedProvider? {
        didSet { collectionView.provider = provider }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Resume"
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func bindingUI() {
        collectionView.delaysContentTouches = false
        provider = ComposedProvider(
            layout: FlowLayout().inset(top: 12, rest: 20),
            animator: WobbleAnimator(),
            sections: [
                /// icon _arrow right 1_
                GroupedProvider {
                    ComposedProvider(
                        layout: FlowLayout(spacing: 2, justifyContent: .center, alignItems: .center),
                        sections: [
                            LabelProvider(text: "自我推薦", color: .red1),
                            ImageProvider(name: "icon _arrow right 1_")
                        ]
                    )
                }
                .tappable {
                    print("ffdsfsdfdsfs")
                }
                .background(.white)
                .cornerRadius(8)
                .padding(8)
                .shadow(4)
                .size(width: .fill),
                ComposedProvider(
                    layout: FlowLayout(spacing: 2, justifyContent: .end, alignItems: .center).inset(12),
                    sections: [
                        ImageProvider(name: "icon _edit 2_") { _ in print("sffsdfsdsfsd") },
                        LabelProvider(text: "履歷備註", color: .red1) { _ in print("sffsdfsdsfsd") }
                    ]
                ),
                /// 圖片section
                ComposedProvider(
                    identifier: ResumeSectionKeys.avator.rawValue,
                    layout: FlowLayout(justifyContent: .center),
                    sections: [
                        AvatorProvider(imagePath: "cute_snow_white", size: CGSize(width: 96, height: 120))
                            .shadow(4, opacity: 0.5)
                            .border(.systemGray)
                            .cornerRadius(10),
                        SpaceProvider(height: 6),
                        /// icon _question mark circle_
                        GroupedProvider {
                            ComposedProvider(
                                layout: FlowLayout(spacing: 2, alignItems: .center),
                                sections: [
                                    LabelProvider(text: "少女星 氣質型", color: .red1)
                                        .cornerRadius(4),
                                    ImageProvider(name: "icon _question mark circle_"),
                                ]
                            )
                        }
                        .tappable {
                            print("fdsfsdfsddsdfds")
                        }
                    ]
                ),
                SpaceProvider(height: 12),
                /// Name section
                GroupedProvider(
                    identifier: ResumeSectionKeys.name.rawValue
                ) {
                    ComposedProvider(
                        layout: FlowLayout(spacing: 0, alignItems: .end),
                        sections: [
                            LabelProvider(text: "顏值擔當-白雪公主", font: .qt_body(size: 20).bolded),
                            LabelProvider(text: "(777777)")
                        ]
                    )
                }
                .background(.white)
                .cornerRadius(8)
                .padding(8, .horizontal)
                .padding(4, .vertical)
                .shadow(4),
                SpaceProvider(height: 4),
                /// Tag Section
                ComposedProvider(
                    identifier: ResumeSectionKeys.tags.rawValue,
                    layout: FlowLayout(spacing: 2),
                    sections: [
                        LabelProvider(text: "#顏值擔當", color: .blue2, font: .qt_body(size: 12))
                            .cornerRadius(4)
                            .padding(2),
                        LabelProvider(text: "#全場最佳", color: .blue2, font: .qt_body(size: 12))
                            .cornerRadius(4)
                            .padding(2),
                        LabelProvider(text: "#當紅偶像", color: .blue2, font: .qt_body(size: 12))
                            .cornerRadius(4)
                            .padding(2),
                    ]
                ),
                SpaceProvider(height: 12),
                /// 資訊section
                ComposedProvider(
                    identifier: ResumeSectionKeys.simpleInfo.rawValue,
                    layout: FlowLayout(),
                    sections: [
                        LabelProvider(text: "男性", font: .qt_body())
                            .background(.white)
                            .cornerRadius(8)
                            .padding(8, .horizontal)
                            .padding(4, .vertical)
                            .shadow(4),
                        SpaceProvider(width: 8),
                        LabelProvider(text: "18歲", font: .qt_body())
                            .background(.white)
                            .cornerRadius(8)
                            .padding(8, .horizontal)
                            .padding(4, .vertical)
                            .shadow(4),
                        SpaceProvider(height: 12),
                        LabelProvider(text: "超高等魔法研究學校", font: .qt_body())
                            .background(.white)
                            .cornerRadius(8)
                            .padding(8, .horizontal)
                            .padding(4, .vertical)
                            .shadow(4),
                    ]
                ),
                SpaceProvider(height: 12),
                GroupedProvider {
                    LabelProvider(text: "工作性質", color: .systemGray)
                    SpaceProvider(width: 20)
                    LabelProvider(text: "兼職")
                    SpaceProvider(height: 12)
                    LabelProvider(text: "累計年資", color: .systemGray)
                    SpaceProvider(width: 20)
                    LabelProvider(text: "2~3年")
                    SpaceProvider(height: 12)
                    LabelProvider(text: "理想職稱", color: .systemGray)
                    SpaceProvider(width: 20)
                    LabelProvider(text: "才藝老師")
                    SpaceProvider(height: 12)
                    LabelProvider(text: "就業狀況", color: .systemGray)
                    SpaceProvider(width: 20)
                    LabelProvider(text: "待業中")
                }
                .background(.white)
                .cornerRadius(8)
                .shadow(4)
                .padding(12),
                SpaceProvider(height: 12),
                ComposedProvider(
                    layout: FlowLayout(justifyContent: .end),
                    sections: [
                        LabelProvider(text: "最新動態: 9分鐘前", color: .systemGray, font: .qt_body(size: 12))
                    ]
                ),
                SpaceProvider(height: 12),
                /// 工作經驗 section
                ComposedProvider(
                    identifier: ResumeSectionKeys.workExperience.rawValue,
                    sections: [
                        LabelProvider(text: "工作經驗", color: .red1, font: .qt_body(size: 14).bolded)
                            .padding(UIEdgeInsets(left: 2)),
                        SpaceProvider(height: 6),
                        GroupedProvider {
                            LabelProvider(text: "累積年資", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "無 | 待業中")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "累積經驗", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "無")
                        }
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(4)
                        .padding(12)
                    ]
                ),
                SpaceProvider(height: 24),
                /// 求職條件 section
                ComposedProvider(
                    identifier: ResumeSectionKeys.conditions.rawValue,
                    sections: [
                        LabelProvider(text: "求職條件", color: .red1, font: .qt_body(size: 14).bolded)
                            .padding(UIEdgeInsets(left: 2)),
                        SpaceProvider(height: 6),
                        GroupedProvider {
                            LabelProvider(text: "理想職稱", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "求職者為提供", color: .systemGray4)
                            SpaceProvider(height: 20)
                            LabelProvider(text: "應徵類別", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "活動企劃人員、婚禮企劃人員、公關企劃人員、環境維護人員")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "期望薪資", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "面議")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "上班地點", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "台北市中山區、台北市大同區")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "可上班日", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "隨時")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "理想產業", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "任何產業")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "上班時段", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "日班")
                        }
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(4)
                        .padding(12)
                    ]
                ),
                SpaceProvider(height: 24),
                /// 教育程度 section
                ComposedProvider(
                    identifier: ResumeSectionKeys.educations.rawValue,
                    sections: [
                        LabelProvider(text: "教育程度", color: .red1, font: .qt_body(size: 14).bolded)
                            .padding(UIEdgeInsets(left: 2)),
                        SpaceProvider(height: 6),
                        GroupedProvider {
                            ImageProvider(name: "icon _degree hat_", size: nil)
                            ComposedProvider(
                                identifier: "edu",
                                layout: FlowLayout(),
                                sections: [
                                    LabelProvider(text: "最高學歷", color: .systemGray),
                                    SpaceProvider(height: 8),
                                    LabelProvider(text: "錯錯錯(大學在學)"),
                                    SpaceProvider(height: 20),
                                    LabelProvider(text: "就讀科系", color: .systemGray),
                                    SpaceProvider(height: 8),
                                    LabelProvider(text: "測試"),
                                    SpaceProvider(height: 20),
                                    LabelProvider(text: "就讀時間", color: .systemGray),
                                    SpaceProvider(height: 8),
                                    LabelProvider(text: "～(台灣)")
                                ]
                            )
                        }
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(4)
                        .padding(12)
                    ]
                ),
                SpaceProvider(height: 24),
                /// 基本資料 section
                ComposedProvider(
                    identifier: ResumeSectionKeys.basicInfomations.rawValue,
                    sections: [
                        LabelProvider(text: "基本資料", color: .red1, font: .qt_body(size: 14).bolded)
                            .padding(UIEdgeInsets(left: 2)),
                        SpaceProvider(height: 6),
                        GroupedProvider {
                            LabelProvider(text: "身高體重", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "100 公分 / 30 公斤")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "年次星座", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "1995年 | 豬 | 天蠍座")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "駕照", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "輕型機車 | 普通重型機車")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "自備車輛", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "輕型機車 | 普通重型機車")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "其他身份", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "身心障礙者")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "殘障手冊", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "無")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "輔助工具", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "金典一號")
                        }
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(4)
                        .padding(12)
                    ]
                ),
                SpaceProvider(height: 24),
                /// 聯絡資訊 section
                ComposedProvider(
                    identifier: ResumeSectionKeys.contactInformations.rawValue,
                    sections: [
                        LabelProvider(text: "聯絡資訊", color: .red1, font: .qt_body(size: 14).bolded)
                            .padding(UIEdgeInsets(left: 2)),
                        SpaceProvider(height: 6),
                        GroupedProvider {
                            LabelProvider(text: "國籍", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "韓國")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "聯絡方式", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "00:00 ~ 24:00")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "聯絡電話", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "0912345678", color: .systemBlue)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "(02)123456", color: .systemBlue)
                            SpaceProvider(height: 20)
                            LabelProvider(text: "電子郵件", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "abc@example.com", color: .systemBlue)
                            SpaceProvider(height: 20)
                            LabelProvider(text: "聯絡地址", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "708 台南市安平區")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "其他聯絡方式", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "測試")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "兵役狀況", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "役畢(退伍: 2022/04)")
                            SpaceProvider(height: 20)
                            LabelProvider(text: "履歷更新", color: .systemGray)
                            SpaceProvider(height: 8)
                            LabelProvider(text: "2023/07/04")
                        }
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(4)
                        .padding(12)
                    ]
                ),
            ]
        )
    }
    
    private func scrollTo(id: ResumeSectionKeys) {
        guard let firstIndex = provider?.sections.firstIndex(where: { $0.identifier == id.rawValue }) else { return }
        
        if let frame = provider?.flattenedProvider().frame(at: firstIndex) {
            collectionView.contentOffset.y = frame.origin.y
        }
    }
}

class GroupedProvider: SimpleViewProvider {
    
    init(
        identifier: String? = nil,
        layout: Layout = FlowLayout(),
        @ProviderArrayBuilder content: () -> [Provider]
    ) {
        let view = TappableView<CollectionView>()
        view.tapAnimation = false
        view.contentView.provider = ComposedProvider(sections: content())
        view.contentView.clipsToBounds = false
        
        super.init(
            identifier: identifier,
            views: [view],
            sizeSource: SimpleViewSizeSource(sizeStrategy: (.fit, .fit)),
            layout: layout
        )
    }

    private var contentView: TappableView<CollectionView> {
        return view(at: 0) as! TappableView<CollectionView>
    }
    
    @discardableResult
    func padding(_ padding: UIEdgeInsets) -> Self {
        contentView.inset = padding
        return self
    }
    
    @discardableResult
    func padding(_ value: CGFloat, _ position: PaddingPosition = [.horizontal, .vertical]) -> Self {
        var edge = UIEdgeInsets(0)
        if position.contains(.horizontal) {
            edge.left = value
            edge.right = value
        }
        if position.contains(.vertical) {
            edge.top = value
            edge.bottom = value
        }
        
        contentView.inset = edge + contentView.inset
        return self
    }
    
    @discardableResult
    func tappable(_ onTap: (() -> Void)?) -> Self {
        contentView.onTap = onTap
        contentView.tapAnimation = true
        contentView.contentView.isUserInteractionEnabled = false
        return self
    }
    
}

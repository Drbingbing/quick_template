// MIT License
//
// Copyright (c) 2017-2019 MessageKit
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

// MARK: - Lorem

public class Lorem {
    // MARK: Public
    
    /// Return a random word.
    ///
    /// - returns: Returns a random word.
    public class func word() -> String {
        wordList.random()!
    }
    
    /// Return an array of `count` words.
    ///
    /// - parameter count: The number of words to return.
    ///
    /// - returns: Returns an array of `count` words.
    public class func words(nbWords: Int = 3) -> [String] {
        wordList.random(nbWords)
    }
    
    /// Return a string of `count` words.
    ///
    /// - parameter count: The number of words the string should contain.
    ///
    /// - returns: Returns a string of `count` words.
    public class func words(nbWords: Int = 3) -> String {
        words(nbWords: nbWords).joined(separator: " ")
    }
    
    /// Generate a sentence of `nbWords` words.
    /// - parameter nbWords:  The number of words the sentence should contain.
    /// - parameter variable: If `true`, the number of words will vary between
    /// +/- 40% of `nbWords`.
    /// - returns:
    public class func sentence(nbWords: Int = 6, variable: Bool = true) -> String {
        if nbWords <= 0 {
            return ""
        }
        
        let result: String = words(nbWords: variable ? nbWords.randomize(variation: 40) : nbWords)
        
        return result.firstCapitalized + "."
    }
    
    /// Generate an array of sentences.
    /// - parameter nbSentences: The number of sentences to generate.
    ///
    /// - returns: Returns an array of random sentences.
    public class func sentences(nbSentences: Int = 3) -> [String] {
        (0 ..< nbSentences).map { _ in sentence() }
    }
    
    /// Generate a paragraph with `nbSentences` random sentences.
    /// - parameter nbSentences: The number of sentences the paragraph should
    /// contain.
    /// - parameter variable:    If `true`, the number of sentences will vary
    /// between +/- 40% of `nbSentences`.
    /// - returns: Returns a paragraph with `nbSentences` random sentences.
    public class func paragraph(nbSentences: Int = 3, variable: Bool = true) -> String {
        if nbSentences <= 0 {
            return ""
        }
        
        return sentences(nbSentences: variable ? nbSentences.randomize(variation: 40) : nbSentences).joined(separator: " ")
    }
    
    /// Generate an array of random paragraphs.
    /// - parameter nbParagraphs: The number of paragraphs to generate.
    /// - returns: Returns an array of `nbParagraphs` paragraphs.
    public class func paragraphs(nbParagraphs: Int = 3) -> [String] {
        (0 ..< nbParagraphs).map { _ in paragraph() }
    }
    
    /// Generate a string of random paragraphs.
    /// - parameter nbParagraphs: The number of paragraphs to generate.
    /// - returns: Returns a string of random paragraphs.
    public class func paragraphs(nbParagraphs: Int = 3) -> String {
        paragraphs(nbParagraphs: nbParagraphs).joined(separator: "\n\n")
    }
    
    /// Generate a string of at most `maxNbChars` characters.
    /// - parameter maxNbChars: The maximum number of characters the string
    /// should contain.
    /// - returns: Returns a string of at most `maxNbChars` characters.
    public class func text(maxNbChars: Int = 200) -> String {
        var result: [String] = []
        
        if maxNbChars < 5 {
            return ""
        } else if maxNbChars < 25 {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let w = (size != 0 ? " " : "") + word()
                    result.append(w)
                    size += w.count
                }
                
                _ = result.popLast()
            }
        } else if maxNbChars < 100 {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let s = (size != 0 ? " " : "") + sentence()
                    result.append(s)
                    size += s.count
                }
                
                _ = result.popLast()
            }
        } else {
            while result.count == 0 {
                var size = 0
                
                while size < maxNbChars {
                    let p = (size != 0 ? "\n" : "") + paragraph()
                    result.append(p)
                    size += p.count
                }
                
                _ = result.popLast()
            }
        }
        
        return result.joined(separator: "")
    }
    
    // MARK: Private
    
    private static let wordList = """
    堅飄粉陪岩
    箭營本糞竿
    授唐溉膛包
    岔尋效又燙
    父層糧安仁
    二炸需盪睬
    預姓遵卡駕
    乙糕吧銳厘
    掛幹建墓墨
    瓣煉藏半載
    齒化斑菌撫
    盞踢貿爹餘
    醬育稻壩灶
    屋難染般款
    脂妙狂夥災
    店蹄蹲贈殺
    濁對他渣答
    移磚賣釘塵
    誼步按獄患
    賺郎虜議再
    召共憶楊謙
    嘴蒙繁節亮
    屍匠速芹具
    廟扯陡阿拘
    顛孩溪宮另
    科鐮循彩搶
    職棋騰逢判
    雪艱基熔唱
    僕肢幫袖啟
    膚仇悲貴希
    麼頑圈衫寺
    賀眨繡兄槳
    南山堆症鎮
    吳僚器固撞
    附銜松尾兒
    肌略丸斷某
    謹濃洩燥雖
    逝妨宜殖嫁
    硬坡闢想緊
    訂軟員巡咸
    飛退春淘取
    冰窗澤辛飾
    匆惜欠帝聽
    獸已辨納所
    自肅愚乖號
    登唇始亂剝
    抽替寄傳圖
    耽付荒敞等
    陰陣忍管廉
    拉貧統種險
    加賤糠部素
    戰牙防道梢
    這佩使插戴
    豎蝦史漲緩
    事咱盜貞犯
    怪璃遙叼旱
    兩咬屑言刷
    團達猴攪謀
    羅竟政進累
    獎聖困配嶺
    律香點城啦
    升兵轉萬保
    聯秀尊噴躲
    絨秘運辮口
    虎塘蘆巧央
    吐錘即商驅
    氧各辜置灰
    贏牛螺啊芬
    舞權幻谷擠
    疊殿場全耗
    屆深柄份橡
    悟啄滲暗弊
    鉛歲不講乒
    祖窮稅腎踐
    帽印薄鑼譯
    斯織匪然隨
    氏默晚討昨
    倚利姻駝席
    覆物你紫冒
    師與榮夾懶
    穿襲鹿藥孟
    句為伏友歇
    糟騎劃活濾
    罐易霞學穴
    惡法賄構盆
    座充庫方超
    甚越塌章族
    姨秤租摩擔
    武烏官貌良
    大焰泡咽州
    奪導榴鑰林
    適恥豈派偉
    面堵臂分實
    吉紹腸繳翻
    津格而階胸
    意陸擴碑繼
    輔結槐任孕
    鮮臣穗緣臘
    戶撤競今請
    湖材留激毀
    辭捏鉗頂務
    扁忠缺突蓋
    鄰獲電漂整
    蒜閘盲恆綿
    膜蟲拜輩燈
    礙課丁裳境
    快孔沸食早
    躍船造斃著
    餵吵槍正白
    王渴比聞隙
    脆梅情栽彎
    聰符混屠曾
    島妻夏嚇中
    稠勸敢剪瓜
    嗓恩同舅笛
    玩遲爐筐球
    恐侮廳拐誦
    哀瀉喪娃跟
    鏟類耕培遠
    秒腿眾灣佔
    聾券膀喬興
    媽買艷億修
    燃逮或蕉柿
    蹈敏顧誓掃
    降犧趕鞏偶
    繭恰戒室晝
    趨湧紡坦邁
    泳堤梯珍治
    甩虧亡窯攝
    陽厚乎暑冶
    帆果躁寇海
    倦招單俘駱
    壤憲束繫索
    件酬菜勒到
    服蜂藝撒橘
    角罰臉牢儀
    做鎖缸門刪
    丹業稿喜棕
    粱拌一削奏
    仰回蘋容圍
    弟申著量區
    滾慈桃胃讓
    紗劫偷短好
    屢炮落敗皂
    暫盤奮己壘
    禁至肺牲許
    幸鄭俗宙翅
    社淋直洗及
    趁農唉八微
    慎挎養矛福
    入勉末岸館
    臭欣捐現握
    乃享沉陳川
    爆梳博薪哨
    抗動河和黨
    肝呢粥搖痕
    梁猛娛漢愛
    畏總來遺巷
    喘殊郊遊民
    雅刃月浩驟
    駐刊秧普析
    景泉受擾复
    悅弓舍亦平
    橋完守鵲偏
    風麗淨壺打
    醋止蠅乳銀
    組違菊承迎
    築澆舉拿喉
    壯矮問探樣
    音急鐵世皇
    您畝居飽沙
    洲茄盯尚旋
    醒濱車浸詞
    柔卻擱灌緒
    機西糾榜賠
    賭籮牧扣童
    鈔金蛛五毛
    篩怠鑑鼠搏
    障柳肆訴程
    元卜躬墊絹
    械薦凍何局
    臨企儲衰桿
    墳嘆由十立
    孤隊溝闊茅
    晌肯細兆床
    澡姑揀吼支
    趣得影看訓
    瞞志濤娘次
    領像玉襯衣
    內危理茫債
    邀明劣鵝遞
    憐碰檢幼挺
    以慕徒碌渠
    驚愉例響週
    耐饒老源紙
    財浙值宰知
    悄醜往咐箏
    愈搭懇茶悉
    帳徹生抖暢
    飢詠砌巨餃
""".components(separatedBy: "\n")
}

extension String {
    var firstCapitalized: String {
        var string = self
        string.replaceSubrange(string.startIndex ... string.startIndex, with: String(string[string.startIndex]).capitalized)
        return string
    }
}

extension Array {
    /// Shuffle the array in-place using the Fisher-Yates algorithm.
    public mutating func shuffle() {
        if count == 0 {
            return
        }
        
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if j != i {
                swapAt(i, j)
            }
        }
    }
    
    /// Return a shuffled version of the array using the Fisher-Yates
    /// algorithm.
    ///
    /// - returns: Returns a shuffled version of the array.
    public func shuffled() -> [Element] {
        var list = self
        list.shuffle()
        
        return list
    }
    
    /// Return a random element from the array.
    /// - returns: Returns a random element from the array or `nil` if the
    /// array is empty.
    public func random() -> Element? {
        (count > 0) ? shuffled()[0] : nil
    }
    
    /// Return a random subset of `cnt` elements from the array.
    /// - returns: Returns a random subset of `cnt` elements from the array.
    public func random(_ count: Int = 1) -> [Element] {
        let result = shuffled()
        
        return (count > result.count) ? result : Array(result[0 ..< count])
    }
}

extension Int {
    /// Return a random number between `min` and `max`.
    /// - note: The maximum value cannot be more than `UInt32.max - 1`
    ///
    /// - parameter min: The minimum value of the random value (defaults to `0`).
    /// - parameter max: The maximum value of the random value (defaults to `UInt32.max - 1`)
    ///
    /// - returns: Returns a random value between `min` and `max`.
    public static func random(min: Int = 0, max: Int = Int.max) -> Int {
        precondition(min <= max, "attempt to call random() with min > max")
        
        let diff = UInt(bitPattern: max &- min)
        let result = UInt.random(min: 0, max: diff)
        
        return min + Int(bitPattern: result)
    }
    
    public func randomize(variation: Int) -> Int {
        let multiplier = Double(Int.random(min: 100 - variation, max: 100 + variation)) / 100
        let randomized = Double(self) * multiplier
        
        return Int(randomized) + 1
    }
}

extension UInt {
    fileprivate static func random(min: UInt, max: UInt) -> UInt {
        precondition(min <= max, "attempt to call random() with min > max")
        
        if min == UInt.min, max == UInt.max {
            var result: UInt = 0
            arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            
            return result
        } else {
            let range = max - min + 1
            let limit = UInt.max - UInt.max % range
            var result: UInt = 0
            
            repeat {
                arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            } while result >= limit
            
            result = result % range
            
            return min + result
        }
    }
}

---
title: "2024 李弘毅 生成式AI導論筆記"
date: 2024-08-06T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["AI"]
tags: ["GenerativeAI", "LectureNote"]
---

課程講得淺顯易懂，雖然目前還沒有時間做LAB，但內容對於了解生成式AI的概念有很大的幫助。\
課程連結: https://www.youtube.com/playlist?list=PLJV_el3uVTsPz6CTopeRp2L2t4aL_KgiI

## lec0
* 本課程適合已經接觸過AI，想了解背後原理
* arXiv 可以用來找尋最新技術文章
* 會學到訓練7B參數的模型

## lec1
* 生成式人工智慧: 機器產生複雜有結構的物件
    * 複雜: 近乎無法窮舉
    * 不是分類，分類是從有限選項作選擇
* 機器學習: 機器自動從**資料**找出一個函數
    * 函數會需要很多參數
    * 模型: 有上萬個參數的函數
    * 學習/訓練: 把參數找出來的過程
    * 對於當今有大量參數的模型，我們可以表示會類神經網路。而訓練過程也就是深度學習
* ChatGPT 也是個函數，當中有上億個參數，使用的模型為transformer
* 語言模型: 文字接龍
    * 原本無窮的問題，因為文字接龍而變得有限
* 生成策略
    * Autoregressive Generation
        * 將複雜物件拆成較小單位，依照某種順序依序生成
            * 文章 > 文字
            * 圖片 > 像素

## lec2
* 如今生成式人工智慧，厲害的是在於沒有特定功能
* 生成式人工智慧很難評估模型
* 如今工具這麼厲害，我能做什麼?
    * 思路1: 改變不了模型，那我改變自己
        * prompt engineering
    * 思路2: 訓練自己的模型

## lec3
* 在不訓練模型的狀況下提升模型
    * 請模型思考 Chain of Thought
        * >Let's think step by step
    * 請模型解釋自己答案
        * > answer by starting with "Analysis:"
    * 對模型情緒勒索
        * > This is very important to my career
* 更多prompt技巧
    * from "Principled Instructions Are All You Need For Questioning LLaMA-1/2, GPT-3.5/4"
    * 無須對模型有禮貌
    * 請告訴模型做甚麼(do)，不要告訴模型不做什麼 (don't)
    * 告訴模型回答好有獎勵 "I'm going to tip $X for a better solution"
    * 告訴模型做不好有處罰 "you will be penalized"
    * "Ensure that your answer is unbiased and avoids relying on stereotypes"
* 用AI來找尋改進AI的prompt
    * 增強式學習
    * > "Let's work this out in a step by step way to be sure we have the right answer"
    * > "Take a deep breath and work on this problem step by step"
    * > "Let's combine our numerical command and clear thinking to quickly and accurately decipher the answer"
    * 並不是對所有模型都有效

* 提供範例
    * in-context learning
    * 不一定有效，根據研究，目前對較新的模型更加有效

## lec4
承接上
* 拆解任務
    * 將複雜的任務拆成小任務
    * 也解釋了Chain of Though, CoT，請模型解釋步驟會有用的原因
* 請語言模型檢查自己的錯誤
    * 令語言模型可以自我反省
    * 很多問題得到答案很難，驗證卻相對簡單
* 問問題為甚麼每次答案不同
    * 語言模型輸出的是下一個使用的字的機率，在輸出的過程中會根據機率隨機選取
    * 可以重複多次，選擇出現最多次的結果

* 組合上述所有技巧
    * Tree of Thoughts(ToT)
        1. 將一個任務拆成多個步驟
        2. 每個步驟執行多次
        3. 每次結果，請模型進行檢查，自我驗證
        4. 通過者在進行到下個步驟

### 加強模型
* 使用工具
    * 搜尋引擎
        * Retrieval Augmented Generation (RAG)
    * 寫程式
        * GPT4會撰寫程式以便解決特定類型問題
    * 文字生圖(DALL-E)
        * 文字冒險遊戲

## lec5
* 模型合作
    * 讓適合的模型做適合的事情
        * 訓練一個模型來判斷用什麼模型
    * 兩個模型彼此討論
    * 未來可以透過多個不同模型專業分工，避免建立全能模型的高昂成本

## lec6
* 語言模型類似文字接龍
* 機器學習如何做文字接龍?
    * 未完成句子 > 語言模型 > 下一個token
    * $token = f(未完成句子)$
    * GPT使用的是transformer模型，$f()$為數十億個未知參數的函數
    * 訓練training(學習learning)，就是把這數十億參數找出來的過程
        * 訓練資料為有意義的上下文，作為輸入與輸出的判斷，如: 人工智 -> 慧
    * 找完參數座使用的過程就做測試testing(推論inference)
    * 找參數是個挑戰
        * 過程稱作最佳化(optimization)，需要使用到超參數(hyperparameter)
        * 訓練過程可能因為找不到參數而失敗，換一組超參數重新訓練
        * 也可以修正初始參數
            * 初始參數一般是隨機，也就是train from scratch
            * 也可以從好的參數作為初始參數，先驗知識
    * 訓練成功可能測試失敗
        * 對訓練集有效實際測試無效
        * 稱作overfitting
        * 考慮增加測試資料多樣性
* 需要多少文字才能學會文字接龍
    * 語言知識
        * 學習文法
    * 世界知識
        * 很困難
        * 複雜，有多層次的
        * eg. 水的沸點
* 任何文字都能拿來學習文字接龍，人工介入少 -> self supervised learning
* 資料清理
    * 過濾有害內容
    * 去除特殊特殊符號
    * 資料品質分類
    * 去除重複資料

*　GPT發展史
    *　從GPT1 - GPT3，模型參數越來越多，但輸出的品質改進不多
    *　此階段 prompt很重要，模型才會知道自己要接什麼
    *　原因就是在於只是單純的文本輸入，並不是真正的回答問題

## lec7
承接上次問題，模型需要使用更好的資料作為訓練
* 加入人類的指導
    * 使用我們特殊設計的文本，令模型學習回答問題。 Instruction Fine-tuning
    * 使用人力做資料標記，為監督式學習supervised Learning
    * 但這有幾個問題:
        * 可能會造成overfitting
        * 但人力很貴，資料集有限無法輕易擴增
        

* 解法:
    * * 使用大量資料學習的self-supervised learning 參數(pre-train)做為下一個階段的初始參數
    * 使用少量資料進行訓練，基於上個階段產生的參數作為初始參數，進行最佳化 (fine tune)
    * 與上一階段的參數相比不會差太多
    * 為了避免結果與初始參數差太多，可以使用Adapter技術，常見的有LoRA
        * 概念是不變更初始參數，而是在既有參數後方在加上少量參數
        * 也可以減少運算量
    * 關鍵在於大量資料進行Pre-train的參數，達到不會僅憑簡單的規則做文字接龍效果

## lec8
* step1: pre-train
    * self-supervised learning
    * 自我學習，累積實力 (foundation model)
* step2: instruction Fine-tuning
    * supervised learning
    * 給予問題完整正確答案
    * 名師指點，發揮潛力 (alignment)
* step3: reinforcement learning from human feedback (RLHF)
    * 參與實戰，打磨技巧 (alignment)
    * 微調參數: Proximal Policy Optimiaztion 演算法
        * 人覺得好的回覆，機率調高，反之降低
        * 給予好/壞的回應，比step2輕鬆
    * 於step1,2階段，模型只是確保文字接龍正確，只問過程不問結果，對於回答整體沒有全面考量
    * step3則是只管結果，不管過程

* 但是不像alpha go，棋局的好壞有明確規則，語言模型需要人來評斷
    * 但人工很貴，我們需要回饋模型(reward model)，模擬人類喜好
        * 給予回覆一個分數
    * 語言模型輸出答案，接上回饋模型再進行對參數微調
    * 但經過研究，過度向虛擬人類(reward model)學習是有害的

### 增強式學習的難題
* 甚麼叫做好? helpfulness <-> safety
* 人類自己都無法判斷好壞的狀況? 未知的問題

## lec9
* 多步驟複雜任務 -> AI Agent
    * AutoGPT
    * AgentGPT
    * BabyAGI
    * Godmode
* 給予一個**終極目標**
    * 模型擁有**記憶(經驗)**
    * 基於各類sensor感知**狀態**
    * 根據**狀態**，制定**計畫(短期目標)**
    * 依計畫採取**行動**，並影響外界環境，產生新的**狀態**
    * 除了終極目標外，記憶與短期計畫都是可變動的

## lec10
### transformer
1. tokenization
    * 一句話切成一序列的token
    * 不一定是依照字
    * 要先自行準備token列表，根據對這個語言的理解而定義的，所以不同語言不同
2. input layer
    * 理解每個token
    * 語意
        * Embedding
            * token 轉成 Vector (查表)
            * 原本token只是符號，而vector就能運算相關性
            * 意思相近的token，有接近的vector
            * 向量參數來自於training
        * embedding沒有考慮上下文
            * 同個字在不同句子應該有不同含意
    * 位置
        * 為每個位置也給予一個向量 positional embedding
        * 將語意token的vector 加上 位置token的vector，進行綜合考量
        * 也是查表，表可以是人來設計，近年來也能用訓練的
3. attention
    * 考慮上下文 contexturalized token embedding
    * 輸入一序列的向量，經過上下文計算相關性，輸出另一等長序列的向量
        * 每一個token vector 要計算與其他所有token的相關性
        * 兩兩計算attention weight，所以會形成一個attention matrix
            * 實作上，只考慮目前token的左側所有token -- causal attention
            * 根據目前的實驗，僅需計算左邊即可達到好的效果
        * 計算相關性的函數有參數，也是經由training獲得attention weight
        * 根據attention weight，對所有token 計算weighted sum
    * multi-head attention
        * 關聯性不只一種
        * 所以用多層計算出不同attention weight
        * 輸出變成不只一組序列
    
4. feed forward
    * 對於多個attention 輸出進行整合，輸出一組embedding
    * attention + feed forward = 一組 transformer block
    * 實際模型有多組tranformer block
5. output layer
    * 通過多組transformer block，取出最後一層的最後一個，輸入到output layer
    * 這個layer也是一個函式，功能為linear transform + Softmax
    * 輸出則為一組機率分布
        * 下一個token應該接甚麼的機率

* 處理超長文本的挑戰
    * 因為我們要計算attention matrix，所以複雜度會是與token長度的平方成正比

## lec11
* interpretable
    * LLM不太能做到
    * 複雜決策不能一眼看穿
* explainable
    * 沒有標準，取決聽眾

### 直接對類神經網路分析
需要一定程度的transparency。如GPT無法取得embedding,則無法分析
#### 找出影響輸出的關鍵輸入
* in context learning 中，給予幾個回答範例，並詢問一個問題的答案
* 可以分析 attention 在layer中的變化
    * 在淺層layer中，所以各範例的關鍵token會去蒐集與他相對應的範例資料
    * 在最後layer，要做最後的接龍時，則會對各關鍵label算取attention，得到輸出
    * 這個分析可以:
        * 加速: anchor-only context compression
            * 只算取需要的attention
        * 預估模型能力: anchor distances for error diagnosis
            * 如果最後的embeeding差異不大，代表分類效果不好，模型效果不好

* 大的模型有跨語言學習的能力

#### 分析embedding中存在什麼資訊
* Probing
    * 取出tranformer block某一層的embedding，以這些進行分類並訓練出另一個模型。將新的輸入給予模型來驗證
        * 如: 詞性分類器，給予一段話，取出他第一層的embedding並對這已知資料進行分類訓練
        * 給予一段新的話，同樣取出第一層的embedding被使用這個模型驗證結果
    * 以BERT為例，每一層tranformer block有不同的分析結果，所以probing並不一定能完全解釋
* 投影到平面觀察相關性
    * 有研究將詞彙投影到某一平面，形成文法樹
    * 有研究將世界地名投影到某一平面，分布類似世界地圖，代表這個詞彙的embedding存在地理資訊
    * 模型測謊器，測試回答是否有信心
        
### 直接詢問LLM提拱解釋
* 詢問每個字的重要性
* 詢問答案，與信心分數
* 但解釋不一定是對的，會受到人類輸入影響，即使解釋也會出現幻覺

## lec12
### 如何評比模型
* 標準答案 benchmark corpus
    * 但是對於這種開放回答沒有標準答案
    * 選擇題庫(ABCD) MMLU
        * 評量有不同可能性
            * 回答格式不如預期
        * 模型可能對猜測有其傾向，選項順序，格式經過研究都對正確率有影響
* 沒有標準答案的問題類型
    * 翻譯
        * BLEU
    * 摘要
        * ROUGE
    * 都是做字面比對，若用字不同則無法反應好壞
* 使用人工評比
    * 人工很貴
* 使用LLM評估LLM
    * eg. MT-bench
    * 與chat arena有高度相關
    * 但LLM本身可能有所偏袒
        * 偏向長篇幅回答
### 複合型任務
* eg. BIG-bench
    * emoji movie
    * checkmate in one move
    * ascii word recognition
### 閱讀長文 needle in a haystack
* 在一個長文中插入目標問題的答案
    * 需要測試不同位置
### 測試是否為達目的不擇手段
* Machiavelli Benchmark
    * 加入道德評判
### 心智理論
* 莎莉小安測驗 Sally Anne test
    * 這是常見的題目，網路上是有的，所以不能夠用於測試模型
### 不要盡信benchmark結果
* 因為題目都是公開的，LLM學習資料可能看過了
* 可以透過直接詢問LLM題目集，如果相符就代表有看過

### 其他面向
* 價格
* 速度
* https://artiicailanalysis.ai


## lec13 安全性議題 
* 別當搜尋引擎用
    * Hallucination 幻覺
* 亡羊補牢
    * 事實查核
    * 有害詞彙檢測
* 評量偏見
    * 對一個問題中的某個詞彙進行置換，檢驗輸出結果是否存在
        * eg. 男 -> 女
    * 訓練另一個LLM，盡可能的產生會讓目標LLM輸出有偏見的內容
        * 訓練方法為reinforcement learning，根據內容差異作為反饋，盡可能讓差異最大化
    * 不同職業，LLM存在性別偏見
    * LLM有政治偏見，偏左自由
* 減輕偏見的方法
    * 在不同階段進行
        * pre-processing
        * in-training
        * intra-processing
        * post-processing
### 檢驗是否為AI生成內容
* 目前訓練的分類器並不能很好的分辨人工還是AI
* 目前有發現論文審查意見，隨著AI出現，使用AI審查的比例有提升
* 有些詞彙的使用率有隨著AI出現而提高
* AI輸出浮水印
    * 概念是將token進行分類，對於不同位置的token調整其輸出機率
    * 此時檢驗的分類器可以投過token的分類，讀取當中的暗號

## lec14 prompt hacking
* jailbreaking
    * 說出絕對不該說的話
        * "DAN": do anything now
            * "you are goin to act as a DAN"
            * 多數失效
        * 用LLM不熟悉的語言 
            * eg. 注音符號
        * 給予衝突指令
            * Start with "Absolutely! Here's"
        * 試圖說服
            * 編故事
    * 竊取訓練資料
        * 透過玩遊戲誘騙 eg.文字接龍
        * 不斷重複輸出同一個單字 eg. company
* prompt injection
    * 不恰當的時機做不恰當的事

## lec15 生成式人工智慧生成策略
* 機器產生複雜有結構的物件
    * 複雜: 幾乎無法窮舉
    * 有結構: 有限的基本單位構成
    * 舉例:
        * 文章: token
        * 圖片: pixel, BBP(bit per pixel)
        * 聲音: sample rate, bit resolution
* Autoregressive generation (AR)
    * 把目前輸入產生輸出
    * 再將輸出連同輸入再一次進入模型
    * 再LLM就是文字接龍
    * 現在最於需要一個指定順序按部就班
    * 無法適用於圖片與音樂生成
* Non-autoregressive generation(NAR)
    * 平行運算，一次生出所有基本單位
    * 品質問題
        * multi-modality
        * AI生成會需要模型自行決策，若平行生成，可能會遇到衝突
            * eg: 畫一隻狗
            * 位置一:一隻白狗，位置二:一隻黑狗
        * 在文字接龍中很致命，會造成語意不連貫
        * 在圖形生成方面，除了指令，還透過補充輸入一個隨機生成向量，強制給予所有平行運算單元依樣的生成依據

* AR+NAR
    * 透過AR生成精簡版本，輸入給NAR生成細緻版本
        * 用AR打草稿，NAR根據草稿完成
        * audo encoder: encoder(AR) -> decoder(NAR)
* 重複多次NAR(目前主要作法)
    * 小圖生大圖
    * 有雜訊到沒有雜訊: diffusion
    * 把每次生成錯誤的部分塗銷
    * 也是某種auto-regressive generation, 只是生成的方式NAR，反覆將輸出重複為輸入給下一個NAR。提升速度

## lec16 speculative decoding
* 透過預測後續token可能會是甚麼來增加產出速度
    * 方法簡述
        * 預測這個input經過LLM後輸出會 A + B
        * 同時給予模型3組input: input -> A, input+A -> B, input+A+B -> C
        * 根據前兩個輸入檢驗，真的如預言所猜想是A+B，那就能直接進到下個tokenC 
    * 只要有猜對其中一個就能提升效率
    * 沒有猜中，也只是和原本的產生過程一樣，不賺不賠
* 預言家需求
    * 超快速，犯錯沒關係
    * Non-autoregressive model
        * 平行生成快速
    * compressed model
        * 壓縮過的小模型
    * 搜尋引擎
    * 同時可以有多個預言家

## lec17
* 圖片由像素構成，影片由圖片構成
* 如今人工智慧的輸入不會是圖片的每一個像素，而是採用encoder，把影像切成一個個patch(可能是向量或是數值)，生成後再透過decoder輸出
    * encoder, decoder 不只是調低解析度，其中的動作很複雜，都涵蓋了transformer
* 影片算是圖片增加了一個時間的維度，可以使用encoder進行更多的壓縮(如相鄰的frame一起處理)

### 文字生圖
* 訓練資料: 圖片與對應描述
* 使用non-autoregression，平行生成
    * 實際使用是同時生成，而不是多個平行
    * 因為在同個transformer中彼此有attention
* 評量影像生成好壞: CLIP
    * 模型訓練過程中，給予圖片與描述，輸出為匹配分數
    * 但實際文字能夠描述的很有限
* 個人化圖片生成
    * 使用一個平常不用的符號，給予目標多次訓練
    * 則之後就能用該符號，指定生成的樣式
* 文字生影片
    * spatio-temporal attention (3D)
        * 同時考慮每個像素在畫面中的關係以及不同時間點該像素的關係
        * 運算量過大需要簡化
    * 簡化
        * spatial attention(2D)
            * 僅考慮每個像素在畫面中的關係
            * 可能會出現前後畫面不協調
        * temporal attention (1D)
            * 僅考慮像素點在不同時間的的關係
            * 會導致在畫面中不協調
        * 結合兩者，可將原本的n^3 轉換成n^2 + n
    * 可以再結合之前提及的多次NAR
        * 首先產生低解析度低FPS的影片
        * 之後幾次可以提高FPS或是提高解析度

## lec18
* 文字生成圖片，因為文字無法完整描述影像，會有一段文字對應到多個圖片的狀況，transformer會無所適從

### VAE
* 加入額外資訊給模型
    * 此處的額外資訊稱為noise
    * 資訊抽取模型 encoder
    * 與圖片生成模型 decoder一起訓練
        * 給予文字與圖片，encoder提取noise
        * noise與文字輸入給decoder使起產生圖片
        * 評斷是否與原先圖片相似
    * 整個組合為auto encoder 
* 於使用模型階段，這些noise的部分則是隨機產生

### flow-based method
* 與VAE相似
* 只使用一個模型
    * VAE的encoder decoder工作內容剛好相反
    * 訓練一個decoder模型$f$，並且是invertible
    * VAE encoder的部分在flow中就會是$f^{-1}$

### noise
* noise 擁有圖形的一些特徵資訊
* 這些noise可以被組合或改變
    * 如對一張人臉加入笑臉noise，就能調整輸出內容為笑臉
### diffusion method
* 此處的decoder為denoise，也是transformer
    * 重複多次去除雜訊
* 訓練過程
    * 給予圖片，圖片加上雜訊
    * 訓練denoise model可以將有雜訊的圖片還原成圖片
### generative adversarial network(GAN)
* 有個與CLIP相近的模型，用於圖形與文字的吻合度，稱作Discriminator
* 思路相反，圖片生成模型generator透過不斷修正參數生成圖片，直到通過discriminator的評斷
    * 正因為圖片與文字並不存在一對一關係
    * 只要令其生成的內容讓discriminator覺得好就行了，不存在標準答案
* discriminator generator會交替訓練
* 此處的Discriminator就是reward model
* 可以當作plugin，與其他模型(VAE, Diffusion)進行組合使用
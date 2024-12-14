---
title: "Head First Design Pattern Note"
date: 2024-12-13T23:36:18-0800
draft: false
description: ""
type: "post"
categories: []
tags: []
---
## chapter 1: 策略模式 Strategy Pattern
策略模式定義了算法族，分別封裝起來，讓他們之間可以互相替換，此模式讓算法的變化獨立於使用算法的客戶

* 開頭先用了設計鴨子做情境。由於想讓鴨子加入"飛"的功能，Joe將這個加在了super class中，卻也造成了不該會飛的鴨子如橡皮鴨也產生了飛的功能。
* 即使用了繼承，在子類覆蓋掉，也會因為子類型眾多不全面。書中舉例了在都不會飛的鴨子中，橡皮鴨會叫，而誘餌鴨不會叫
* 若採用interface，會造成code無法重複使用
* 軟體開發不變的真理就是"變"。不管當初設計多完美，一段時間後都會需要改變。
* **設計原則: 找出應用中可能需要變化的部分並獨立，不要與不需要變化的代碼混在一起。**
* **設計原則: 針對interface設計，而不是針對實現設計**
    * 這部分的意思是說，我們要針對abstract class or interface進行設計。例如: abstract class 有Animal，繼承他的有Dog。則如果我們要讓他發出聲音，可以直接在Dog寫一個method bark()。但如果針對interface設計，則我們會在Animal加入makeSound，於Dog繼承後在makeSound中發出bark。

>承設計Duck，我們可以設計出FlyBehavior這個interface，對此就可以分別implement出FlyWithWings, FlyNoWay兩個類。而我們的abstract class Duck就可以用has-a的概念加入一個FlyBehavior的變量，而我們針對行為建立一個method preformanceFly，call這個FlyBehaivor的變量委託這個class進行fly。往後需要建立不同的duck的時候，就可以在繼承Duck時，給予相對應的FlyBehavior。甚至可以加入setter，中途變換FlyBehavior，增加彈性。

* class之間的關係可以有三種: is-a, has-a, implements
    * 上述的例子中，每個鴨子都"有"一個FlyBehavior，也就是將飛行行為委託給這個class處理
    * 將兩個類結合一起使用就是"composition"，相較於"inherit"更具彈性
*  **設計原則:多用組合，少用繼承**
*  使用設計模式的共通詞彙可以提升討論效率、維持在高層次而不瑣碎。如"我們使用策略模式實現Duck的各種行為"，也就表示Duck的各種行為被封裝進一組class中，可以輕易被擴充改變
*  知道抽象、封裝、繼承、多態並不會讓人馬上變成好的OOP設計者，設計者更關心是建立彈性的設計，高維護性，可以應變

## Chapter2: 觀察者模式 Observer pattern
定義了object之間的一對多依賴關係，當一個object改變狀態，他的所有依賴者都會收到通知並自動更新

* **設計原則: 為了交互物件之間的鬆耦合設計而努力**
    * 有彈性能應變的OO系統是因為物件之前的低互相依賴關係
* 書中首先提出的情境是一個氣象觀測站，在收到資料更新後推送給相關的顯示器。直覺的作法是在觀測站資料更新的時侯call顯示器的update。但這麼做在幽需要更多顯示器時就要更改觀測站本身程式。
* 觀察者模式的概念就是將上述需求切分為subject與oberser。可以想像成報社與訂閱者，需要報紙的訂閱者先向報社訂閱，報社在每次有新報紙時會送給訂閱者。

```java
public interface Subject {
    public void registerObserver(Observer o);
    public void removeObserver(Observer o);
    public void notifyObservers();
}

public interface Observer {
    public void update(...);
}
```

* 這兩個物件會是鬆耦合，可以互動，但毋須知道對方細節。
* java 存在內建的觀察者模式，差別在於Observable不是interface而是class來繼承使用
```java
import java.util.Observable;
import java.util.Observer;

public class MySubject extends Observable {
    //Obserable提供之方法
    addObserver()
    deleteObserver()
    notifyObserver()
    setChanged()
}

public class MyObserver implements Observer {
    // Observer需要實做的方法
    update()
}
```
* observer pattern被廣泛應用在GUI框架當中，如按鈕行為

## chapter3: decorator pattern 裝飾者模式
動態將責任附加到物件上。若要擴展功能，decorator提供了比繼承更有彈性的替代方案。

* 本書以咖啡廳作為例子。一家咖啡廳販賣的品項眾多，若採用傳統的繼承，class的數量會太龐大，而且base class加入的功能並不適用所有子類別
* **設計原則: class應該對擴展開放，對修改關閉 (開放-關閉原則)**
    * 選擇擴展的部分要小心，如果每個地方都採用，會讓設計太過複雜難以理解
* 裝飾者模式採用的方法是以飲料為主體，並且在運作時以配料做decorate。如需要奶泡時就以Whip去裝飾他，而最後call cost()時利用依賴委託將配料的價格加上
```java!
// 書中以飲料舉例，建立了一個abstract class CondimentDecorator，配料以此繼承後實作。注意: CondimentDecorator也必須繼承自最上層的abstract class Beverage，不然就不能達到decorator可以層層wrap的特點
// 在getDescription() 與 cost() 的時候，會delegate給上一個被wrap的物件運作，並在自己的class中"加料"後回傳
public class Mocha extends CondimentDecorator {
    Beverage beverage;
    
    public Mocha(Beverage beverage) {
        this.beverage = beverage;
    }
    
    public String getDescription() {
        return beverage.getDescription() + ", Mocha";
    }
    
    public double cost() {
        return .20 + beverage.cost();
    }
}
```
* 我們的設計應該要允許行為可以被擴展，而不用修改既有代碼
* 實際應用上，一個很好的例子是 `java.io`。在最基本的stream中，FIleInputStream提供了基本的字節讀取功能，而裝飾器BufferedInputStream則加入緩衝功能增加效能，裝飾器LineNumberInputStream則加上了計算行數的功能。上述的裝飾器都是繼承了一個抽象的decorator FilterInputStream。

## Chapter4: Factory Method Pattern 工廠模式
工廠模式定義了一個創建物件的接口，但由子類決定要創建哪個物件的實體。工廠把類的實體化推遲到子類。以此來對物件的建構進行封裝。

* 簡單工廠與工廠模式不同，雖然能夠對物件的創建封裝，但不具備工廠方法可以變更正在創建產品的彈性
```java!
abstract class PizzaStore {
    // 這部分為抽象方法，由子類實體進行定義
    abstract Pizza createPizza();
    protected abstract Pizza orderPizza() {
        // 客戶僅需統一調用orderPizza()，不用管是那個實際子類
        ...
    }
} 

public class NYStylePizzaStore extends PizzaStore {
    // createPizza由顧客到了哪家店才決定，但仍採用原本的orderPizza()
    public Pizza createPizza(type) {
        if (type.equals("cheese"))
            pizza = new NYStyleCheesePizza();
        ...
        return pizza;
    }    
}

```
* **設計原則: 要依賴抽象，不要依賴實體類 (依賴反轉)**
    * 變量不可持有具體類的引用，可以透過工廠來避免這個做法
    * 不要讓類衍生自具體類，而是自一個抽象(interface or abstract class)
    * 不要覆蓋基類中已實現的方法，要讓它由所有子類共享

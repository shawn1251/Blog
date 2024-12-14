---
title: "Head First Design Pattern Note"
date: 2024-12-13T23:36:18-0800
draft: false
description: ""
type: "post"
categories: []
tags: []
---
## Chapter 1: Strategy Pattern
The Strategy Pattern defines a family of algorithms, encapsulates each one, and makes them interchangeable. This pattern allows the variation of algorithms to be independent of the clients that use them.

* The introduction uses the scenario of designing a duck. Since Joe wanted to add the ability to "fly" to the duck, he added this to the superclass, which also caused non-flying ducks, like rubber ducks, to have the ability to fly.
* Even with inheritance, overriding in subclasses can be insufficient due to the numerous types of subclasses. The book gives an example where among ducks that cannot fly, the rubber duck quacks, while the decoy duck does not quack.
* If an interface is used, it can lead to code that cannot be reused.
* A constant truth in software development is "change." No matter how perfect the initial design is, it will need to change after some time.
* **Design Principle: Identify parts of the application that may need to change and encapsulate them independently, avoiding mixing them with code that does not need to change.**
* **Design Principle: Design for interfaces, not for implementations.**
    * This means we should design around abstract classes or interfaces. For example, if we have an abstract class called Animal, with Dog inheriting from it, we can create a method `bark()` directly in Dog to make it sound. However, if we design for an interface, we would add `makeSound` to Animal, and then in Dog, we would implement `makeSound` to produce a bark.

> By designing Duck, we can create an interface called FlyBehavior, which can be implemented by two classes: FlyWithWings and FlyNoWay. Our abstract class Duck can then have a variable of type FlyBehavior, and we can create a method `performFly` that delegates the flying behavior to this class. When we need to create different types of ducks, we can provide the corresponding FlyBehavior when inheriting Duck. We can even add a setter to change the FlyBehavior mid-way, increasing flexibility.

* There are three types of relationships between classes: is-a, has-a, and implements.
    * In the example above, each duck "has" a FlyBehavior, meaning the flying behavior is delegated to this class.
    * Combining two classes for use is called "composition," which is more flexible compared to "inheritance."
* **Design Principle: Favor composition over inheritance.**
* Using common terminology in design patterns can enhance discussion efficiency and maintain a higher-level perspective without getting bogged down in details. For example, saying "we use the strategy pattern to implement various behaviors of Duck" indicates that the various behaviors of Duck are encapsulated in a set of classes that can be easily extended or modified.
* Knowing abstraction, encapsulation, inheritance, and polymorphism does not immediately make one a good OOP designer; what designers care about more is creating flexible designs that are highly maintainable and adaptable.

## Chapter 2: Observer Pattern
The Observer Pattern defines a one-to-many dependency between objects, so that when one object changes state, all its dependents are notified and updated automatically.

* **Design Principle: Strive for loose coupling in the design of interacting objects.**
    * A flexible OO system is characterized by low interdependence between objects.
* The scenario presented in the book is a weather observation station that pushes updates to relevant displays upon receiving new data. The intuitive approach would be to call the display's update method when the observation station's data is updated. However, this would require modifying the observation station's code whenever more displays are needed.
* The concept of the Observer Pattern is to split the above requirement into a subject and an observer. You can think of it as a newspaper agency and its subscribers; subscribers need to subscribe to the agency, and the agency will send new newspapers to subscribers whenever they are available.

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
* These two objects will be loosely coupled, allowing interaction without needing to know each other's details.
* Java has a built-in observer pattern, where the difference is that Observable is a class rather than an interface.
```java
import java.util.Observable;
import java.util.Observer;

public class MySubject extends Observable {
    // Methods provided by Observable
    addObserver()
    deleteObserver()
    notifyObserver()
    setChanged()
}

public class MyObserver implements Observer {
    // Methods that Observer needs to implement
    update()
}
```
*　The observer pattern is widely used in GUI frameworks, such as button actions.
## Chapter 3: Decorator Pattern
The Decorator Pattern dynamically adds responsibilities to objects. If you want to extend functionality, decorators provide a more flexible alternative than inheritance.

* The book uses a café as an example. A café sells a variety of items, and if traditional
inheritance is used, the number of classes would become too large, and the functionality added to the base class would not be applicable to all subclasses.
* **Design Principle: Classes should be open for extension but closed for modification (Open-Closed Principle).**
    * Care must be taken when choosing what to extend; if everything is extended, the design can become overly complex and difficult to understand.
* The Decorator Pattern operates by using beverages as the main subject and decorating them with ingredients during operation. For example, if whipped cream is needed, it can be used to decorate the beverage, and when calling `cost()`, the prices of the ingredients are added through delegation.
```java
// The book uses beverages as an example, creating an abstract class CondimentDecorator, which is then implemented by the ingredients. Note: CondimentDecorator must also inherit from the top-level abstract class Beverage; otherwise, it cannot achieve the characteristic of decorators being able to wrap around each other.
// In `getDescription()` and `cost()`, it delegates to the previously wrapped object and returns the result after adding the ingredient in its own class.
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
* Our design should allow behaviors to be extended without modifying existing code.
* A good practical example is java.io. In the basic stream, FileInputStream provides basic byte reading functionality while the decorator `BufferedInputStream` adds buffering functionality to improve performance, and the decorator `LineNumberInputStream` adds the ability to count lines. All of these decorators inherit from an abstract decorator called `FilterInputStream`.

## Chapter 4: Factory Method Pattern
The Factory Method Pattern defines an interface for creating objects, but allows subclasses to decide which class to instantiate. The factory delays the instantiation of classes to subclasses, encapsulating the construction of objects.

* The Simple Factory differs from the Factory Method; while it can encapsulate object creation, it does not provide the flexibility of changing the product being created.

```java
abstract class PizzaStore {
    // This part is an abstract method defined by subclasses
    abstract Pizza createPizza();
    protected abstract Pizza orderPizza() {
        // Customers only need to call orderPizza(), without worrying about which specific subclass it is
        ...
    }
} 

public class NYStylePizzaStore extends PizzaStore {
    // createPizza is determined by which store the customer goes to, but still uses the original orderPizza()
    public Pizza createPizza(type) {
        if (type.equals("cheese"))
            pizza = new NYStyleCheesePizza();
        ...
        return pizza;
    }    
}
```
* Design Principle: Depend on abstractions, not on concrete classes (Dependency Inversion).
    * Variables should not hold references to concrete classes; this can be avoided through the factory.
    * Classes should not derive from concrete classes but from an abstraction (interface or abstract class).
    * Do not override methods that have already been implemented in the base class; allow them to be shared by all subclasses.

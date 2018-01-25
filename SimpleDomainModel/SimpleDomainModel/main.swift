//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  private func validMoney(_ currency: String) -> Bool {
    return (currency == "USD" || currency == "GBP" || currency == "EUR" ||
            currency == "CAN")
  }
    
  public func convert(_ to: String) -> Money {
    var newCurr : Money = Money(amount: self.amount, currency: self.currency)
    if validMoney(to) {
      if to == "USD" {
        switch self.currency {
        case "GBP":
          newCurr.amount = self.amount * 2
        case "EUR":
          newCurr.amount = Int(round(Double(self.amount) / 1.5))
        case "CAN":
          newCurr.amount = Int(round(Double(self.amount) / 1.25))
        default:
          newCurr.amount = self.amount
        }
      } else if to == "GBP" {
        switch self.currency {
        case "USD":
          newCurr.amount = Int(round(Double(self.amount / 2)))
        case "EUR":
          newCurr.amount = Int(round(Double(self.amount / 3)))
        case "CAN":
          newCurr.amount = Int(round(Double(self.amount) / 2.5))
        default:
          newCurr.amount = self.amount
        }
      } else if to == "EUR" {
        switch self.currency {
        case "USD":
          newCurr.amount = Int(round(Double(self.amount) * 1.5))
        case "GBP":
          newCurr.amount = Int(round(Double(self.amount / 3)))
        case "CAN":
          newCurr.amount = Int(round(Double(self.amount) * 1.2))
        default:
          newCurr.amount = self.amount
        }
      } else {
        switch self.currency {
        case "USD":
          newCurr.amount = Int(round(Double(self.amount) * 1.25))
        case "GBP":
          newCurr.amount = Int(round(Double(self.amount) * 2.5))
        case "EUR":
          newCurr.amount = Int(round(Double(self.amount) * 0.83))
        default:
          newCurr.amount = self.amount
        }
      }
      newCurr.currency = to
    }
    return newCurr
  }
  
  public func add(_ to: Money) -> Money {
    let convertToGiven = self.convert(to.currency)
    let newAmount = convertToGiven.amount + to.amount
    return Money(amount: newAmount, currency: to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    let convertToGiven = self.convert(from.currency)
    let newAmount = from.amount - convertToGiven.amount
    return Money(amount: newAmount, currency: from.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type {
    case .Hourly(let wage):
      return Int(round(wage * Double(hours)))
    case .Salary(let yearly):
      return yearly
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type {
    case .Hourly(let wage):
      self.type = JobType.Hourly(wage + amt)
    case .Salary(let salary):
      self.type = JobType.Salary(salary + Int(round(amt)))
    }
  }
}
/*
////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { }
    set(value) {
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { }
    set(value) {
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}

*/




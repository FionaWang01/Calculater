//
//  CalculatorBrain .swift
//  Calculater
//
//  Created by babykang on 5/30/16.
//  Copyright © 2016 wangkang. All rights reserved.
//

import Foundation

class CalcultorBrain {
    
    enum OP {
        case Operate (Double)
        case UnaryOperation (String, (Double)->Double)
        case BinaryObration (String, (Double, Double) -> Double)
        var description : String{
            get {
                switch self {
                case .Operate(let operate):
                    return "\(operate)"
                case .UnaryOperation(let string, _):
                    return string
                case .BinaryObration(let string , _):
                    return string
            
                }
            }
        }
        
        
            
       
    }
    
    // 全部的数组的栈
    var opStacks = [OP]()
    
    //已知运算符号的栈
    var knowOps = [String: OP]()
    
    init(){
        
        knowOps["*"] = OP.BinaryObration("*", {$0 * $1})
        knowOps["-"] = OP.BinaryObration("-", {$1 - $0})
        knowOps["+"] = OP.BinaryObration("+", {$0 + $1})
        knowOps["/"] = OP.BinaryObration("/", {$1 / $0})
        knowOps["√"] = OP.UnaryOperation("√", sqrt)
        
    }
    
    func pushOperate(operate: Double)-> Double?{
        opStacks.append(OP.Operate(operate))
        return evalute()
    }
    
    func performOperate(symbel:String)->Double?{
        if let operate = knowOps[symbel]{
            opStacks.append(operate)
        }
        return evalute()
    }
    
    func evalute(ops: [OP])-> (result:Double?,remainOps:[OP]){
        
        if !opStacks.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operate(let operand): return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvalution = evalute(remainingOps)
                if let operand = operandEvalution.result{
                    return (operation(operand), operandEvalution.remainOps)
                }
            case .BinaryObration(_, let operation):
                let operand1Evalution = evalute(remainingOps)
                if let operande1 = operand1Evalution.result{
                    let operand2evalution = evalute(operand1Evalution.remainOps)
                    if let operande2 = operand2evalution.result{
                        return (operation(operande1,operande2), operand2evalution.remainOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evalute()-> Double?{
        
        let (result, remainder) = evalute(opStacks)
        return result
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

//
//  main.swift
//  Chapter8Swift
//
//  Created by Ethan Lillie on 9/29/14.
//  Copyright (c) 2014 Algorithms. All rights reserved.
//

import Foundation

println("Hello, World!")

class PassableArray<T> {
    var array = [T]()
    init (array inArray: [T]) {
        array = inArray
    }
    func exchange(i:Int, j:Int)
    {
        var dummy = array[i]
        array[i] = array[j]
        array[j] = dummy
    }
}

class LLNode<T> {
    var key: T? = nil
    var next: LLNode? = nil
    var previous: LLNode? = nil
}

public class LinkedList<T: Equatable> {
    //create a new LLNode instance
    private var head: LLNode<T> = LLNode<T>()
    private var tail: LLNode<T> = LLNode<T>()
    
    //append a new item to a linked list
    func addLink(key: T) {
        
        //establish the head node
        if (head.key == nil) {
            head.key = key
            return
        }
        //keep the tail the tail.
        tail.key = key
        
        //establish the iteration variables 
        var current: LLNode? = head
        while (current != nil) {
            if (current?.next != nil) {
                var childToUse: LLNode = LLNode<T>()
                childToUse.key = key
                childToUse.previous = current
                current!.next = childToUse
                break
            }
            
            current = current?.next
        } //end while
    }
    
    //remove a link at a specific index
    func removeLinkAtIndex(index: Int) {
        var current: LLNode<T>? = head
        var trailer: LLNode<T>? = nil
        var listIndex: Int = 0
        //determine if the removal is at the head
        if (index == 0) {
            current = current?.next
            head = current!
            return
        }
        //iterate through the remaining items
        while (current != nil) {
            if (listIndex == index) { //redirect the trailer and next pointers
                trailer!.next = current?.next
                if current?.next == nil
                {
                    tail = trailer!
                }
                current = nil
                break
            }
            
            //update the assignments
            trailer = current
            current = current?.next
            listIndex++
        } //end while
    } //end function
}

//sort of works, but has some bugs
func bucketSort(A:PassableArray<Float>) -> (LinkedList<Float>)
{
    var B = PassableArray<LinkedList<Float>>(array: [])
    var n = A.array.count
    for i in 0..<n {
        let ll = LinkedList<Float>()
        B.array.append(ll)
    }
    for i in 0..<n {
        B.array[Int(Float(n)*A.array[i])].addLink(A.array[i])
    }
    for i in 0..<n {
        var sorted = false
        if B.array[i].head.next == nil {
            sorted = true
        }
        
        var node = LLNode<Float>()
        node = B.array[i].head
        
        while sorted == false {
            var next = node.next
            if node.key > next?.key {
                let temp = next?.next
                next?.next = node
                next?.previous = node.previous
                node.previous = next
                node.next = temp
                node = B.array[i].head
                
                
            } else if next == nil {
                sorted == true
            } else {
                node = next!
            }
        }
    }
    let L = LinkedList<Float>()
    for i in 0..<n {
    
        if B.array[i].head.key != nil {
            
            var node = B.array[i].head
            L.addLink(node.key!)
            
            while node.next != nil {
                node = node.next!
                L.addLink(node.key!)
            }
        }
    }
    
    var node = L.head
    while node.key != nil
    {
        println(node.key)
        
        if node.next != nil{
            node = node.next!
        } else {
            node.key = nil
        }
    }
    
    return L
}

func countingSort(A: PassableArray<Int>, B: PassableArray<Int>, length k: Int)
{
    var C = PassableArray<Int>(array:[])
    for i in 0..<k {
        C.array.append(0)
    }
    for j in 0..<A.array.count {
        C.array[A.array[j]]++
    }
    println(C.array)
    for i in 1..<k {
        C.array[i] += C.array[i-1]
    }
    println(C.array)
    for j in 0..<A.array.count {
        var i = A.array.count - j - 1
        println(i)
        B.array[C.array[A.array[i]]-1] = A.array[i]
        C.array[A.array[i]] = C.array[A.array[i]] - 1
    }
}

func radixCountingSort(A: PassableArray<Int>, B: PassableArray<Int>, k: Int, d: Int)
{
    var C = PassableArray<Int>(array:[])
    for i in 0..<k {
        C.array.append(0)
        B.array.append(0)
    }
    for j in 0..<A.array.count {
        C.array[(A.array[j] % Int(pow(10,Float(d))))/Int(pow(10,Float(d-1)))]++
    }
    println(C.array)
    for i in 1..<k {
        C.array[i] += C.array[i-1]
    }
    println(C.array)
    for j in 0..<A.array.count {
        var i = A.array.count - j - 1
//        println(A.array)
//        println(B.array)
//        println(i)
//        println(C.array)
//        println((A.array[i] % Int(pow(10,Float(d))))/Int(pow(10,Float(d-1))))
        B.array[C.array[(A.array[i] % Int(pow(10,Float(d))))/Int(pow(10,Float(d-1)))]-1] = A.array[i]
        C.array[(A.array[i] % Int(pow(10,Float(d))))/Int(pow(10,Float(d-1)))] = C.array[(A.array[i] % Int(pow(10,Float(d))))/Int(pow(10,Float(d-1)))] - 1
    }
}


func radixSort(A: PassableArray<Int>, d: Int) -> (PassableArray<Int>) {
    var B = A
    for i in 1...d {
        //        for j in 0..<B.array.count {
//            B.array[j] = (B.array[j] % Int(pow(10,Float(d))))/Int(pow(10,Float(d-1)))
//        }
        var C = PassableArray<Int>(array: [])
        //println(B.array)
        radixCountingSort(B, C, 10, i)
        B = C
        //println("d:\(i)")
        //println(B.array)
    }
return B
}

//var A = PassableArray(array: [0,2,5,1,7,5,6,6,3,4,2,2,4,3,3,4])
//var B = PassableArray(array: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
//countingSort(A, B, 8)
//println(B.array)
//
var C = PassableArray<Float>(array:[])

for i in 0..<100{
    C.array.append(Float(arc4random())/Float(UINT32_MAX))
    //println(C.array[i])
}
//println(C.array)


var A = bucketSort(C)

var node = A.head
while node.key != nil
{
    println(node.key)
    
    if node.next != nil{
        node = node.next!
    } else {
        node.key = nil
    }
}
//println(C.array

var gg = LinkedList<Int>()
gg.addLink(3)
gg.addLink(6)
println(gg.head.key)
println(gg.head.next?.key)

//let num = 13
//var mod = num % 100
//println(mod/10)
//
//println(Int(pow(Float(num), 2)))
//var j = 1
//println((3434 % Int(pow(10,Float(j))))/Int(pow(10,Float(j-1))))
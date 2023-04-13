//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/13.
//

import Combine
import CombineExt
import Foundation

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    
    public typealias Output = Element
    public typealias Failure = Never
    
    public var value: Element {
        currenctValueRelay.value
    }
    
    fileprivate let currenctValueRelay: CurrentValueRelay<Output>
    
    fileprivate init(_ initValue: Element) {
        currenctValueRelay = CurrentValueRelay(initValue)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
        currenctValueRelay.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    
    typealias Output = Element
    typealias Failure = Never
    
    public override init(_ initValue: Element) {
        super.init(initValue)
    }
    
    public func send(_ value: Element) {
        currenctValueRelay.accept(value)
    }
}

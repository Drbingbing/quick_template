//
//  MutableObservable.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/23.
//

import Foundation

class ImmutableObservable<T> {
    
    typealias Observer = (ObserverEvent<T>) -> Void
    
    private var observers: [Int: (Observer, DispatchQueue?)] = [:]
    private var uniqueID = (0...).makeIterator()
    
    fileprivate let lock = NSRecursiveLock()
    
    fileprivate var _value: T {
        didSet {
            let newValue = _value
            observers.values.forEach { observer, queue in
                notify(observer: observer, queue: queue, value: newValue, oldValue: oldValue)
            }
        }
    }
    private var _onDispose: () -> Void
    
    var wrappedValue: T {
        return _value
    }
    
    init(_ value: T, onDispose: @escaping () -> Void = {}) {
        _value = value
        _onDispose = onDispose
    }
    
    /// subscribe at main queue
    func sink(_ onNext: @escaping (T) -> Void) -> Disposable {
        return subscribe { event in
            onNext(event.value)
        }
    }
    
    func subscribe(_ queue: DispatchQueue? = DispatchQueue.main, _ observer: @escaping Observer) -> Disposable {
        lock.lock()
        defer { lock.unlock() }
        
        let id = uniqueID.next()!
        
        observers[id] = (observer, queue)
        
        return Disposable { [weak self] in
            self?.observers[id] = nil
            self?._onDispose()
        }
    }
    
    private func notify(observer: @escaping Observer, queue: DispatchQueue? = nil, value: T, oldValue: T) {
        if let queue {
            queue.async {
                observer(ObserverEvent(oldValue: oldValue, value: value))
            }
        } else {
            observer(ObserverEvent(oldValue: oldValue, value: value))
        }
    }
}

class MutableObserver<T>: ImmutableObservable<T> {
    
    override var wrappedValue: T {
        get { return _value }
        set {
            lock.lock()
            defer { lock.unlock() }
            _value = newValue
        }
    }
}

struct ObserverEvent<Value> {
    
    let oldValue: Value
    let value: Value
    
    init(oldValue: Value, value: Value) {
        self.oldValue = oldValue
        self.value = value
    }
}

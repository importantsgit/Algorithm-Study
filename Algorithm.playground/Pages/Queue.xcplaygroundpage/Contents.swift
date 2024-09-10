import Foundation

struct Queue<T> {
    var elements: [T] = []
    var index = 0
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard index < elements.count
        else { return nil }
        
        let element = elements[index]
        index += 1
        
        if index > 2 {
            elements.removeFirst(3)
            index = 0
        }
        
        return element
    }
}


// MARK: - 개선된 Queue (연결 리스트 활용)
// 값 타입은 자기 자신을 포함하는 저장 프로퍼티를 가질 수 없음
// 이는 컴파일러가 타입의 크기를 결정할 수 없게 만들기 때문
// struct -> class
class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct QueueList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private(set) var count = 0
    
    var isEmpty: Bool {
        head == nil
    }
    
    mutating func enqueue(_ value: T) {
        let newNode = Node(value: value)
        
        if isEmpty {
            head = newNode
            tail = newNode
        }
        else {
            tail?.next = newNode
            tail = newNode
        }
        
        count += 1
    }
    
    mutating func dequeue() -> T? {
        guard let firstNode = head
        else { return nil }
        
        head = firstNode.next
        
        if head == nil {
            tail = nil
        }
        
        count -= 1
        
        return firstNode.value
    }
    
}

// MARK: 링 버퍼 Queue

struct RingBufferQueue<T> {
    var head: Int = 0
    var tail: Int = 0
    var buffer: [T?]
    var size: Int = 0
    
    var count: Int {
        size
    }
    
    var isEmpty: Bool {
        size == 0
    }
    
    var isFull: Bool {
        size == buffer.count
    }
    
    init(bufferSize: Int) {
        self.buffer = [T?](repeating: nil, count: bufferSize)
    }
    
    mutating func enqueue(_ value: T) {
        if isFull == true {
            buffer.append(nil)
        }
        
        buffer[tail] = value
        tail = (tail + 1) % buffer.count
        
        size += 1
    }
    
    mutating func dequeue() -> T? {
        guard isEmpty == false
        else { return nil }
        
        let element = buffer[head]
        head = (head + 1) % buffer.count
        
        size -= 1
        
        return element
    }
    
}


print(progressTime {
    // 36.737009048461914
    var queue: Queue<Int> = Queue()
    for i in 0..<5000 {
        print(i)
        queue.enqueue(i)
    }
    
    for i in 0..<5000 {
        print(queue.dequeue())
    }
})

print(progressTime {
    // 2.6738619804382324
    var queueList: QueueList<Int> = QueueList()
    for i in 0..<5000 {
        print(i)
        queueList.enqueue(i)
    }
    
    for i in 0..<5000 {
        print(queueList.dequeue())
    }
})

print(progressTime {
    // buffer ==  5000 > 36.46656692028046 / buffer == 1 > 38.17157995700836
    var ringBufferQueue: RingBufferQueue<Int> = RingBufferQueue(bufferSize: 1)
    for i in 0..<5000 {
        print(i)
        ringBufferQueue.enqueue(i)
    }
    
    for i in 0..<5000 {
        print(ringBufferQueue.dequeue())
    }
})


public func progressTime(_ measureProcess: () -> Void) -> TimeInterval {
    let start = CFAbsoluteTimeGetCurrent()
    print("start Measure")
    measureProcess()
    let duration = CFAbsoluteTimeGetCurrent() - start
    print("end Measure")
    return duration
}

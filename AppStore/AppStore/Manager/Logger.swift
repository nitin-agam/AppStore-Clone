//
//  Logger.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit
import CocoaLumberjackSwift

var Log: Logger {
    return Logger.shared
}

enum LogLevel {
    case verbose
    case info
    case warn
    case error
    case debug
}

class FileLogFormatter: NSObject, DDLogFormatter {
    
    static let shared = FileLogFormatter()
    
    func format(message logMessage: DDLogMessage) -> String? {
        let dateString = logMessage.timestamp.toString()
        return "\(dateString) Q:\(logMessage.queueLabel) ---> \(logMessage.message)"
    }
}


class LogFormatter: NSObject, DDLogFormatter {
    
    static let shared = LogFormatter()
    
    func format(message logMessage: DDLogMessage) -> String? {
        let dateString = logMessage.timestamp.toString()
        return "\(dateString) Q:\(logMessage.queueLabel) ---> \(logMessage.message)"
    }
}

class Logger: NSObject {
    
    static let shared = Logger()
    private static let logEnabled = true
    private static let dateFormat = "dd-MM-yyyy hh:mm:ss"
    
    let fileLogger: DDFileLogger = {
        let logger = DDFileLogger()
        logger.rollingFrequency = 60 * 60 * 24 // 24 hours
        logger.logFileManager.maximumNumberOfLogFiles = 7
        logger.logFormatter = FileLogFormatter.shared
        logger.maximumFileSize = 1024 * 1024 // 1 MB
        return logger
    }()
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    override init() {
        super.init()
        
        // Add OS Logger
        DDOSLogger.sharedInstance.logFormatter = LogFormatter()
        DDLog.add(DDOSLogger.sharedInstance)
        
        /*
         These tie into the log level just as you would expect
         If you set the log level to DDLogLevelError, then you will only see Error statements.
         If you set the log level to DDLogLevelWarn, then you will only see Error and Warn statements.
         If you set the log level to DDLogLevelInfo, you'll see Error, Warn and Info statements.
         If you set the log level to DDLogLevelDebug, you'll see Error, Warn, Info and Debug statements.
         If you set the log level to DDLogLevelVerbose, you'll see all DDLog statements.
         If you set the log level to DDLogLevelOff, you won't see any DDLog statements.
         ref: https://github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentation/GettingStarted.md
         */
        DDLog.add(fileLogger, with: .info)
        
        #if DEBUG
        asyncLoggingEnabled = false
        #endif
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    func log(_ object: Any, type: LogLevel = .info) {
        if Logger.logEnabled {
            let loggedMessage = "[\(type)] \(object)"
            switch type {
            case .info: DDLogInfo(loggedMessage)
            case .error: DDLogError(loggedMessage)
            case .verbose: DDLogVerbose(loggedMessage)
            case .warn: DDLogWarn(loggedMessage)
            case .debug: DDLogDebug(loggedMessage)
            }
        }
    }
}

extension Logger {
    
    func logStartRequest(_ request: URLRequest) {
        let body = request.httpBody.map { String(decoding: $0, as: UTF8.self) } ?? "Nil"
        let requestUrl = request.url?.absoluteString ?? "Nil"
        
        var headerPrint = ""
        #if DEBUG
        headerPrint = "⚡️⚡️⚡️⚡️ HEADERS -> \(String(describing: request.allHTTPHeaderFields))"
        #endif
        
        let networkRequest = """
            ⚡️⚡️⚡️⚡️ REQUEST ⚡️⚡️⚡️⚡️
            ⚡️⚡️⚡️⚡️ URL -> \(requestUrl)
            ⚡️⚡️⚡️⚡️ METHOD -> \(String(describing: request.httpMethod))
            ⚡️⚡️⚡️⚡️ BODY -> \(body)
            \(headerPrint)
            ⚡️⚡️⚡️⚡️ ---------------------- ⚡️⚡️⚡️⚡️
        """
        Log.log(networkRequest, type: .info)
    }
    
    func logEndRequest(_ response: URLResponse?, data: Data?, error: Error?) {
        var statusCode = 0
        if let httpUrlResponse = response as? HTTPURLResponse {
            statusCode = httpUrlResponse.statusCode
        }
        
        let networkResponse = """
        ⚡️⚡️⚡️⚡️ RESPONSE ⚡️⚡️⚡️⚡️
        ⚡️⚡️⚡️⚡️ URL -> \(response?.url?.absoluteString ?? "NIL")
        ⚡️⚡️⚡️⚡️ STATUS CODE -> \(statusCode)
        ⚡️⚡️⚡️⚡️ DATA DICTIONARY -> \(data?.dictionary ?? [:])
        ⚡️⚡️⚡️⚡️ DATA -> \(data)
        ⚡️⚡️⚡️⚡️ ERROR -> \(String(describing: error))
        ⚡️⚡️⚡️⚡️ ---------------------- ⚡️⚡️⚡️⚡️
    """
        Log.log(networkResponse, type: .info)
    }
}

extension Date {
    
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}


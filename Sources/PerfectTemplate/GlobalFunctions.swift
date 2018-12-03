//
//  GlobalFunctions.swift
//  PerfectTemplate
//
//  Created by NTQ on 12/3/18.
//

import Foundation
import PerfectHTTP

public func GFResponse(_ response: HTTPResponse, body: Any?) {

    var params = [String: Any]()

    // Respond with a simple message.
    response.setHeader(.contentType, value: "application/json")

    let data: [UInt8] = {
        do {
            params["message"] = "OK"
            params["body"] = body
            return [UInt8](try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted))
        }
        catch {
            params["body"] = error.localizedDescription
            params["message"] = "NOK"
            return [UInt8]((try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)) ?? Data(capacity: 0))
        }
    }()

    response.appendBody(bytes: data)

    // Ensure that response.completed() is called when your processing is done.
    response.completed()
}

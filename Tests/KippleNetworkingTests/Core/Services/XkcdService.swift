// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleNetworking

public final class XkcdService {
    // MARK: Constants

    public static let baseURL = "https://xkcd.com"

    // MARK: Properties

    private let dispatcher: NetworkRequestDispatching

    // MARK: Methods

    public init(dispatcher: NetworkRequestDispatching) {
        self.dispatcher = dispatcher
    }

    // MARK: Requests

    func getStrip(id: Int) {}

    func getLatest() {}
}

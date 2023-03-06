// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.

import { createConsumer } from "@rails/actioncable"
    createConsumer(getWebSocketURL)
    function getWebSocketURL(){
        return 'http://ws.localhost:4000/cable'
    }

export default createConsumer()

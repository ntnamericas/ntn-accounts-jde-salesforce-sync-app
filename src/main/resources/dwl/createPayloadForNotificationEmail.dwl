%dw 2.0
output application/json
var parsedPayload = payload map (item) -> read(item, "application/json")

var finalPayload = parsedPayload filter ((item, index) -> item != null )
---

finalPayload map (item) -> { 
    "ID": item.id default "N/A",
    "Message": item.message default "",
    "ErrorMessage": item."Error Message" default "",
    "StatusCode": item."Status Code" default "",
    "FailedPayload" : flatten(item.failedPayload)
}

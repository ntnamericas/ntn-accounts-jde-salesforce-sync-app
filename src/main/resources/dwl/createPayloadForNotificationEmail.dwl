%dw 2.0
output application/json
var parsedPayload = payload map (item) -> read(item, "application/json")

var finalPayload = parsedPayload filter ((item, index) -> item != null )
---

finalPayload map (item) -> { 
    "ID": item.Id[0] default "N/A",
    "Message": item.Message[0] default "",
    "ErrorMessage": item."Error Message"[0] default "",
    "StatusCode": item."Status Code"[0] default "",
    "FailedPayload" : flatten(item.failedPayload)[0]
}

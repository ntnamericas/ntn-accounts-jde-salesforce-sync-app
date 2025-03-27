%dw 2.0
output application/csv header=true
var parsedPayload = payload flatMap (item) -> read(item, "application/json")
---

parsedPayload map (item) -> { 
    "ID": item.id default "N/A",
    "Message": item.message default "",
    "ErrorMessage": item."error message" default "",
    "StatusCode": item."Status Code" default ""
}
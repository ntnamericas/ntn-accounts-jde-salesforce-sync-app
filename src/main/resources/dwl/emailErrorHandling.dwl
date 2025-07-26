%dw 2.0
output application/json
---
{
    "Error_Type": error.errorType.asString,
    "Description" : error.description ,
    "Detailed Description": error.detailedDescription
}
 
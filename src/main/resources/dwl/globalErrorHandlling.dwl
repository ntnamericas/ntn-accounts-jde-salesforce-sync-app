%dw 2.0
output application/java
---
{
	"Exception": error.exception.detailMessage ,
	"Description" : error.description ,
	"ErrorType" : error.errorType.asString
}
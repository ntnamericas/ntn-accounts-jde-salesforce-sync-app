%dw 2.0
output application/java
---
{
	"Exception": error.description ,
	"Description" : error.detailedDescription ,
	"ErrorType" : error.errorType
}
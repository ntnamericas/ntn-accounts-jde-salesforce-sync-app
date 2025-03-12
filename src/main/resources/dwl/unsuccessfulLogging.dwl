%dw 2.0
output application/json
---
{
	"data" : vars.sfData ,
    "error": payload.unsuccessful.errorMessage,
    "id": payload.unsuccessful.id
}
 
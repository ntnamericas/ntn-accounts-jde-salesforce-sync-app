// */%dw 2.0
//output application/json
//---
//{
//	"data" : vars.sfData.items[0].exception.message ,
//    "error": payload.unsuccessful.errorMessage,
//    "id": payload.unsuccessful.id
//}

%dw 2.0
output application/json
---
{
	"data" : vars.sfData.items[0].exception.message ,
    "error": payload.unsuccessful.errorMessage,
    "id": payload.unsuccessful.id
}
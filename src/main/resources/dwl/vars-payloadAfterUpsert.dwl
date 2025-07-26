%dw 2.0
output application/json
---
{
    successful: payload.items filter $.successful == true map {
        id: $.id,
        payload: $.payload
    },
    unsuccessful: payload.items filter $.successful == false map {
        id: $.id,
        errorMessage: $.message,
        errorDetails: $.payload.errors map {
            message: $.message,
            statusCode: $.statusCode,
            Error : $.payload
        }
    }
}
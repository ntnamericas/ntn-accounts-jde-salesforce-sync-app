%dw 2.0
output application/xml
skipNullOn="everywhere"

---
{
    "html":{
        "body":{
            "div" @(class:"total"):{
                "div" @(class:"header"):{
                    "h2":"Alert from Mulesoft"
                },
                "div" @(class:"content"):{
                    "p": "Hi,",
                    "p": "Greetings!!!",
					"p": "Error while processing, please take corrective action."
                },

                "div":{
                    "table" @(width:'40%', border:'1', cellspacing:'0'): {
							"tr":{
                                "th": "InterfaceName",
                                "td": p('app.name')
                            },
                          "tr":{
                                "th": "Error Type",
                                "td": error.errorType
                            },
                          "tr":{
                                "th": "Error Description",
                                "td":  error.description
                            }                        
				
                        }
                }
            }
        }
    }
}
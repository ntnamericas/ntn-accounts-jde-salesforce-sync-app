%dw 2.0
output application/csv header=true
---
(payload map ((item) -> 
    if (item is Binary) 
        read(item as String {encoding: "UTF-8"}, "application/json") 
    else if (item is String)
        read(item, "application/json") 
    else if (item is Object) 
        item 
    else 
        {error: "Unsupported type", item: item}
)) 
filter ((item) -> 
    item != null and item != {}
) 
map ((item) -> 
    {
        Error: (item.error[0] default "") as String,
        ID: (item.id[0] default "") as String,
        Data: 
            "---\n" ++ 
            (write(item.data[0] default {}, "application/json", {indent: true})) 
            // Pretty-print JSON data for readability
    }
)

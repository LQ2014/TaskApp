package com.cyancloud.web.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonGenerator;  
import org.codehaus.jackson.JsonProcessingException;  
import org.codehaus.jackson.map.JsonSerializer;  
import org.codehaus.jackson.map.SerializerProvider;  


public class DateJsonSerializer extends JsonSerializer<Date> {  
    @Override  
    public void serialize(Date value, JsonGenerator jsonGenerator, SerializerProvider provider)  throws IOException, JsonProcessingException {  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println(value);
        if (null != value) {
        	jsonGenerator.writeString(sdf.format(value));  
        } else {
        	jsonGenerator.writeString(" ");
        }
    }  
} 


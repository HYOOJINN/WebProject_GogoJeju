package servelt;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import vo.TourVO;

public class GetLocation {
   public TourVO getlocation(String address) {
      TourVO vo = new TourVO();
    try {
       
         String location = address;
         String addr = "https://dapi.kakao.com/v2/local/search/address.json";
         String apiKey = "KakaoAK 781cf5cd7f65fec92ff53341466ed450";

         location = URLEncoder.encode(location, "UTF-8");

         String query = "query=" + location;
         
         StringBuffer stringBuffer = new StringBuffer();
         stringBuffer.append(addr);
         stringBuffer.append("?");
         stringBuffer.append(query);
         
         System.out.println("stringBuffer.toString() "+ stringBuffer.toString());
         
         URL url = new URL(stringBuffer.toString());
         
         URLConnection conn = url.openConnection();
         
         conn.setRequestProperty("Authorization", apiKey);
         
         BufferedReader rd = null;
         
         rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
         StringBuffer docJson = new StringBuffer();
         
         String line;
         
         while((line=rd.readLine())!=null){
             docJson.append(line);
         }
         
         if(0<docJson.toString().length()){
             System.out.println("docJson    :"+docJson.toString());
             
         }
         
         rd.close();
         
         JSONParser jsonParse = new JSONParser();
         JSONObject jsonObj = (JSONObject) jsonParse.parse(docJson.toString());
   
         JSONArray jsonArray= (JSONArray) jsonObj.get("documents");
         
         JSONObject tempObj = (JSONObject) jsonArray.get(0);
             
         System.out.println("latitude : " + tempObj.get("y"));
         System.out.println("longitude : " + tempObj.get("x"));
         
         vo.setX((String)tempObj.get("x"));
         vo.setY((String)tempObj.get("y"));
     }catch(Exception e) {
         e.printStackTrace();
     }
    return vo;
   }
}
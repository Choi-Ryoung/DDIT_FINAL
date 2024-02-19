package kr.or.ddit.member.mypage.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
 
 
@Controller("user-data-controller")
@RequestMapping("/accounts")
public class AccountsDataController {
 
private Logger logger = LoggerFactory.getLogger(getClass());
 
/** Json 데이터 파싱을 위한 매퍼 정의  */ 
private static final ObjectMapper MAPPER = new ObjectMapper();
 
/**
  * 학교검색 (커리어넷 Open API 를 사용 )
  * 
  * 
  * 파라메터 gubun 학교구분 값 [필수]: 
  * <ul>
  *<li>초등학교 : elem_list</li>
  *<li>중학교 :midd_list</li>
  *<li>고등학교 : high_list</li>
  *<li>대학교 : univ_list</li>
  *<li>특수/각종기타학교 : seet_list</li>
  *<li>대안학교 : alte_list</li>
  * </ul>
  * 
  * @param gubun 학교구분
  * @param request
  * @param response
  * @return
  */
 
 @RequestMapping(value="/school/list.json",method={RequestMethod.POST} )
 @ResponseBody
 public ItemList findSchool(@RequestParam(value="gubun", defaultValue="elem_list" ) String gubun,
   @RequestParam(value="name", required = false ) String name,
   @RequestParam(value="region", required = false ) String region,
   @RequestParam(value="page", defaultValue="1" ) Integer page,
   @RequestParam(value="pageSize", defaultValue="15" ) Integer pageSize,
   HttpServletRequest request, HttpServletResponse response){
 
  ItemList items = new ItemList(Collections.EMPTY_LIST, 0);
  StringBuilder sb = new StringBuilder("http://www.career.go.kr/cnet/openapi/getOpenApi.json?apiKey=c7f6742318453eff99887fd4be4a7bdb&svcType=api&svcCode=SCHOOL&contentType=json");
  sb.append("&amp;gubun=").append(gubun);
  if( StringUtils.isNotEmpty(region)){
   sb.append("&amp;region=").append(region);
  }
 
  if( StringUtils.isNotEmpty(name)){
   sb.append("&amp;searchSchulNm=").append(name);
  }  
 
  sb.append("&amp;thisPage=").append(page);
  sb.append("&amp;perPage=").append(pageSize);
 
  try {
   URL url = new URL(sb.toString());
   URLConnection connection = url.openConnection();
   InputStream is = connection.getInputStream();
   JsonNode jn = MAPPER.readTree(is);
   JsonNode jn2 = jn.get("dataSearch").get("content");
   Iterator<JsonNode> iter = jn2.elements();
   List<School> list = new ArrayList<School>();
   while(iter.hasNext()){
    JsonNode jn3 = iter.next();
    if( items.getTotalCount() == 0 )
        items.setTotalCount(jn3.get("totalCount").asInt());    
    list.add(new School(
      jn3.get("seq").asInt(0),
      jn3.get("schoolName").textValue(),
      jn3.get("region").textValue(),
      jn3.get("adres").textValue()
      ));
   } 
 
   items.setItems(list);
 
  } catch (Exception e) {
   logger.error("CAREER API ERROR", e);
  }
  return items;
 }
 
}
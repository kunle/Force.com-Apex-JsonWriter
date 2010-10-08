/**
  * This class represents a json namevaluepair, can be used to write JSON members{"name":"value"}
  * For more infomation goto json.org
  * Authur: Kunle Adeniyi (kunle4@gmail.com)
  */
public class JSONNameValuePair {
	
	private String name;
	private String value;
	private List<JSONNameValuePair> nameValuePairMembers; //surrounded by {} with comma seperated
	private ArrayValue objectArray;
	
	private Boolean isBool = false; 
	private Boolean isString= false;  
	private Boolean isNumber= false; 
	private Boolean isMemberList= false; 
	private Boolean isArray = false;

	private String JSON_STRING = '"{0}":{1}';
	
	public JSONNameValuePair(){}
	public JSONNameValuePair(String name, String value){
		setName(name);
		setValue(value);
	}
	public JSONNameValuePair(String name, Boolean value){
		setName(name);
		setValue(value);
	}
	public JSONNameValuePair(String name, Integer value){
		setName(name);
		setValue(value);
	}
	public JSONNameValuePair(String name, Double value){
		setName(name);
		setValue(value);
	}
	public JSONNameValuePair(String name, Decimal value){
		setName(name);
		setValue(value);
	}
	public JSONNameValuePair(String name, List<JSONNameValuePair> value){
		setName(name);
		setValue(value);
	}
	public JSONNameValuePair(String name, ArrayValue value){
		setName(name);
		setValue(value);
	}
	
	public void setName(String name){
		this.name = name; 	
	}
	
	public void setValue(String value){
		isString = true;
		this.value = value;
	}
	public void setValue(Boolean value){
		isBool = true;
      	this.value = returnBooleanString(value);
	}
	public void setValue(Integer value){
		isNumber = true;
		this.value = value.format().replace(',', '');
	}
	public void setValue(Double value){
		isNumber = true;
		this.value = value.format();
	}
	public void setValue(Decimal value){
		isNumber = true;
		this.value = value.format();
	}
	public void setValue(List<JSONNameValuePair> value){
		isMemberList = true;
		nameValuePairMembers = value;
	}
	
	public void setValue(ArrayValue value){
		isArray = true;
		objectArray = value;
	}
	
	public String toJsonString(){
		List<String> param = new List<String>();
    	param.add(Name);  
    	
   		if(isString)
        	param.add(doubleQuoteWrap(value));
        else if(isBool ||isNumber)
      		param.add(value);
     	else if(isMemberList)
        	param.add(returnJsonMembersString(nameValuePairMembers));
        else if(isArray)
        	param.add(objectArray.toJsonString());	
     
     return String.Format(JSON_STRING, param);	
	}
	
	public static String returnJsonMembersString(List<JSONNameValuePair> members){
    	String returnString = '';
    	for( Integer i =0; i < members.size(); i++){
        	if(i == members.size() -1)
            returnString += members[i].toJsonString();
        else
           returnString += members[i].toJsonString() + ','; 
    	}    
    	return '{' + returnString + '}';
	}
	
	public static String doubleQuoteWrap(String s){
    	return '"'+ s + '"';
	}
	
	public static String returnBooleanString(Boolean b){
		if(b)
      		return 'true';
      	else
      		return 'false';
	}
	
	/**
	 * Represents a json array, expecting a list of values 
	 */
	public class ArrayValue{
		private String value;
		
		public ArrayValue(){}
		public ArrayValue(List<String> values){ setValue(values);}
		public ArrayValue(List<Boolean> values){ setValue(values);}
		public ArrayValue(List<Integer> values){ setValue(values);}
		public ArrayValue(List<Double> values){ setValue(values);}
		public ArrayValue(List<Decimal> values){ setValue(values);}
		public ArrayValue(List<JSONNameValuePair> values){ setValue(values);}
		
		public void setValue(List<String> values){
			value ='';
			for(integer i=0; i < values.size();i++){
				if(i == values.size() - 1)
					value += JSONNameValuePair.doubleQuoteWrap(values[i]);
				else
					value += JSONNameValuePair.doubleQuoteWrap(values[i]) + ',';
			}
		} 
		
		public void setValue(List<Boolean> values){
			value ='';
			for(integer i = 0; i < values.size(); i++){
				if(i == values.size() - 1)
					value += JSONNameValuePair.returnBooleanString(values[i]);
				else
					value += JSONNameValuePair.returnBooleanString(values[i]) + ',';		
			}
		}
		
		public void setValue(List<Integer> values){
			value ='';
			for(integer i = 0; i < values.size(); i++){
				if(i == values.size() - 1)
					value += values[i].format().replace(',','');
				else
					value += values[i].format().replace(',','') + ',';		
			}
		}
		
		public void setValue(List<Double> values){
			value ='';
			for(integer i = 0; i < values.size(); i++){
				if(i == values.size() - 1)					
					value += values[i].format();				
				else
					value += values[i].format() + ',';		
			}
		}
		
		public void setValue(List<Decimal> values){
			value ='';
			for(integer i = 0; i < values.size(); i++){
				if(i == values.size() - 1)
					value += values[i].format();
				else
					value += values[i].format()+ ',';		
			}
		}
		public void setValue(List<JSONNameValuePair> values){
			value = '';
			for(Integer i =0; i < values.size(); i++){
				if(i == values.size() - 1)
					value  += values[i].toJsonString();
				else
					value  += values[i].toJsonString() + ',';					
			}
		}
		
		public void setJsonStringValue(List<String> values){
			value = '';
			for(Integer i =0; i < values.size(); i++){
				if(i == values.size() - 1)
					value  += values[i];
				else
					value  += values[i] + ',';					
			}
		}
		public String toJsonString(){
			return '['+ value +']';
		}
	}
	/****************************************************************
	 * Test Methods *
	/****************************************************************/
	
	public static testMethod void testAll(){
		String expectedResult = '{'+
									'"To":"test@test.com",'+
									'"From":"James Bond <ka@architech.ca>",'+
									'"ReplyTo":"James Bond<ooadeniy@hotmail.com>",'+
									'"Subject":"This is an invitation test",'+
									'"HtmlBody":"<b>Hello, Kunle</b> <br/> We are sending you this test invite",'+
									'"Integer":1000,'+
									'"Decimal":15.344,'+
									'"Boolean":true,'+
									'"Double":2.2'+
								'}';
								
								
		List<JSONNameValuePair> jsonBodyMemebers = new List<JSONNameValuePair>();
		Double x = 2.2;
		jsonBodyMemebers.add(new JSONNameValuePair('To','test@test.com'));
		jsonBodyMemebers.add(new JSONNameValuePair('From','James Bond <ka@architech.ca>'));
		jsonBodyMemebers.add(new JSONNameValuePair('ReplyTo','James Bond<ooadeniy@hotmail.com>'));
		jsonBodyMemebers.add(new JSONNameValuePair('Subject','This is an invitation test'));
		jsonBodyMemebers.add(new JSONNameValuePair('HtmlBody','<b>Hello, Kunle</b> <br/> We are sending you this test invite'));
		jsonBodyMemebers.add(new JSONNameValuePair('Integer',1000));
		jsonBodyMemebers.add(new JSONNameValuePair('Decimal',15.344));
		jsonBodyMemebers.add(new JSONNameValuePair('Boolean',true));
		jsonBodyMemebers.add(new JSONNameValuePair('Double',x));
		JSONNameValuePair.returnJsonMembersString(jsonBodyMemebers);
		
		String body = JSONNameValuePair.returnJsonMembersString(jsonBodyMemebers); 
		
		system.assert(body == expectedResult);
		
	}
	
	public static testMethod void testArrayValue(){
		
		String expectedResult = '{'+
									'"TotalCount":2,'+
 									'"Bounces":[{"ID":1,"Type":"HardBounce"},{"ID":2,"Type":"Unknown"}],'+
									'"Strings":["string1","string2"],'+
									'"Booleans":[true,false],'+
									'"Doubles":[2.2,2.3],'+
									'"Decimals":[1.5,2.5],'+
									'"Integers":[100,200]'+            
								'}';
		List<JSONNameValuePair> mainJsonBodyMemebers = new List<JSONNameValuePair>();						
	  	JSONNameValuePair member = new JSONNameValuePair('TotalCount',2);
	  	List<JSONNameValuePair> jsonBodyMemebers1 = new List<JSONNameValuePair>();
	  	List<JSONNameValuePair> jsonBodyMemebers2 = new List<JSONNameValuePair>();
	  	List<String> jsonStrings = new List<String>();
	  	List<String> strings = new List<String>{'string1','string2'};
	  	List<Boolean> bools = new List<Boolean>{true,false};
	  	List<Double> dbls = new List<Double>{2.2,2.3};
	  	List<Decimal> decimals = new List<Decimal>{1.5,2.5};
	  	List<Integer> ints = new List<Integer>{100,200};
	  	
	  	//construct Bounces data
	  	jsonBodyMemebers1.add(new JSONNameValuePair('ID',1));
	  	jsonBodyMemebers1.add(new JSONNameValuePair('Type','HardBounce'));
	  	jsonBodyMemebers2.add(new JSONNameValuePair('ID',2));
	  	jsonBodyMemebers2.add(new JSONNameValuePair('Type','Unknown'));
	  	jsonStrings.add(JSONNameValuePair.returnJsonMembersString(jsonBodyMemebers1));
	  	jsonStrings.add(JSONNameValuePair.returnJsonMembersString(jsonBodyMemebers2));
	  	
	  	
	  	mainJsonBodyMemebers.add(member);
	  	JSONNameValuePair.ArrayValue memberArray = new JSONNameValuePair.ArrayValue();
	  	memberArray.setJsonStringValue(jsonStrings);
	  	mainJsonBodyMemebers.add(new JSONNameValuePair('Bounces',memberArray));
	  	mainJsonBodyMemebers.add(new JSONNameValuePair('Strings',new ArrayValue(strings)));
	  	mainJsonBodyMemebers.add(new JSONNameValuePair('Booleans',new ArrayValue(bools)));
	  	mainJsonBodyMemebers.add(new JSONNameValuePair('Doubles',new ArrayValue(dbls)));
	  	mainJsonBodyMemebers.add(new JSONNameValuePair('Decimals',new ArrayValue(decimals)));
	  	mainJsonBodyMemebers.add(new JSONNameValuePair('Integers',new ArrayValue(ints)));
	  	
	  	String body = JSONNameValuePair.returnJsonMembersString(mainJsonBodyMemebers); 

		system.assert(body == expectedResult);
	} 
	
	public static testMethod void testMailSeviceRestAPIBody(){
		//More real example, generating json body for an email message sent to postageapp
		String expectedResult = '{'+
									'"api_key":"get your own api key for free at postageapp.com",'+
									'"arguments":'+
										'{'+
											'"recipients":["someemail@architech.ca","kunle4@gmail.com"],'+
											'"headers":'+
											'{'+
													'"subject":"Testing...",'+
													'"from":"someemail@hotmail.com"},'+
											'"content":'+
												'{'+
													'"text/plain":"This is a test...",'+
													'"text/html":"<b>This is a test...</b>"'+
												'}'+
										'}'+
									'}';
									
		JSONNameValuePair apiKey = new JSONNameValuePair('api_key','get your own api key for free at postageapp.com');
	  	
	  	List<String> toEmails= new List<String>{'someemail@architech.ca','kunle4@gmail.com'};
	  	JSONNameValuePair recipients = new JSONNameValuePair('recipients',new JSONNameValuePair.ArrayValue(toEmails));
	  	
	  	JSONNameValuePair subject = new JSONNameValuePair('subject','Testing...');
	  	JSONNameValuePair fromEmail = new JSONNameValuePair('from','someemail@hotmail.com');
	  	List<JSONNameValuePair> headerMemembers = new List<JSONNameValuePair>{subject,fromEmail};
	  	JSONNameValuePair headers = new JSONNameValuePair('headers',headerMemembers);
	  	
	  	
	  	
	  	JSONNameValuePair text_plain = new JSONNameValuePair('text/plain', 'This is a test...');
	  	JSONNameValuePair text_html = new JSONNameValuePair('text/html', '<b>This is a test...</b>');
	  	List<JSONNameValuePair> contentMemembers = new List<JSONNameValuePair>{text_plain,text_html};
	  	JSONNameValuePair content = new JSONNameValuePair('content', contentMemembers);
	  	List<JSONNameValuePair> argumentsMembers = new List<JSONNameValuePair>{recipients,headers, content};
	  	JSONNameValuePair arguments = new JSONNameValuePair('arguments',argumentsMembers);
	  	
	  	List<JSONNameValuePair> mainJsonBodyMemebers = new List<JSONNameValuePair>{apiKey,arguments};
	  	
	  	String mainJsonSrting = JSONNameValuePair.returnJsonMembersString(mainJsonBodyMemebers);
	  	
	  	system.assert(mainJsonSrting == expectedResult);
	}
	 
}
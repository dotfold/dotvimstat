package com.dotfold.dotvimstat.tokenreplacement
{
	/**
	 * Package level function - replace tokens utility.
	 * 
	 * Finds named tokens in the template String, with the format:
	 * {name} and replaces them with values found in the supplied Object.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public function replacetokens(template:String, data:Object):String
	{
		var pattern:RegExp = new RegExp('{([^}]+)}', 'gi');
		
		return template.replace(pattern, function(...rest):String { //match:String, $1:Object):String {
			
			var match:String = rest[0] as String;
			var token:String = rest[1] as String;
			
			// find the token vlaue in the object
			if (data && data.hasOwnProperty(token)) {
				return data[token];
			}
			// could not replace token, return token as is
			return match;
		});
	}
}
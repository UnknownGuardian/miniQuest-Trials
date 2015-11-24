package be.boulevart.as3 { 
	/**
	* Encodes and decodes a base64 string.
	* @authors Sven Dens - http://www.svendens.be
	* @version 0.1
	*
	* Original Javascript implementation:
	* Aardwulf Systems, www.aardwulf.com
	* See: http://www.aardwulf.com/tutor/base64/base64.html
	*/
	import flash.display.MovieClip;
	import be.boulevart.as3.security.Encryption;
	import be.boulevart.as3.security.EncryptionTypes;
	
	public class as3_cryptdemo extends MovieClip {
		
		protected var e:Encryption;
		protected var theKey:String = "you'll never guess";
		protected var str:String = "My super secret string";
	
		public function as3_cryptdemo()
		{
		trace("String before encryption: " + str + "\n");
		
		//RC4 encryption
		e = new Encryption(EncryptionTypes.RC4(), str , this.theKey, null, null, null);
		e.encrypt();
		trace("String after RC4 encryption: " + e.getInput());
		e.decrypt();
		trace("String after RC4 decryption: " + e.getInput() + "\n");
		
		//Base8 encryption
		e = new Encryption(EncryptionTypes.Base8(), str , null, null, null, null);
		e.encode();
		trace("String after Base8 encoding: " + e.getInput());
		e.decode();
		trace("String after Base8 decoding: " + e.getInput() + "\n");
		
		//Base64 encryption
		e = new Encryption(EncryptionTypes.Base64(), str , null, null, null, null);
		e.encode();
		trace("String after Base64 encoding: " + e.getInput());
		e.decode();
		trace("String after Base64 decoding: " + e.getInput() + "\n");
		
		//Goauld calculation
		e = new Encryption(EncryptionTypes.Goauld(), str , null, null, null, null);
		e.calculate();
		trace("String after Goauld calculation: " + e.getInput() + "\n");
		
		//MD5 calculation
		e = new Encryption(EncryptionTypes.MD5(), str , null, null, null, null);
		e.calculate();
		trace("String after MD5 calculation: " + e.getInput() + "\n");
		
		//ROT13 calculation
		e = new Encryption(EncryptionTypes.ROT13(), str , null, null, null, null);
		e.calculate();
		trace("String after ROT13 calculation: " + e.getInput() + "\n");
		
		//SHA1 calculation
		e = new Encryption(EncryptionTypes.SHA1(), str , null, null, null, null);
		e.calculate();
		trace("String after SHA1 calculation: " + e.getInput() + "\n");
		
		//LZW compression
		/*e = new Encryption(EncryptionTypes.LZW(), str , null, null, null, null);
		e.compress();
		trace("String after LZW compression: " + e.getInput());
		e.decompress();
		trace("String after LZW decompression: " + e.getInput() + "\n");*/
		
		//TEA encryption
		e = new Encryption(EncryptionTypes.TEA(), str , this.theKey, null, null, null);
		e.encrypt();
		trace("String after TEA encryption: " + e.getInput());
		e.decrypt();
		trace("String after TEA decryption: " + e.getInput() + "\n");
		
		//Rijndael encryption
		e = new Encryption(EncryptionTypes.Rijndael(), str , this.theKey, "CBC", 256, 256);
		e.encryptRijndael();
		trace("String after Rijndael encryption: " + e.getInput());
		e.decryptRijndael();
		trace("String after Rijndael decryption: " + e.getInput() + "\n");
		}
	}
}
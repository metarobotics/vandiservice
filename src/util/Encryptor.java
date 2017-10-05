package util;

import java.nio.ByteBuffer;
import java.security.AlgorithmParameters;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;

public class Encryptor {
	
	private static final byte[] MR_ENCRIPTION_SALT = new byte[] { (byte) 0x12, (byte) 0x04, (byte) 0x18, (byte) 0x96, (byte) 0x11, (byte) 0x10, (byte) 0x19, (byte) 0x82 };
	private static final String MR_ENCRIPTION_PASSWORD = "Vandi12345678901";

	/*
	public static void main(String args[]) throws Exception 
	{
		String pwd = " ";
		String pwdEnc = encrypt(pwd);
		String pwdDec = decrypt(pwdEnc);
		
		System.out.println("pwd : " + pwd);
		System.out.println("pwdEnc : " + pwdEnc);
		System.out.println("pwdDec : " + pwdDec);

		String pwdDec1 = decrypt("EgQYlhEQGYIkTsRrn/zFp0Jq6o7ZC1XUA09K2/7/AUGk6L1x7dGUUA==");
		String pwdDec2 = decrypt("EgQYlhEQGYLEf6zwEIkgASdLUO5NYAzHrry8Ht2LSigNnvbFkGvmew==");
		System.out.println("pwdDec1 : " + pwdDec1);
		System.out.println("pwdDec2 : " + pwdDec2);

		// bona : EgQYlhEQGYKOta7ZsXPmAxXhUWiLR1GwFF3xG23IoglFFPvFxDZ7SA==
		// settle0! : EgQYlhEQGYIVUFKSxqxguTJgu/2TvkEgrEGB36M7KZFXuDTcrCNEZw==
		// 1234 : EgQYlhEQGYIkTsRrn/zFp0Jq6o7ZC1XUA09K2/7/AUGk6L1x7dGUUA==
		//        EgQYlhEQGYLEf6zwEIkgASdLUO5NYAzHrry8Ht2LSigNnvbFkGvmew==
		// prince : EgQYlhEQGYJ59o1SS7BcFpOUzWnZUah0j/ig3UrlfUYfwasZSmMTFg==
	}
	*/
	
	public static String encrypt(String text) throws Exception {

		// Derive the key
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1"); // ALGORITHM. 암호화 방식. 변경 불가. 
		PBEKeySpec spec = new PBEKeySpec(MR_ENCRIPTION_PASSWORD.toCharArray(), MR_ENCRIPTION_SALT, 1024, 128);
		SecretKey secretKey = factory.generateSecret(spec);
		SecretKeySpec secret = new SecretKeySpec(secretKey.getEncoded(), "AES");

		// encrypting the word
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, secret);
		AlgorithmParameters params = cipher.getParameters();
		byte[] ivBytes = params.getParameterSpec(IvParameterSpec.class).getIV();
		byte[] encryptedTextBytes = cipher.doFinal(text.getBytes("UTF-8"));

		// prepend salt and vi
		byte[] buffer = new byte[MR_ENCRIPTION_SALT.length + ivBytes.length + encryptedTextBytes.length];
		System.arraycopy(MR_ENCRIPTION_SALT, 0, buffer, 0, MR_ENCRIPTION_SALT.length);
		System.arraycopy(ivBytes, 0, buffer, MR_ENCRIPTION_SALT.length, ivBytes.length);
		System.arraycopy(encryptedTextBytes, 0, buffer, MR_ENCRIPTION_SALT.length + ivBytes.length, encryptedTextBytes.length);
		return new Base64().encodeToString(buffer);
	}

	public static String decrypt(String encryptedText) throws Exception {

		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

		// strip off the salt and iv
		ByteBuffer buffer = ByteBuffer.wrap(new Base64().decode(encryptedText));
		buffer.get(MR_ENCRIPTION_SALT, 0, MR_ENCRIPTION_SALT.length);
		byte[] ivBytes1 = new byte[cipher.getBlockSize()];
		buffer.get(ivBytes1, 0, ivBytes1.length);
		byte[] encryptedTextBytes = new byte[buffer.capacity() - MR_ENCRIPTION_SALT.length - ivBytes1.length];

		buffer.get(encryptedTextBytes);

		// Deriving the key
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1"); // ALGORITHM. 암호화 방식. 변경 불가. 
		PBEKeySpec spec = new PBEKeySpec(MR_ENCRIPTION_PASSWORD.toCharArray(), MR_ENCRIPTION_SALT, 1024, 128);
		SecretKey secretKey = factory.generateSecret(spec);
		SecretKeySpec secret = new SecretKeySpec(secretKey.getEncoded(), "AES");
		cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(ivBytes1));
		byte[] decryptedTextBytes = null;
		try {
			decryptedTextBytes = cipher.doFinal(encryptedTextBytes);
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}

		return new String(decryptedTextBytes);
	}
}

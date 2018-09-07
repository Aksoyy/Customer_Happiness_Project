package com.example.customerquestion;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

/*
 * Web servis ile bağlantının yapıldığı yeri belirtmektedir.
 */
public class OperationsImpl implements IOperations {
	private static final String NAMESPACE = "http://CustomerService/";
	private static final String SERVICE_URL = "http://192.168.56.1:8080/CustomerService/services/Customer?wsdl";

	private static final String CALC_LOGIN = "userLogin";

	/*
	 * Kullanıcı tarafından belirlenen metoda gitmeyi sağlayan kısımdır.
	 */
	public LoginResult Login(LoginInput input) {
		LoginResult result = new LoginResult();
		SoapObject request = new SoapObject(NAMESPACE, CALC_LOGIN);
		request.addProperty("param1", input.userName);
		request.addProperty("param2", input.password);

		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(
				SoapEnvelope.VER11);
		envelope.dotNet = true;
		envelope.encodingStyle = SoapEnvelope.ENC; // ksoap2'de eklenmemişti.
		envelope.setAddAdornments(false); // ksoap2'de eklenmemişti.
		envelope.implicitTypes = false; // ksoap2'de eklenmemişti.
		envelope.setOutputSoapObject(request);

		HttpTransportSE androidHTTPTransport = new HttpTransportSE(SERVICE_URL);
		try {
			androidHTTPTransport.call(NAMESPACE + CALC_LOGIN, envelope);
			if (envelope.bodyIn instanceof SoapObject) {
				SoapObject soapObject = (SoapObject) envelope.bodyIn;

				result.sessionKey = soapObject.getProperty(0).toString();
			}
		} catch (Exception exp) {
			return null;
		}
		return result;
	}
}
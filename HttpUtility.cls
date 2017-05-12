/**
 * Copyright (c) 2016, Salesforce.com, Inc.  All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 * 
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 * 
 *   * Neither the name of Salesforce.com nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *
 * @author Salesforce
 * @date 
 * @brief Provides the desgin contact for Http Response/Requests
 * @description Provides the desgin contact for Http Response/Requests
 * @group Common Layer
 */
public without sharing class HttpUtility implements IHttpUtility {
	/*
	 * Constant
	 */

	public static final Integer MAX_RETRIES = 3;
	public static final String HTTP_METHOD = 'POST';

	/*
	 * Public Properties
	 */
	public String methodProperty {get; protected set;}
	public String endPointProperty {get; protected set;}
	public NameValuePair headersProperty {get; protected set;}
	public Integer maxNumberOfRetries {get;  set;}
	public Exception httpException {get; protected set;}


	/*
	 * Private Properties (but visible to the test)
	 */
	@TestVisible private Integer failuresWebServicesCall = 0;
	@TestVisible private Http http = null;
	@TestVisible private  HttpRequest request = null;

	/*********************************************************************************************************
	 * Constructor
	 */
	public HttpUtility(Integer maxRetries) {
		this(maxretries, '', null, HttpUtility.HTTP_METHOD);
	} // end of ctor
	public HttpUtility(String endpoint) {
		this(HttpUtility.MAX_RETRIES, endpoint, null, HttpUtility.HTTP_METHOD);

	}// end of ctor
	public HttpUtility(String endpoint, NameValuePair headers) {
		this(HttpUtility.MAX_RETRIES, endpoint, headers, HttpUtility.HTTP_METHOD);

	} // end of ctor
	public HttpUtility(String endpoint, NameValuePair headers, String method) {
		this(HttpUtility.MAX_RETRIES, endpoint, headers, method);
	} // end of ctor

	/**
	 * @brief Constructor
	 * @description [long description]
	 *
	 * @param maxretries [description]
	 * @param endpoint [description]
	 * @param headers [description]
	 * @param method [description]
	 * @return [description]
	 */
	public HttpUtility(Integer  maxretries, String endpoint, NameValuePair headers, String method) {
		this.endPointProperty = endpoint;
		this.headersProperty = headers;
		this.maxNumberOfRetries = maxretries <= 0 ? HttpUtility.MAX_RETRIES : maxretries;
		this.methodProperty = method;
	} // main ctor ( all the others are chained)

	/*****************************************************************************************************
	 * Public Methods
	 */

	/**
	 * @brief Get the Protocol
	 * @description the protocol to use (lazy)
	 * @return Http
	 */
	public Http getHttp() {
		if ( this.http == null ) {
			this.http = new Http();
		}
		return this.http;
	} // end of Http

	/**
	 * @brief [brief description]
	 * @description [long description]
	 * @return [description]
	 */
	public HttpRequest getRequest() {
		// do this once
		if ( this.request == null ) {
			try {
				this.request = new HttpRequest();

				// Need to check whether to make method type and content type as configurable.
				this.request.setMethod(this.methodProperty);
				this.request.setEndpoint(this.endPointProperty);
				this.setHeaders();
			} catch (Exception exp) {
				ErrorLogClass.logError('HttpUtility', exp , 'getRequest');
				this.httpException = exp;

			}
		}
		return this.request;
	} // end of makeRequest
	/**
	 * @brief reset values
	 * @description  reset the method to try again; this assumes you already tried the maximum time
	 *  but have cached the utility or created a singleton and want to reset
	 */
	public void reset() {
		this.request = null;
		this.failuresWebServicesCall = 0;
		this.httpException = null;
		this.http = null;
	} // end of reset

	/**
	* @brief Make the http call, checking whether to retry the call out
	* @description [long description]
	* @return true, if successful
	*/
	public Boolean callOut() {
		return	this.callOut(true);
	} // end of callOut

	/**
	 * @brief Make the http call, checking whether to retry the call out
	 * @description [long description]
	 * @return true, if successful
	 */
	public Boolean callOut(Boolean callMaximRetries) {

		Boolean success = true;
	
		do {
			success = this.httpCallOut();
			// if we are not successful and tried max, then break out
			if ( !success && this.maxRetriesPerformed() ) {
				break;
			}

		} while ( !success && callMaximRetries);
		// return true if we need to perform the check again
		return success;
	} // end of callOut

	/**************************************************************************************
	 * Private Methods
	 */
	/**
	 * @brief Max retries have been done
	 * @description [long description]
	 *
	 * @return true if max retries
	 */
	@TestVisible private Boolean maxRetriesPerformed() {
		return this.failuresWebServicesCall > this.maxNumberOfRetries;
	} // end of retryCall
	/**
	* @brief make the http callout
	* @description  make the http callout
	*
	* @return true if successful
	*/
	@TestVisible private Boolean  httpCallOut() {
		Boolean success = false;
		ResponseWrapper rWrap = null;

		this.failuresWebServicesCall++;
		try {

			HTTPResponse res = this.getHttp().send(this.getRequest());
			rWrap = (ResponseWrapper)JSON.deserialize(res.getBody(), ResponseWrapper.class);
			success = this.callSuccessful(rWrap);

		} catch (CalloutException callExp) {
			ErrorLogClass.logError('HttpUtility', callExp , 'callOut');
			this.httpException = callExp;
		} catch (NullPointerException nullExp) {
			ErrorLogClass.logError('HttpUtility', nullExp , 'callOut');
			this.httpException = nullExp;
		} catch (Exception exp) {
			ErrorLogClass.logError('HttpUtility', exp , 'callOut');
			this.httpException = exp;

		}
		return success;

	} // end of httpCallOut
	/**
	 * @brief Was the Http call successful, if not log and return
	 * @description Was the Http call successful, if not log and return
	 *
	 * @param rWrap ResponseWrapper
	 * @return true if successful
	 */
	@TestVisible private Boolean callSuccessful(ResponseWrapper rWrap) {
		Boolean isSuccess = rWrap != null ? 'true'.equalsIgnoreCase(rWrap.success) : false;

		// reset exception
		this.httpException = null;
		// successful, if not log error and record exception
		if ( !isSuccess ) {
			this.httpException = new LennarException(this.formatErrorMessageToString(rWrap));
			ErrorLogClass.logError('HttpUtility', this.httpException , 'callOut');
		}
		return isSuccess;
	} // end of callSuccessful
	/**
	 * @brief Set the http headers
	 * @description [long description]
	 */
	@TestVisible private void setHeaders() {
		if ( this.headersProperty != null  ) {
			//'Content-Type'
			// 'application/json'
			for (String key : this.headersProperty.nvp.keyset() ) {
				this.getRequest().setHeader(key, this.headersProperty.nvp.get(key));
			}
		}
	}// end of setHeaders
	/**
	* @brief Format Response wrapper ror a string
	* @description Format Response wrapper to a string
	*
	* @param wrapper ResponseWrapper
	* @return String
	*/
	@TestVisible private String formatErrorMessageToString(ResponseWrapper wrapper) {
		String result = '';
		if ( wrapper != null ) {
			result = String.format('\nResponseWrapper error code: {0}\nError Message: {1}\n', new String[] {
			                           wrapper.error_code
			                           , wrapper.errors
			                       });
		}
		return result;
	}// end of formatErrorMessageToString

	public class ResponseWrapper {
		public String success;
		public String error_code;
		public String errors;
	}

} // end of HttpUtility
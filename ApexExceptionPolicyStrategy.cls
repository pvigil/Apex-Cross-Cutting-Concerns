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
 * @date 06/20/2016
 * @brief What to do with exceptions
 * @description What to do with exceptions. We want to ensure that we are not sharing secure information. It is assumed that all UI exceptions
 * must be translated to a more secure text.
 * @group Comon Layer
 */
global with sharing class ApexExceptionPolicyStrategy implements IApexExceptionPolicyStrategy {

	////////////////////////////////////////////////////////////////////////////////
	/// Data Members
	////////////////////////////////////////////////////////////////////////////////

	// known exceptions and response message
	private static final Map<String, String> listOfKnownExceptions = new Map<String, String>();

	////////////////////////////////////////////////////////////////////////////////
	/// static initializer
	////////////////////////////////////////////////////////////////////////////////
	static {
		ApexExceptionPolicyStrategy.initializeBase();
	} // end of static initializer
	
	////////////////////////////////////////////////////////////////////////////////
	/// Ctor
	////////////////////////////////////////////////////////////////////////////////
	//
	// default ctor
	//
	public ApexExceptionPolicyStrategy() {

	}// end of ctor

	////////////////////////////////////////////////////////////////////////////////
	/// Public Methods
	////////////////////////////////////////////////////////////////////////////////
	//
	// Based on the policy and exception type determine
	// whether to rethrow the exception or a different one
	//

	//
	// Determine if we rethrow the same exception (defaults to Global policy), or a new one
	//
	public Exception rethrow(Exception excp) {
		return this.rethrow(excp, ApexExceptionPolicyEnum.Top);
	} // end of rethrow
	//
	// Determine if we rethrow the same exception (defaults to Global policy), or a new one
	//
	public Exception rethrow(Exception excp, ApexExceptionPolicyEnum policy) {
		Exception result = excp;
		// valid data
		if ( excp != null ) {
			// special consideration is done for UI and Global, all others returned null
			// indicating no need to rethrow
			if (policy == ApexExceptionPolicyEnum.UI
			        || policy == ApexExceptionPolicyEnum.Top) {

				String exceptionName = excp.getTypeName();
				// looping over exceptions, find one we wish to translate
				for (String key : ApexExceptionPolicyStrategy.listOfKnownExceptions.keySet()) {
					if ( key == exceptionName) {
						result = new ApexApplicationException(ApexExceptionPolicyStrategy.listOfKnownExceptions.get(key), excp);
						break;
					} //endif
				}// endfor
			} 
		}// endif
		return result ;
	}// end of rethrow

	////////////////////////////////////////////////////////////////////////////////
	/// Private Methods
	////////////////////////////////////////////////////////////////////////////////
	/**
	 * @brief Create a list of known exceptions
	 * @description Create a list of known exceptions and supply a secure messsage that will be returned back. These values
	 * are hard-coded and need to be mapped in and localized!!! [TBD]
	 */
	private static void initializeBase() {
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(AsyncException.class)
		        , ' An asynchronous operation failed. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(CalloutException.class)
		        , ' An web-service operation failed. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(DmlException.class)
		        , ' A database [DML] operation failed. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(EmailException.class)
		        , ' An email operation failed. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(ExternalObjectException.class)
		        , ' An external operation failed. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(InvalidParameterValueException.class)
		        , ' An invalid parameter was passed into a method. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(LimitException.class)
		        , ' An governor  limit fahas been exceeded. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(JSONException.class)
		        , ' A problem parsing some data [JSON] failed. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(ListException.class)
		        , ' An attempt to access an index that is out of bounds failed. Please contact you system administrator');

		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(NoAccessException.class)
		        , ' An unauthorized access. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(NoDataFoundException.class)
		        , ' No data found -- perhaps, the data is deleted. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(NoSuchElementException.class)
		        , ' An attempt to access an item that is out of bounds failed. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(NullPointerException.class)
		        , ' An attempt to access a null pointer . Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(QueryException.class)
		        , ' An attempt to query that may have returned no records or more than was expected. Please contact you system administrator');
		ApexExceptionPolicyStrategy.listOfKnownExceptions.put(String.valueOf(SearchException.class)
		        , ' An attempt to search for data failed. Please contact you system administrator');

	} //end of initializeBase
}
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
 * @date 06/14/2016
 * @brief Send information base call
 * @description Send information base class. Contains utilities
 * @group Common Layer
 *
 * TBD -- localization
 */
public without sharing abstract class ApexBaseMessageSender implements IApexMessageSender {

	////////////////////////////////////////////////////////////////////////////////
	/// Data Members
	////////////////////////////////////////////////////////////////////////////////
	protected ApexApplicationException sendException = null;

	//
	// default ctor
	//
	public ApexBaseMessageSender() {

	}// end of ctor
	////////////////////////////////////////////////////////////////////////////////
	/// Public Methods
	////////////////////////////////////////////////////////////////////////////////
	/**
	 * @brief Get the exception if any
	 * @description  Get the exception if any
	 * @return null if successful, Exception otherwise
	 */
	public Exception getException() {
		return this.sendException;
	} // end of getException

	/**
	 * @brief Send information
	 * @description Send information
	 *
	 * @param messagePayload broken into parts
	 * @return Object. ApexMessageSendResponse Response
	 */
	public abstract ApexMessageSendResponse send(ApexMessagePayload messagePayload);

	////////////////////////////////////////////////////////////////////////////////
	/// Protected Methods
	////////////////////////////////////////////////////////////////////////////////

	/**
	 * @brief reset state
	 * @description  reset state -- set exception back to null
	 */
	protected void reset() {
		this.sendException = null;
	} // end of reset
	/**
	 * @brief Get a string from the payload
	 * @description get a string from the payload based on the index
	 *
	 * @param messagePayload payload
	 * @param index into the payload
	 * @param errorMesg error to set in the exception , if any
	 * @return a string value
	 */
	protected  String getStringFromPayload(ApexMessagePayload messagePayload
	                                       , String index
	                                       , String errorMesg) {

		return this.getStringFromPayload(messagePayload, index, errorMesg, false);
	} // end of getStringFromPayload
	/**
	 * @brief Get a string [] from the payload
	 * @description get a string[] from the payload based on the index
	 *
	 * @param messagePayload payload
	 * @param index into the payload
	 * @param errorMesg error to set in the exception , if any
	 * @param ignoreException ignore the exception
	 * @return a string[] value
	 */
	protected List<String> getStringArrayFromPayload(ApexMessagePayload messagePayload
	        , String index
	        , String errorMesg) {

		return this.getStringArrayFromPayload(messagePayload, index, errorMesg, false);
	} // end of getStringArrayFromPayload
	/**
	 * @brief Get a string from the payload
	 * @description get a string from the payload based on the index
	 *
	 * @param messagePayload payload
	 * @param index into the payload
	 * @param errorMesg error to set in the exception , if any
	 * @param ignoreException ignore the exception
	 * @return a string value
	 */
	protected virtual String getStringFromPayload(ApexMessagePayload messagePayload
	        , String index
	        , String errorMesg
	        , Boolean ignoreException) {
		return (String )this.getEntity(messagePayload, index, errorMesg, ignoreException);
	} // end of getStringFromPayload

	/**
	 * @brief Get a string [] from the payload
	 * @description get a string[] from the payload based on the index
	 *
	 * @param messagePayload payload
	 * @param index into the payload
	 * @param errorMesg error to set in the exception , if any
	 * @param ignoreException ignore the exception
	 * @return a string[] value
	 */
	protected virtual List<String> getStringArrayFromPayload(ApexMessagePayload messagePayload
	        , String index
	        , String errorMesg
	        , Boolean ignoreException) {
		return (List<String> )this.getEntity(messagePayload, index, errorMesg, ignoreException);

	} // end of getStringArrayFromPayload

	/**
	 * @brief Get the entity from the payload
	 * @details Get the entity from the payload
	 *
	 * @param messagePayload payload
	 * @param index into the payload
	 * @param errorMesg error to set in the exception , if any
	 * @param ignoreException ignore the exception
	 *
	 * @return Object
	 */
	protected virtual Object getEntity(ApexMessagePayload messagePayload
	                           , String index
	                           , String errorMesg
	                           , Boolean ignoreException) {
		Object results = null;
		try {
			if ( messagePayload != null
			        && this.sendException == null
			        &&  messagePayload.attributes != null ) {
				Map<String, Object> nvop  = messagePayload.attributes;
				if ( nvop != null ) {
					results = nvop.get(index);
				}
			}
		} catch (Exception excp) {
			if ( !ignoreException) {
				this.sendException = new ApexApplicationException (errorMesg, excp);
				messagePayload.payloadException = this.sendException;
			}

		}
		return results;
	} // end of getEntity
}// end of ApexBaseMessageSender
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
 * @brief Implementation of Exception Handling for Salesforce
 * @description Implementation of the exception handler. This could be logging the exception thru various channels and/or returning
 *          a more secure exception.
 * @group Common Layer
 */
public virtual without sharing class ApexExceptionHandler implements IApexExceptionHandler {

	////////////////////////////////////////////////////////////////////////////////
	/// Ctor
	////////////////////////////////////////////////////////////////////////////////
	/**
	 * @brief [brief description]fault ctor
	 * @description default ctor
	 */
	public ApexExceptionHandler() {

	} // end of ctor


	////////////////////////////////////////////////////////////////////////////////
	/// Public Methods
	////////////////////////////////////////////////////////////////////////////////

	//
	// Process the exception (defaults to Global policy)
	//
	public void process(Exception excp) {
		this.process(excp, ApexExceptionPolicyEnum.Top);
	}// end of process
	//
	// Process the exception and the associate policy
	//
	public virtual void process(Exception excp, ApexExceptionPolicyEnum policy) {
		this.process(excp, policy, true);
	} // end of process
	//
	// Process the exception, the associate policy and log exception
	//
	public virtual void process(Exception excp, ApexExceptionPolicyEnum policy, Boolean logException) {

		if ( logException ) {
			// just log the exception. For more elaborate strategy, call 'rethrow'
			this.performDefineSteps(excp, policy);
		}
	} // end of process
	//
	// rethrow the exception
	//
	public  Exception rethrow(Exception excp) {
		return this.rethrow(excp, ApexExceptionPolicyEnum.Top);
	}// end of rethrow

	//
	// rethrow the exception
	//
	public virtual Exception rethrow(Exception excp, ApexExceptionPolicyEnum policy) {
		Exception returned = excp;
		// do the normal processing of the exception
		this.process(excp, policy);
		// get the rethrow exception, if any
		try {
			IApexExceptionPolicyStrategy policyStrategy =  (IApexExceptionPolicyStrategy)ApexRunEnvironmentSingleton.getInstance().objectFactory().create(ApexConstants.ExceptionPolicyHandler);
			// what to do with an exception, translate it or returned null [meaning no need to rethrow]
			returned = policyStrategy.rethrow( excp, policy);

		} catch (Exception ignoreException) {}
		return returned;
	} // end of rethrow

	////////////////////////////////////////////////////////////////////////////////
	/// Protected Methods (can be overridden by child)
	////////////////////////////////////////////////////////////////////////////////
	/**
	 * @brief write exception to the logger
	 * @description write exception to the logger
	 *
	 * @param excp the  exception
	 */
	protected virtual void performDefineSteps(Exception excp, ApexExceptionPolicyEnum policy) {
		// just log the exception. For more elaborate strategy, call 'rethrow'
		this.writeExceptionToLogger(excp, policy);
		// now notify personnel (if overridden)
		this.notifyAppropriatePersonnel(excp);
	}// end of performDefineSteps
	/**
	 * @brief write exception to the logger
	 * @description write exception to the logger
	 *
	 * @param excp the  exception
	 */
	protected virtual void writeExceptionToLogger(Exception excp, ApexExceptionPolicyEnum policy) {

		if ( excp != null ) {
			ILogger logger = ApexRunEnvironmentSingleton.getInstance().logger();

			logger.error(this.formatExceptionMessage(excp, policy));
		}

	} // end of writeExceptionToLogger

	protected virtual void notifyAppropriatePersonnel(Exception excp) {

	} // end of
	/**
	 * @brief format the exception message
	 * @description format the exception message
	 *
	 * @param excp the thrown exception
	 * @param policy policy of the exception
	 *
	 * @return String. Formatted string to output
	 */
	protected virtual String formatExceptionMessage(Exception excp, ApexExceptionPolicyEnum policy) {
		String message = '';
		IDataFormat formatter = null;
		try {
			formatter =  (IDataFormat)ApexRunEnvironmentSingleton.getInstance().objectFactory().create(ApexConstants.ExceptionFormatter);
			message = (String)formatter.format( excp, policy);

		} catch (Exception ignoreException) {}
		return message;
	} // end of formatExceptionMessage
} // end of ApexExceptionHandler
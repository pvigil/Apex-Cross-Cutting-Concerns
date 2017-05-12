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
 * @brief Exception Handling for Salesforce
 * @description Handles the exception. This could be logging the exception thru various channels and/or returning a more secure exception.
 *
 * @group Common Layer
 */
public virtual interface IApexExceptionHandler {

	/**
	 * @brief Process the exception (defaults to Global policy)
	 * @description Process the exception (defaults to Global policy)
	 * 
	 * @param excp  Exception
	 */
	void process(Exception excp);
	/**
	 * @brief Process the exception and the associate policy
	 * @description Process the exception and the associate policy
	 * 
	 * @param excp Exception
	 * @param policy ApexExceptionPolicyEnum
	 */
	void process(Exception excp, ApexExceptionPolicyEnum policy);
	/**
	 * @brief Process the exception and the associate policy; and log it if needed
	 * @description Process the exception and the associate policy; and log it if needed
	 * 
	 * @param excp Exception
	 * @param policy ApexExceptionPolicyEnum
	 * @param logException Boolean
	 */
	void process(Exception excp, ApexExceptionPolicyEnum policy, Boolean logException);
	/**
	 * @brief Determine if we rethrow the same exception (defaults to Global policy), or a new one
	 * @description Determine if we rethrow the same exception (defaults to Global policy), or a new one
	 * 
	 * @param excp Exception
	 * @return Exception the exception to rethrow
	 */
	Exception rethrow(Exception excp);
	/**
	 * @brief  Determine if we rethrow the same exception (defaults to Global policy), or a new one
	 * @description Determine if we rethrow the same exception (defaults to Global policy), or a new one
	 * 
	 * @param excp Exception
	 * @param policy ApexExceptionPolicyEnum
	 * 
	 * @return [Exception the exception to rethrow
	 */
	Exception rethrow(Exception excp, ApexExceptionPolicyEnum policy);

} // end of IApexExceptionHandler
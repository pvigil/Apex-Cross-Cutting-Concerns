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
 * @brief Test the Exception Policy
 * @@description Test the Exception Policy
 *
 */
@isTest
private class ApexExceptionPolicyStrategyTest {

	// test exception
	private class TestStrategyException extends Exception {}
	// our strategy
	private final static IApexExceptionPolicyStrategy policyStrategy =  (IApexExceptionPolicyStrategy) ApexRunEnvironmentSingleton.getInstance().objectFactory().create(ApexConstants.ExceptionPolicyHandler);
	/**
	 * @brief Test to make sure the SAME exception IS returned
	 * @@description Test to make sure the SAME exception IS returned
	 */
	@isTest static void testRethrowShouldBeSameException() {
		// assign
		TestStrategyException excp = new 	TestStrategyException('my test');
		// act
		Exception returned = policyStrategy.rethrow( excp);
		// assert
		AssertsTestUtility.equals( returned, excp);
	} // end of testRethrowShouldBeSameException

	/**
	 * @brief Test to make sure the exception IS re-translated
	 * @@description Test to make sure the exception IS re-translated based on policy
	 * 	 
	 */
	@isTest static void testRethrowShouldNotBeSameException() {
		//  assign
		NullPointerException  excp = ApexExceptionPolicyStrategyTest.getException();
		// act
		Exception returned = policyStrategy.rethrow( excp,ApexExceptionPolicyEnum.Top);
		// assert
		AssertsTestUtility.notEquals( returned.getTypeName(), excp.getTypeName());
	} // end of testRethrowShouldNotBeSameException

	/**
	 * @brief Test to make sure the exception is not re-translated
	 * @@description Test to make sure the exception is not re-translated
	 */
	@isTest static void testRethrowShouldBeNullDueToPolicy() {
		//  assign
		NullPointerException  excp = ApexExceptionPolicyStrategyTest.getException();
		// act
		Exception returned = policyStrategy.rethrow( excp,ApexExceptionPolicyEnum.Data);
		// assert
		AssertsTestUtility.equals( returned, null);
	} // end of testRethrowShouldBeNullDueToPolicy
	/**
	 * @brief Create a null exception
	 * @@description Create a null exception
	 * @return NullPointerException
	 */
	private static NullPointerException getException() {
		NullPointerException returned = null;
		try {
			String myNull = null;
			Integer len = myNull.length();
		} catch (NullPointerException excp) {
			returned = excp;
		}
		return returned;
	} // end of getException
}
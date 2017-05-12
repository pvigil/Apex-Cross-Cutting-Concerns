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
 * @brief Test exception handler
 * @details Test exception handler
 *
 */
@isTest
private class ApexExceptionHandlerTest {
	// my specific test exception
	public class TestException extends Exception {}

	private static final String EXPECTED_EXCP_STRING = 'Exception type caught: ApexExceptionHandlerTest.TestException';

	//
	// test the exception handling process
	//
	@isTest static void testProcess() {
		// assign
		TestException  excp = new TestException ('ApexExceptionHandlerTest:testProcess');
		// act
		Test.startTest();
		ApexExceptionHandlerTest.getExceptionHandler().process(excp);
		String msg = TestEnvironmentSingleton.getInstance().logger().lastMessage();
		 
		Integer result = msg.indexOf(EXPECTED_EXCP_STRING);
		
		// assert
		AssertsTestUtility.notEquals( result, -1);
		Test.stopTest();
	} // end of testProcess

	//
	// Ensure the log is not created by turning it off
	//
	@isTest static void testProcessNoLog() {
		// assign
		TestException  excp = new TestException ('ApexExceptionHandlerTest:testProcessNoLog');
		// act
		Test.startTest();
		ApexExceptionHandlerTest.getExceptionHandler().process(excp, ApexExceptionPolicyEnum.Top,false);
		String msg = TestEnvironmentSingleton.getInstance().logger().lastMessage();
		// assert
		AssertsTestUtility.equals( msg, null);
		Test.stopTest();
	} // end of testProcessNoLog
	//
	// Test rethrow
	//
	@isTest static void testRethrow() {
		// assign
		TestException  excp = new TestException ('ApexExceptionHandlerTest:testRethrow');
		// act
		Test.startTest();
		Exception result = ApexExceptionHandlerTest.getExceptionHandler().rethrow(excp);
			// assert
		AssertsTestUtility.equals( result, excp);
		Test.stopTest();
	} // end of testRethrow
	//
	// get the test exception handler
	//
	private static IApexExceptionHandler getExceptionHandler() {
		return TestEnvironmentSingleton.getInstance().exceptionHandler();
	} // end of getExceptionHandler
} // end of ApexExceptionHandlerTest
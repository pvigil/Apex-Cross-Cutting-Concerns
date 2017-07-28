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
 * @brief test the test environment singleton
 * @details test the test environment singleton
 *
 */
@isTest
private class TestEnvironmentSingletonTest {

	//
	// all operations should return a valid value. The check casts to the underlying
	// interface to ensure the correct value is asserted
	//
	@isTest static void testMethodsValidity() {
		IApexRunEnvironment env = TestEnvironmentSingleton.getInstance();

		IConfigurationProvider provider = env.provider();
		ILogger logger = env.logger();
		IFallbackResources fallback = env.fallbackResources();
		IApexFactory factory = env.objectFactory();
		IApexExceptionHandler excpHandler = env.exceptionhandler();
		ICache cache = env.cache();
		IPreviousTransactionResult previousResult = env.transactionResult();

		Test.startTest();
		AssertsTestUtility.equals(ApexTestUtilities.isProvider(provider), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isLogger(logger), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isFallback(fallback), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isFactory(factory), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isExceptionHandler(excpHandler), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isCache(cache), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isPreviousTransactionResult(previousResult), true, true);
		Test.stopTest();


	}// end of testMethodsValidity

	//
	// All values should be present; however, the wrong comparison/casting should cause
	// exceptions and return of null
	//
	@isTest static void testMethodsInValid() {
		IApexRunEnvironment env = TestEnvironmentSingleton.getInstance();

		IConfigurationProvider provider = env.provider();
		ILogger logger = env.logger();
		IFallbackResources fallback = env.fallbackResources();
		IApexFactory factory = env.objectFactory();
		IApexExceptionHandler excpHandler = env.exceptionhandler();
		ICache cache = env.cache();
		Test.startTest();
		AssertsTestUtility.notEquals(ApexTestUtilities.isLogger(provider), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isProvider(logger), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFactory(fallback), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isLogger(factory), true, true);

		AssertsTestUtility.notEquals(ApexTestUtilities.isFallback(excpHandler), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFallback(cache), true, true);
		Test.stopTest();

	}// end of testMethodsInValid

	//
	// Test the methods are valid even of the values are set to null
	//
	@isTest static void testSetMethodsAreValid() {
		IApexRunEnvironment env = TestEnvironmentSingleton.getInstance();

		//
		// even if we set the value to null, the singleton should re-creates the values
		//
		env.provider(null);
		IConfigurationProvider provider = env.provider();
		env.logger(null);
		ILogger logger = env.logger();
		env.fallbackResources(null);
		IFallbackResources fallback = env.fallbackResources();
		env.objectFactory(null);
		IApexFactory factory = env.objectFactory();
		env.exceptionhandler(null);
		IApexExceptionHandler excpHandler = env.exceptionhandler();
		ICache cache = env.cache();
		Test.startTest();
		AssertsTestUtility.notEquals(ApexTestUtilities.isLogger(logger), false, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isProvider(provider), false, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFactory(factory), false, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFallback(fallback), false, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isExceptionHandler(excpHandler), false, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isCache(cache), false, true);
		Test.stopTest();

	}// end of testSetMethodsAreValid


} // end of TestEnvironmentSingletonTest
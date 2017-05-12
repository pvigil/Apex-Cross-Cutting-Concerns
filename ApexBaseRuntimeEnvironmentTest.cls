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
 * @brief Test the apex base runtime environment
 * @decription Test the apex base runtime environment
 *
 */

@isTest
private class ApexBaseRuntimeEnvironmentTest {

	private static IApexRunEnvironment theEnvironment = null;

	//
	// test equals for validity
	//
	@isTest static void testMethodsValidity() {
		IApexRunEnvironment env = ApexBaseRuntimeEnvironmentTest.getTheEnvironment();


		IConfigurationProvider provider = env.provider();
		ILogger logger = env.logger();
		IFallbackResources fallback = env.fallbackResources();
		IApexFactory factory = env.objectFactory();
		IApexExceptionHandler excpHandler = env.exceptionhandler();
		ICache cache = env.cache();
		IPreviousTransactionResult trResult = env.transactionResult();

		Test.startTest();
		AssertsTestUtility.equals(ApexTestUtilities.isProvider(provider), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isLogger(logger), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isFallback(fallback), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isExceptionHandler(excpHandler), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isFactory(factory), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isCache(cache), true, true);
		AssertsTestUtility.equals(ApexTestUtilities.isPreviousTransactionResult(trResult), true, true);
		Test.stopTest();

	}// end of testMethodsValidity

	// test not equals
	@isTest static void testMethodsInValid() {
		IApexRunEnvironment env = ApexBaseRuntimeEnvironmentTest.getTheEnvironment();


		IConfigurationProvider provider = env.provider();
		ILogger logger = env.logger();
		IFallbackResources fallback = env.fallbackResources();
		IApexFactory factory = env.objectFactory();
		IApexExceptionHandler excpHandler = env.exceptionhandler();
		ICache cache = env.cache();
		IPreviousTransactionResult trResult = env.transactionResult();


		Test.startTest();
		AssertsTestUtility.notEquals(ApexTestUtilities.isLogger(provider), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isProvider(logger), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFactory(fallback), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isExceptionHandler(factory), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFallback(excpHandler), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFallback(cache), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isProvider(trResult), true, true);
		Test.stopTest();

	}// end of testMethodsInValid

	//
	// test valid types/class
	//
	@isTest static void testSetMethodsAreValid() {
		IApexRunEnvironment env = ApexBaseRuntimeEnvironmentTest.getTheEnvironment();

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
		env.cache(null);
		ICache cache = env.cache();
		env.transactionResult(null);
		IPreviousTransactionResult trResult = env.transactionResult();


		Test.startTest();
		AssertsTestUtility.notEquals(ApexTestUtilities.isLogger(provider), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isProvider(logger), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFactory(fallback), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isLogger(factory), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isProvider(excpHandler), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isFactory(cache), true, true);
		AssertsTestUtility.notEquals(ApexTestUtilities.isLogger(trResult), true, true);
		Test.stopTest();
	}// end of testSetMethodsAreValid

	//
	// Get the environment we are testing
	//
	private static IApexRunEnvironment getTheEnvironment() {
		AssertsTestUtility.ignoreSoftAssert = true;

		if ( ApexBaseRuntimeEnvironmentTest.theEnvironment == null ) {
			// need to ensure the ApexTestFactory is used as it includes
			// resources not found in the ApexFactory which is used in 'ApexBaseRuntimeEnvironment'
			//
			IApexFactory testFactory = new ApexTestObjectFactory();
			IFallbackResources testFallback = (IFallbackResources)testFactory.create(ApexTestUtilities.FallbackTestResource);
			ApexBaseRuntimeEnvironmentTest.theEnvironment = new ApexBaseRuntimeEnvironment();
			ApexBaseRuntimeEnvironmentTest.theEnvironment.objectFactory(testFactory);
			ApexBaseRuntimeEnvironmentTest.theEnvironment.fallbackResources(testFallback);
		}
		return ApexBaseRuntimeEnvironmentTest.theEnvironment;
	} // end of getTheEnvironment

 
} // end of ApexBaseRuntimeEnvironmentTest
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
 * @brief Test class for the  Factory object
 * @description Test class for the  Factory object
 */
@isTest
private class ApexObjectFactoryTest {


	/**
	 * @brief Test the factory can be created
	 * @description Test the factory can be created
	 */
	@isTest static void testCtor() {

		// arrange & act
		// our factory
		IApexFactory factory = new ApexObjectFactory();

		// assert
		Test.startTest();
		AssertsTestUtility.notEquals(factory , null) ;
		Test.stopTest();
	} // end of testCtor
	/**
	 * @brief Test the factory keySet
	 * @description Test the factory keySet
	 */
	@isTest static void testKeySet() {

		// arrange & act
		 
		// our factory
		IApexFactory factory = new ApexObjectFactory();

		// assert
		Test.startTest();
		AssertsTestUtility.notEquals(factory.keys() , null) ;		 
		Test.stopTest();
	} // end of testKeySet
	/**
	 * @brief Test the factory add name
	 * @description Test the factory add name
	 */
	@isTest static void testKAddByName() {

		// arrange & act
		List<String> names = new String[] {
		    'ApexLogger',
		    'ApexExceptionHandler',
		    'ApexExceptionPolicyStrategy'
		};
		// our factory
		IApexFactory factory = new ApexObjectFactory();

		// assert
		Test.startTest();
	 
		// iterate over known list
		for (String key : names) {
			factory.add(key);
			AssertsTestUtility.notEquals(factory.create(key) , null) ;
		}
		Test.stopTest();
	} // end of testKAddByName
	/**
	 * @brief test creating items from the factory
	 * @description test creating items from the factory
	 */
	@isTest static void testCreateItems() {

		// arrange & act
		List<String> myFQN = new List<String> { ApexConstants.LoggerResource, ApexConstants.ExceptionHandler};
		// our factory
		IApexFactory factory = new ApexObjectFactory();


		Test.startTest();
		// iterate over known list
		for (String fqn : myFQN) {
			// assertion
			ApexObjectFactoryTest.assertion(fqn, factory);
		}
		Test.stopTest();
	} // end of testCreateItems
	/**
	 * @brief Test adding and creating items to the factory
	 * @description Test adding and creating items to the factory
	 */
	@isTest static void testAddItems() {
		// arrange
		IApexFactory factory = new ApexObjectFactory();
		Map<String, Type> myNames = new Map<String, Type> {
			'defaultLogger' => ApexLogger.class,
			'exceptionDeal' => ApexExceptionHandler.class
		};

		// act
		Test.startTest();
		for (String key : myNames.keySet()) {
			// add our types
			factory.add(key, myNames.get(key));

		}
		// assert
		for (String name : myNames.keySet()) {
			// assertion
			ApexObjectFactoryTest.assertion(name, factory);
		}
		Test.stopTest();
	} // end of testAddItems
	/**
	 * @brief  Test creating items  by namespace from the factory
	 * @description Test creating items  by namespace from the factory
	 */
	@isTest static void testCreateItemsWithNamespace() {
		// arrange
		IApexFactory factory = new ApexObjectFactory();
		Map<String, Type> myNames = new Map<String, Type> {
			'defaultLogger' => ApexLogger.class,
			'exceptionDeal' => ApexExceptionHandler.class
		};

		// act
		Test.startTest();
		for (String key : myNames.keySet()) {
			// add our types
			factory.add(key, myNames.get(key));

		}

		// assert

		for (String name : myNames.keySet()) {
			// assertion
			ApexObjectFactoryTest.assertionWithNamespace(name, factory);
		}
		Test.stopTest();
	} // end of testCreateItemsWithNamespace
	/**
	 * @brief Test creating items  by type from the factory
	 * @description Test creating items  by type from the factory
	 */
	@isTest static void testCreateItemsWithType() {
		// arrange
		IApexFactory factory = new ApexObjectFactory();
		Map<String, Type> myNames = new Map<String, Type> {
			'defaultLogger' => ApexLogger.class,
			'exceptionDeal' => ApexExceptionHandler.class
		};

		// act
		Test.startTest();
		for (String key : myNames.keySet()) {
			// add our types
			factory.add(key, myNames.get(key));

		}

		// assert

		for (String name : myNames.keySet()) {
			// assertion
			ApexObjectFactoryTest.assertionWithType((Type)myNames.get(name), factory);
		}
		Test.stopTest();
	} // end of testCreateItemsWithType
	/**
	 * @brief make an assertion
	 * @description make an assertion
	 *
	 * @param name lookup string
	 * @param factory IApexFactory
	 * @return true if the assertion was correct
	 */
	private static Boolean assertion(String name, IApexFactory factory) {
		// act
		Object result = factory.create(name);
		// assert
		return AssertsTestUtility.notEquals(result , null);
	}// end of assertion
	/**
	 * @brief make an assertion with namespace
	 * @description make an assertion with namespace
	 *
	 * @param name lookup string
	 * @param factory IApexFactory
	 * @return true if the assertion was correct
	 */
	private static Boolean assertionWithNamespace(String name, IApexFactory factory) {
		// act
		Object result = factory.create('', name);
		// assert
		return AssertsTestUtility.notEquals(result , null);
	}// end of assertionWithNamespace
	/**
	* @brief make an assertion with Type
	* @description make an assertion with Type
	*
	* @param name lookup string
	* @param factory IApexFactory
	* @return true if the assertion was correct
	*/
	private static Boolean assertionWithType(Type name, IApexFactory factory) {
		// act
		Object result = factory.create(name);
		// assert
		return AssertsTestUtility.notEquals(result , null);
	}// end of assertionWithType
} // end of ApexObjectFactoryTest
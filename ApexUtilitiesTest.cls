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
 * @brief Test class for the  ApexUtilities methods
 * @description  Test class for the  ApexUtilities methods
 */
@isTest
private class ApexUtilitiesTest {


	/**
	 * @brief Test a valid class name
	 * @description Test a valid class name
	 */
	@isTest static void testgetClassName() {
		//assign
		String expected = 'ApexUtilities';
		ApexUtilities obj = new ApexUtilities();

		String result = ApexUtilities.getClassName(obj);
		// assert
		AssertsTestUtility.equals(expected, result);
	} // end of testgetClassName
	/**
	 * @brief Try a bad/invalid name
	 * @description Try a bad/invalid name
	 */
	@isTest static void testgetClassNameNull() {
		//assign
		String expected = '';
		String result = ApexUtilities.getClassName(null);
		// assert
		AssertsTestUtility.equals(expected, result);
	} // end of testgetClassNameNull
	/**
		 * @brief Try a bad/invalid name
		 * @description Try a bad/invalid name
		 */
	@isTest static void testnewGuid() {
		//assign
		String expected = ApexUtilities.newGuid();
		String result = ApexUtilities.newGuid();
		// assert
		AssertsTestUtility.notequals(expected, result);
	} // end of testnewGuid

	@isTest static void testformProviderNameAccess() {
		//assign
		String expected = 'DataCaching.All';
		String result = ApexUtilities.formProviderNameAccess(ApexConstants.DataCachingCS, ApexConstants.All_s);
		// assert
		AssertsTestUtility.notequals(expected, result);
	} // end of testformProviderNameAccess

	@isTest static void testgetNamespace() {
		//assign
		String known = 'DataCaching.All';
		String ns = ApexUtilities.getNamespace(known);
		// assert
		AssertsTestUtility.notequals(ApexConstants.DataCachingCS, ns);
	} // end of testgetNamespace

	@isTest static void testgetSection() {
		//assign
		String known = 'DataCaching.All';
		String ns = ApexUtilities.getSection(known);
		// assert
		AssertsTestUtility.notequals(ApexConstants.All_s, ns);
	} // end of testgetSection
} // end of ApexUtilitiesTest
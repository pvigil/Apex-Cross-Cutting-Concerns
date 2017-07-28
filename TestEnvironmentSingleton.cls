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
 * @author Salesforce
 * @date
 * @brief provide a [container] single source of truth for the test environment
 * @description provide a single source of truth for the test environment
 *
 */
public with sharing class TestEnvironmentSingleton extends ApexBaseRuntimeEnvironment {
	////////////////////////////////////////////////////////////////////////////////
	/// Data Members
	////////////////////////////////////////////////////////////////////////////////

	// our test environment
	private static TestEnvironmentSingleton classInstance ;
	////////////////////////////////////////////////////////////////////////////////
	/// Static Initializer
	////////////////////////////////////////////////////////////////////////////////
	/**
	 * @brief static initializer
	 * @details static initializer
	 */
	static {
		TestEnvironmentSingleton.classInstance = new TestEnvironmentSingleton();
	} // end  of static initializer

	////////////////////////////////////////////////////////////////////////////////
	/// Ctors
	////////////////////////////////////////////////////////////////////////////////
	/**
	 * @brief private ctor of the singleton
	 * @details private ctor of the singleton -- one instance
	 */
	private TestEnvironmentSingleton() {

	} // end of default ctor

	////////////////////////////////////////////////////////////////////////////////
	/// Public Methods
	////////////////////////////////////////////////////////////////////////////////

	/**
	 * @brief get the singleton instance of the environment
	 * @details get the singleton instance of the test environment
	 * @return ITestEnvironment
	 */
	public static IApexRunEnvironment getInstance() {
		return TestEnvironmentSingleton.classInstance;
	} // end of getInstance
	/**
	 * @brief object factory
	 * @details created the objects from the known list
	 * @return a factory to create objects
	 */
	public override IApexFactory objectFactory() {
		if ( this.theFactory == null ) {
			// default test factory, subject to change
			super.objectFactory(  new ApexTestObjectFactory());
		}
		return this.theFactory;
	}// end of objectFactory
	/**
	 * @brief get the configuration provider
	 * @details get the configuration provider; if none defined, return the default one
	 * @return IConfigurationProvider that allows access to test-related environment (i.e. soft-assertion is on, etc)
	 */
	public override IConfigurationProvider provider() {
		if ( this.theProvider == null) {
			// this is the default provider -- subject to change
			super.provider( (IConfigurationProvider) this.objectFactory().create(ApexConstants.ConfigurationResource));
		}
		return  this.theProvider;
	}// end of provider
	/**
	* @brief getter - fallback resources
	* @details get fallback resources; if none defined, return the default one
	* @return IFallbackResources the fallback resource for test in the event the custtom setting/static resource is not present
	*/
	public override IFallbackResources fallbackResources() {
		if ( this.theResource == null) {
			// this is the default logger, subject to change
			super.fallbackResources((IFallbackResources) this.objectFactory().create(ApexTestUtilities.FallbackTestResource));
		}
		return  this.theResource;
	} // end of fallbackResources
} // end of TestEnvironmentSingleton
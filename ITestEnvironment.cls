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
 * @brief Provides the defined interfaces used in the test environment
 * @description Provides the defined interfaces used in the test environment. This includes a configuraiton provider, logger, etc.
 */
public virtual interface ITestEnvironment {
	/**
	 * @brief get factory that creates the test objects
	 * @description A factory to create the cross-cutting concerns used in the tests
	 * @return IApexFactory test factory creator
	 */
	IApexFactory objectFactory();
	/**
	 * @brief get the configuration provider
	 * @description get the configuration provider; if none defined, return the default one
	 * @return IConfigurationProvider that allows access to test-related environment (i.e. soft-assertion is on, etc)
	 */
	IConfigurationProvider provider();
	/**
	 * @brief getter - our logger
	 * @description get the logger; if none defined, return the default one
	 * @return [description]
	 */
	ILogger logger();
	/**
	 * @brief Fallback test resources
	 * @description Fallback test resources
	 * @return IFallbackResources that provide  values to drive tests
	 */
	IFallbackResources fallbackResources();
		/**
	* @brief Exception handler
	* @description Exception handler
	* @return IApexExceptionHandler that provide handling of the exception consistently (based on policy)
	*/
	IApexExceptionHandler exceptionhandler();
	/**
	 * @brief for caching information
	 * @description for caching information
	 * @return ICache
	 */
	ICache cache();
	/**
	 * @brief previous transaciton result
	 * @description previous transaciton result
	 * @return IPreviousTransactionResult
	 */
	IPreviousTransactionResult transactionResult();
	/**
	 * @brief set the configuration provider
	 * @description set the configuration provider
	 *
	 * @param provider the configuration provider
	 */
	void provider(IConfigurationProvider provider);
	/**
	 * @brief set the logger
	 * @description set the logger
	 *
	 * @param logger the logger
	 */
	void logger(ILogger logger);
	/**
	 * @brief creates the test objects
	 * @description A factory to create the cross-cutting concerns used in the tests
	 *
	 * @param factory IApexFactory
	 */
	void  objectFactory(IApexFactory factory);
	/**
	 * @brief sets the fallback resources
	 * @description sets the fallback resources that provide  values to drive tests
	 *
	 * @param resources IFallbackResources that provide  values to drive tests
	 */
	void  fallbackResources(IFallbackResources resources);
	/**
	* @brief set Exception handler
	* @description set Exception handler
	* @param IApexExceptionHandler that provide handling of the exception consistently (based on policy)
	*/
	void  exceptionhandler(IApexExceptionHandler handler);
	/**
	 * @brief set cache handler
	 * @description set cache handler
	 * 
	 * @param transacitonResult ICache
	 */
	void cache(ICache runTimeCache);
	/**
	 * @brief set previous transaciton result
	 * @description set previous transaciton result
	 * 
	 * @param transacitonResult IPreviousTransactionResult
	 */
	void  transactionResult(IPreviousTransactionResult transacitonResult);
} // end of ITestEnvironment
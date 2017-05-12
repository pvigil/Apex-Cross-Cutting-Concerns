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
 * @brief Implementation of apex runtime environment
 * @description Implementation of the apex runtime environment for cross-cutting concerns. This class is a convience
 * 			class as these values can be extracted from the factory, if so loaded.
 * 	@group Common Layer
 *
 */
public virtual without sharing class  ApexBaseRuntimeEnvironment implements IApexRunEnvironment {

	////////////////////////////////////////////////////////////////////////////////
	/// Data Members
	////////////////////////////////////////////////////////////////////////////////

	// data members are made static as they are not likely to change and save in
	// the cost of construction/destruction
	//

	private static IApexFactory aFactory;
	private static IConfigurationProvider aProvider;
	private static ILogger aLogger;
	private static IFallbackResources aResource;
	private static IApexExceptionHandler anExceptionHandler;
	private static ICache aCache;
	private static IPreviousTransactionResult aTransactionResult;

	////////////////////////////////////////////////////////////////////////////////
	/// Ctors
	////////////////////////////////////////////////////////////////////////////////
	/**
	 * @brief private ctor of the singleton
	 * @description private ctor of the singleton -- one instance
	 */
	public ApexBaseRuntimeEnvironment() {

	} // end of default ctor
	////////////////////////////////////////////////////////////////////////////////
	/// Public Methods
	////////////////////////////////////////////////////////////////////////////////

	/**
	 * @brief object factory
	 * @description created the objects from the known list
	 * @return a factory to create objects
	 */
	public virtual IApexFactory objectFactory() {
		if ( ApexBaseRuntimeEnvironment.aFactory == null ) {
			// default  factory, subject to change
			ApexBaseRuntimeEnvironment.aFactory = new ApexObjectFactory();
		}
		return ApexBaseRuntimeEnvironment.aFactory;
	}// end of objectFactory
	/**
	 * @brief get the configuration provider
	 * @description get the configuration provider; if none defined, return the default one
	 * @return IConfigurationProvider that allows access to runtime-related environment (i.e. soft-assertion is on, etc)
	 */
	public virtual IConfigurationProvider provider() {
		if ( ApexBaseRuntimeEnvironment.aProvider == null) {
			// this is the default provider -- subject to change
			ApexBaseRuntimeEnvironment.aProvider = (IConfigurationProvider)this.objectFactory().create(ApexConstants.ConfigurationResource);
		}
		return  ApexBaseRuntimeEnvironment.aProvider;
	}// end of provider
	/**
	 * @brief getter - where to log message
	 * @description get the logger; if none defined, return the default one
	 * @return ILogger
	 */
	public virtual ILogger logger() {

		if ( ApexBaseRuntimeEnvironment.aLogger == null) {
			// this is the default logger, subject to change
			ApexBaseRuntimeEnvironment.aLogger = (ILogger) this.objectFactory().create(ApexConstants.LoggerResource);

		}
		return  ApexBaseRuntimeEnvironment.aLogger;
	} // end of logger
	/**
	 * @brief getter - fallback resources
	 * @description get fallback resources; if none defined, return the default one
	 * @return IFallbackResources the fallback resource
	 */
	public virtual IFallbackResources fallbackResources() {
		if ( ApexBaseRuntimeEnvironment.aResource == null) {
			// this is the default fallback resource, subject to change
			ApexBaseRuntimeEnvironment.aResource = (IFallbackResources) this.objectFactory().create(ApexConstants.FallbackResource);

		}
		return  ApexBaseRuntimeEnvironment.aResource;
	} // end of fallbackResources
	/**
	* @brief Exception handler
	* @description Exception handler
	* @return IApexExceptionHandler that provide handling of the exception consistently (based on policy)
	*/
	public virtual IApexExceptionHandler exceptionHandler() {
		if ( ApexBaseRuntimeEnvironment.anExceptionHandler == null) {
			// this is the default exception handler, subject to change
			ApexBaseRuntimeEnvironment.anExceptionHandler = (IApexExceptionHandler) this.objectFactory().create(ApexConstants.ExceptionHandler);

		}
		return  ApexBaseRuntimeEnvironment.anExceptionHandler;
	} // end of exceptionHandler
	/**
	 * @brief cahce
	 * @detail cache
	 * @return ICache
	 */
	public virtual ICache cache() {
		if ( ApexBaseRuntimeEnvironment.aCache == null) {
			// this is the default cache, subject to change
			ApexBaseRuntimeEnvironment.aCache = (ICache) this.objectFactory().create(ApexConstants.CacheResource);

		}
		return  ApexBaseRuntimeEnvironment.aCache;
	} // end of cache

		/**
	 * @brief cahce
	 * @detail cache
	 * @return ICache
	 */
	public virtual IPreviousTransactionResult transactionResult() {
		if ( ApexBaseRuntimeEnvironment.aTransactionResult == null) {
			// this is the default cache, subject to change
			ApexBaseRuntimeEnvironment.aTransactionResult = (IPreviousTransactionResult) this.objectFactory().create(ApexConstants.PreviousTransactionResultResource);

		}
		return  ApexBaseRuntimeEnvironment.aTransactionResult;
	} // end of transactionResult
	//////////////////////////////////////////////////////////////////////
	// Setters
	//////////////////////////////////////////////////////////////////////
	/**
	 * @brief set the configuration provider
	 * @description set the configuration provider
	 *
	 * @param provider the configuration provider
	 */
	public  void provider(IConfigurationProvider provider) {
		ApexBaseRuntimeEnvironment.aProvider = provider;
	} // end of provider
	/**
	 * @brief set the logger
	 * @description set the logger
	 *
	 * @param logger the logger
	 */
	public void logger(ILogger logger) {
		ApexBaseRuntimeEnvironment.aLogger = logger;
	} // end of logger
	/**
	 * @brief factory to create  objects used
	 * @description factory to create  objects used
	 *
	 * @param factory creates test related objects
	 */
	public void objectFactory(IApexFactory factory) {
		ApexBaseRuntimeEnvironment.aFactory = factory;
	} // end of objectFactory
	/**
	  * @brief sets the fallback resources that provide  values to drive tests
	  * @description sets the fallback resources that provide  values to drive tests
	  *
	  * @param resources creates  related fallback resources
	  */
	public void fallbackResources(IFallbackResources resources) {
		ApexBaseRuntimeEnvironment.aResource = resources;
	} // end of fallbackResources
	/**
	 * @brief sets the fallback resources that provide  values to drive tests
	 * @description sets the fallback resources that provide  values to drive tests
	 *
	 * @param handler defines how to handle and exception
	 */
	public void exceptionHandler(IApexExceptionHandler handler) {
		ApexBaseRuntimeEnvironment.anExceptionHandler = handler;
	} // end of fallbackResources
	/**
	 * @brief set the cache
	 * @description set the cache
	 *
	 * @param cache ICache
	 */
	public void cache(ICache cache) {
		ApexBaseRuntimeEnvironment.aCache = cache;
	} // end of cache
	/**
	 * @brief previous transacton result
	 * @description previous transacton result
	 * 
	 * @param result IPreviousTransactionResult
	 */
	public void  transactionResult( IPreviousTransactionResult result) {
		 ApexBaseRuntimeEnvironment.aTransactionResult = result;
	} // end of thePreviousTransactionResult
	
	////////////////////////////////////////////////////////////////////////////////
	/// Protected  Properties
	////////////////////////////////////////////////////////////////////////////////


	// NOTE: (Ugly Hack)
	//
	// The properties below were a hack to allow a child class that is a Singleton
	// access to the private static resources. Unfortunately, a child which is a singleton
	// does not retain a single copy if used in more than one method ( verified via tests).
	// As such, to avoid the new/delete lifecycle, the values were made static and access to children
	// was provided via the properties below
	//

	//
	// Just return the current factory
	//
	protected IApexFactory theFactory {
		get { return ApexBaseRuntimeEnvironment.aFactory; }
	} // end of theFactory
	//
	// Just return the current resource
	//
	protected IFallbackResources theResource {
		get { return ApexBaseRuntimeEnvironment.aResource; }
	} // end of theResources
	//
	// Just return the current exception handler
	//
	protected IApexExceptionHandler theExceptionHandler {
		get { return ApexBaseRuntimeEnvironment.anExceptionHandler; }
	} // end of theExceptionHandler
	//
	// Just return the current provider
	//
	protected IConfigurationProvider theProvider {
		get { return ApexBaseRuntimeEnvironment.aProvider; }
	} // end of theProvider
	//
	// Just return the current logger
	//
	protected ILogger theLogger {
		get { return ApexBaseRuntimeEnvironment.aLogger; }
	} // end of theLogger
	//
	// Just return the current cache
	//
	protected ICache theCache {
		get { return ApexBaseRuntimeEnvironment.aCache ;}
	} // end of theCache
	//
	// Just return the previous transacton result
	//
	protected IPreviousTransactionResult thePreviousTransactionResult {
		get { return ApexBaseRuntimeEnvironment.aTransactionResult ;}
	} // end of thePreviousTransactionResult

} // end of ApexBaseRuntimeEnvironment
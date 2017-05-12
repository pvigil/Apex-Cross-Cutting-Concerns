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
 * Encapsulates all behaviour logic relating to the custom settings
 *
 * For more guidelines and details see
 *   https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Domain_Layer
 * @group Domain Layer
 **/
public virtual class VirtualCustomSettings implements IConfigurationProvider {


	// Explicit no argument constructor
	public VirtualCustomSettings() {
	}

	/**
	* @brief load configuration
	* @description load the configuration
	* @return true, if the configuration was loaded
	*/
	public virtual Boolean load() {
		return true;
	} // end of load
	/**
	 * @brief get a item (must be cast)
	 * @description get a value based on the name from the <name,value> pair
	 *
	 * @param name key name
	 * @return object ( must be cast appropriately)
	 */
	public virtual Object get(String name) {
		return CustomSettings.getEntity(name);
	} // end of get


	/**
	 * @brief is All set for the data warehouse
	 * @description [long description]
	 * @return [description]
	 */
	public virtual Boolean isDataWareHouseTriggerOn() {
		return  CustomSettings.isDataWareHouseTriggerOn();
	} // end of isDataWareHouseTriggerOn


	/**
	 * @brief is the trigger enabled
	 * @description is the trigger enabled
	 *
	 * @param objectName String , name of object/class name
	 * @return true if enabled
	 */
	public virtual Boolean isTriggerEnabled(String objectName) {
		return  CustomSettings.isTriggerEnabled(objectName);
	} // end of isTriggerEnabled


	/**
	 * @brief Data caching on
	 * @description Data caching on
	 *
	 * @param objectName String
	 * @return DataCaching__c
	 */
	public virtual DataCaching__c caching (String objectName) {
		return  CustomSettings.caching(objectName);
	} // end of caching

	/**
	 * @brief Divisoion Code
	 * @description Division Code
	 * 
	 * @param divisionCode incoming Division code
	 * @return True, if excluded
	 */
	public virtual Boolean divisionIsExcluded(String divisionCode) {
		return CustomSettings.divisionIsExcluded(divisionCode);
	} // end of divisionIsExcluded
} // end of VirtualCustomSettings
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
 * @brief Custom settings information aka Configuration
 * @description Custom settings information aka Configuration
 * @group Common Layer
 */
public without sharing class CustomSettings implements IConfigurationProvider {

    //
    //++++++++++++++++++++++++++++++++++ Data members ++++++++++++++++++++++++++++++++++++++++++
    //

    /**
     * Divisions to ignore
     */
    private static String divisionsToIgnore = null;

    /**
     * List of supported objects (to be deprecated)
     */
    static Set<String> supportedSFObjects = new Set<String> {
        ApexConstants.ObjectName_Account
        , ApexConstants.ObjectName_Contact
        , ApexConstants.ObjectName_Opportunity
        , ApexConstants.ObjectName_Case
        , ApexConstants.ObjectName_Lead
        , ApexConstants.ObjectName_Plan
        , ApexConstants.ObjectName_Homesite
        , ApexConstants.ObjectName_Elevation
        , ApexConstants.All_s
    };

    //
    //++++++++++++++++++++++++++++++++++ Public methods ++++++++++++++++++++++++++++++++++++++++++
    //

    /**
     * @brief load configuration
     * @description load the configuration
     * @return true, if the configuration was loaded
     */
    public Boolean load() {
        return true;
    } // end of load

    /**
     * @brief get a item (must be cast)
     * @description get a value based on the name from the <name,value> pair
     *
     * @param name key name
     * @return object ( must be cast appropriately)
     */
    public Object get(String name) {
        return CustomSettings.getEntity(name);
    } // end of get

    /**
     * @brief is All set for the data warehouse
     * @description [long description]
     * @return [description]
     */
    public static Boolean isDataWareHouseTriggerOn() {
        return isTriggerEnabled(ApexConstants.All_s);
    } // end of isDataWareHouseTriggerOn

    /**
     * @brief is the trigger enabled
     * @description is the trigger enabled
     *
     * @param objectName String , name of object/class name
     * @return true if enabled
     */
    public static Boolean isTriggerEnabled(String objectName) {
        Boolean dataSyncOn = false;

        // is the data warehouse trigger sink on
        if ( objectName != null && supportedSFObjects.contains(objectName) ) {
            DWHouseSyncTrigger__c result = CustomSettings.findTriggerSync(objectName);
            if ( null != result ) {
                dataSyncOn = result.Data_Sync_On__c;
            }
        }

        return dataSyncOn;
    } // end of isTriggerEnabled

    /**
     * @brief Data caching on
     * @description Data caching on
     *
     * @param objectName String
     * @return DataCaching__c
     */
    public static DataCaching__c caching (String objectName) {
        DataCaching__c result = null;

        // is the data warehouse trigger sink on
        if ( objectName != null && supportedSFObjects.contains(objectName) ) {
            result = CustomSettings.findCache(objectName);
        } else {
            result = new DataCaching__c();
            result.CachingEnabled__c = false;
            result.TimeToLiveMS__c = 0;
        }

        return result;
    } // end of caching

    /**
     * @brief Migration Status for Trigger
     * @description Migration Status for trigger
     *
     * @param objectName String
     * @return True, if on
     */
    public static Boolean migrationRunTriggerOn () {
        Migration_Global_Setting__c result = CustomSettings.findMigrationSetting();

        // is the data warehouse trigger sink on
        if ( result == null ) {
            result = new Migration_Global_Setting__c();
            result.runtrigger__c = true;
        }

        return result.runtrigger__c;
    } // end of migrationRunTriggerOn

    /**
     * @brief determine if the division ie excluded
     * @details determine if the division ie excluded
     * 
     * @param divisionCode division code (JAX,ATL,SAN, ...)
     * @return True, if excluded
     */
    public static Boolean divisionIsExcluded(String divisionCode) {
        Boolean results = false;

        try {
            String ignoreDivisions = CustomSettings.getDivisionsToIgnore();

            if ( divisionCode != null
                    && divisionCode.length() > 0
                    && divisionsToIgnore != null
                    && divisionsToIgnore.length() > 0 ) {
                results = divisionsToIgnore.containsIgnoreCase(divisionCode);
            }
        } catch (Exception excp) {
            ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
        }

        return results;
    } // end of divisionIsExcluded

    /**
     * @brief Get the divisions to ignore from the configuration
     * @description Get the divisions to ignore from the configuration
     * @return the divisons to ignore
     */
    public static String getDivisionsToIgnore() {
        if ( CustomSettings.divisionsToIgnore == null ) {
            Migration_Global_Setting__c migrationSetting = CustomSettings.findMigrationSetting();
            CustomSettings.divisionsToIgnore = migrationSetting.Divisions_on_Hold__c;
        }

        return CustomSettings.divisionsToIgnore;
    } // end of getDivisionsToIgnore

    /**
     * @brief get an entiry based on our hierarchy
     * @description get an entiry based on our hierarchy
     *
     * @param value String
     * @return Object result
     */
    public static Object getEntity(String value) {
        String ns = ApexUtilities.getNamespace(value);
        String section = ApexUtilities.getSection(value);
        Object result = null;

        if ( ns != null && section != null ) {
            if ( ns.equals(ApexConstants.DataCachingCS) ) {
                result = CustomSettings.caching(section);
            } else if ( ns.equals(ApexConstants.DataWareHouseTriggerCS) ) {
                result = CustomSettings.isTriggerEnabled(section);
            }
        }

        return result;
    } // end of getEntity

    //
    //++++++++++++++++++++++++++++++++++ Private methods ++++++++++++++++++++++++++++++++++++++++++
    //

    /**
     * @brief Data Warehouse trigger on
     * @description Data Warehouse trigger on
     *
     * @param objectName String
     * @return DWHouseSyncTrigger__c
     */
    @TestVisible
    private static DWHouseSyncTrigger__c findTriggerSync(String objectName) {
        DWHouseSyncTrigger__c result = null;

        try {
            result = DWHouseSyncTrigger__c.getAll().get(objectName);
        } catch (Exception excp) {
            ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
        }

        return result;
    } // end of findTriggerSync

    /**
     * @brief Data caching on
     * @description Data caching on
     *
     * @param objectName String
     * @return Boolean
     */
    @TestVisible
    private static DataCaching__c findCache(String objectName) {
        DataCaching__c result = null;

        try {
            result = DataCaching__c.getAll().get(objectName);
        } catch (Exception excp ) {
            ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
        }

        return result;
    } // end of findCache

    /**
     * @brief get the migration global settings
     * @description get the migration global settings
     * @return Migration_Global_Setting__c
     */
    @TestVisible
    private static Migration_Global_Setting__c findMigrationSetting() {
        Migration_Global_Setting__c result = null;

        try {
            // get the Migration_Global_Setting__c based on the profile id
            Id profileId = userinfo.getProfileId();
            // get the row
            result = Migration_Global_Setting__c.getValues(profileId);
            // if not present, get the org defaults
            if ( result == null ) {
                result = Migration_Global_Setting__c.getOrgDefaults();
            }
        } catch (Exception excp) {
            ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
        }

        return result;
    } // end of findMigrationSetting

} // end of CustomSettings
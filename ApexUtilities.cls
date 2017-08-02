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
 * @brief Apex Utilities
 * @description common utilities
 * @group Common Layer
 */
public virtual with sharing class ApexUtilities {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    private static  Map<String, String> sObjectInformation = new Map<String, String> {
        'Account' => 'Name'
        , 'Attached_Documents__c' => 'Name'
        , 'Business_Unit_User__c' => 'Name'
        , 'Business_Unit__c' => 'Name'
        , 'Case' => 'CaseNumber'
        , 'Contact' => 'FirstName,LastName'
        , 'Customer_Addresses__c' => 'Name'
        , 'dsfs__DocuSign_Status__c' => 'Name'
        , 'Elevation__c' => 'Name'
        , 'Event' => 'ClientGuid'
        , 'Homesite__c' => 'Name'
        , 'Interaction_History__c' => 'Name'
        , 'Lead' => 'Name'
        , 'Milestone_History__c' => 'Name'
        , 'Opportunity' => 'Name'
        , 'Payment__c' => 'Name'
        , 'Plan_Item__c' => 'Name'
        , 'Plan__c' => 'Name'
        , 'Task' => 'Subject'
    };

    // simple mechanism to cache last id
    static String lastProfileName = null;
    static Id lastProfileId = null;
    // are we executing in a sandbox
    static Boolean isSandboxBool = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;


    ////////////////////////////////////////////////////////////////////////////////
    /// Public Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
	 * @brief is sandbox
	 * @details is sandbox
	 * @return true, if sandbox
	 */
	public static Boolean IsSandbox() {
		return isSandboxBool;
	}
    /**
     * @brief Get a Method name from 'this'
     * @description Method Name of the caller
     *
     * @param thisClass the object
     * @return String - Method name
     */
    public static String getClassName(Object thisClass) {
        String currentClassName = ApexConstants.EmptyString;

        if ( thisClass != null ) {
            List<String> items = String.valueOf(thisClass).split(ApexConstants.ColonDelimiter);
            if ( items.size() > 0 ) {
                currentClassName = items[0];
            }
        }

        return currentClassName;
    } // end of getClassName

    /**
     * @brief get the name of the sobject
     * @description get the name of the sobject
     *
     * @param mySobject SObject
     * @return String - name of the sobject
     */
    public static String getSobjectName(SObject mySobject) {
        return mySobject != null ? mySobject.getsObjectType().getDescribe().getName() : ApexConstants.EmptyString;
    } // end of getSobjectName

    /**
     * @brief get the appropriate field name/identifier from the sObject
     * @details get the appropriate field name/identifier from the sObject
     *
     * @param sobj SObject
     * @return value of field identifier of sobject
     */
    public static String getFieldNameFromSObjectForMigrationCheck(SObject sobj) {
        String result = ApexConstants.EmptyString;

        if ( sobj != null ) {
            String sObjectType = ApexUtilities.getSobjectName(sobj);
            String fieldName = sObjectInformation.get(sObjectType);

            result = ApexUtilities.iterateOverFieldNamesInSObject(sobj, fieldName);
        }

        return result == null ? ApexConstants.EmptyString : result;
    } // end of getFieldNameFromSObjectForMigrationCheck

    /**
     * @brief get the name value pair object
     * @description get the name value pair object if that is the right type
     *
     * @param payload the ApexMessagePayload
     * @return Attempt to get the underlying message payload type by converting; otherwise, null
     */
    public static NameValueObjectPair getNameValueFromPayload( ApexMessagePayload payload) {
        NameValueObjectPair nvop = null;

        if ( payload != null && payload.payload != null ) {
            nvop = (NameValueObjectPair)payload.payload;
        }

        return nvop;
    } // end of getNameValueFromPayload

    /**
     * @brief form the provder name for entity access
     * @decription form the provder name for entity access
     *
     * @param namespace String
     * @param section String
     *
     * @return String -- 'ns.section'
     */
    public static String formProviderNameAccess(String namespace, String section) {
        String ns = namespace == null ? ApexConstants.EmptyString : namespace;
        String sct = section == null ? ApexConstants.EmptyString : section;

        return ns + ApexConstants.ColonDelimiter + sct;
    } // end of formProviderNameAccess

    /**
     * @brief get namespace
     * @decription get namespace
     *
     * @param value String
     * @return String
     */
    public static String getNamespace(String value) {
        return ApexUtilities.getNamespace(value, ApexConstants.ColonDelimiter);
    } // end of getNamespace

    /**
     * @brief get namespace
     * @decription get namespace
     *
     * @param value String
     * @param delimiter String
     *
     * @return [description]
     */
    public static String getNamespace(String value, String delimiter) {
        return ApexUtilities.getSection(value, ApexConstants.ColonDelimiter, 0);
    } // end of getNamespace

    /**
     * @brief get namespace
     * @decription get namespace
     *
     * @param value String
     * @return String
     */
    public static String getSection(String value) {
        return ApexUtilities.getSection(value, ApexConstants.ColonDelimiter, 1);
    } // end of getSection

    /**
     * @brief get namespace
     * @decription get namespace
     *
     * @param value String
     * @param delimiter String
     *
     * @return [description]
     */
    public static String getSection(String value, String delimiter, Integer index) {
        String result = null;

        if ( !String.isBlank(value) ) {
            List<String> items = value.split(delimiter);
            if ( items.size() > index ) {
                result = items[index];
            }
        }

        return result;
    } // end of getSection

    /**
     * @brief Unique Guid
     * @decription Unique Guid
     * @return String unique
     */
    public static String newGuid() {
        Blob crytoBlob = Crypto.GenerateAESKey(128);
        return EncodingUtil.ConvertTohex(crytoBlob);
    } // end of newGuid

    /**
     * @brief to string
     * @description get the string of the value
     *
     * @param obj object you want the string value
     * @return string value of object
     */
    public static String toString(Object obj) {
        return ApexUtilities.toString(obj, ApexConstants.EmptyString);
    } // end of toString

    /**
     * @brief to string
     * @description get the string of the value
     *
     * @param obj object you want the string value
     * @param defaultValue default string value
     * @return string value of object
     */
    public static String toString(Object obj, String defaultValue) {
        String result = defaultValue;

        if ( obj != null ) {
            result = String.valueOf(obj);
        }

        return result == null ? ApexConstants.EmptyString : result;
    } // end of toString

    /**
     * @brief convert a maps of ids to a list of ids
     * @description convert a maps of ids to a list of ids
     *
     * @param mapOfIds Map<Id,SObject>
     * @return List<Id>
     */
    public static List<Id> convertMapOfIdsToListOfIds(Map<Id, SObject> mapOfIds) {
        List<Id> idList = new List<Id>();

        if ( mapOfIds != null && mapOfIds.size() > 0 ) {
            idList.addAll(mapOfIds.keyset());
        }

        return idList;
    } // end of convertMapOfIdsToListOfIds

    /**
     * @brief convert a maps of values to a list of values
     * @description convert a maps of values to a list of values
     *
     * @param mapOfIds Map<Id,SObject>
     * @return List<SObject>
     */
    public static List<SObject> convertMapOfValuesToListOfValues(Map<Id, SObject> mapOfValues) {
        List<SObject> valueList = new List<SObject>();

        if ( mapOfValues != null && mapOfValues.size() > 0 ) {
            valueList.addAll(mapOfValues.values());
        }

        return valueList;
    } // end of convertMapOfValuesToListOfValues

    /**
     * @brief safe field extaction from sobject
     * @details safe field extaction from sobject
     *
     * @param sobj SObject
     * @param fieldName
     *
     * @return [description]
     */
    public static String getFieldFromSObjectSafe(SObject theSObject, String fieldName) {
        String result = ApexConstants.EmptyString;

        try {
            result = (String)theSObject.get(fieldName);
        } catch (Exception excp) {
            system.debug('getFieldFromSObjectSafe excp=' + excp.getMessage());
        }

        return result;
    } // end of getFieldFromSObjectSafe

    /**
     * @brief Get the user's profile name
     * @details Get the user's profile name
     * @return profile string name
     */
    public static String userProfileName() {
        Id profileId = userinfo.getProfileId();

        if ( lastProfileId != profileId ) {
            lastProfileName = [Select Id, Name from Profile where Id = :profileId].Name;
            lastProfileId = profileId;
        }

        return lastProfileName == null ? ApexConstants.EmptyString : lastProfileName ;
    } // end of userProfileName

    /**
     * @brief Is the user Datawarehouse system admin
     * @details Is the user Datawarehouse system admin
     * @return True, if the user Datawarehouse system admin
     */
    public static Boolean IsDataWarehouseSysAdmin() {
        return ApexUtilities.userProfileName() == ApexConstants.DataWareHouseSystemAdminName;
    } // end of IsDataWarehouseSysAdmin

    /**
     * @brief iterate over field names getting value from the SOBject
     * @details iterate over field names getting value from the SOBject
     *
     * @param sobj SObject
     * @param fieldName fields (comma separate, perhaps)
     *
     * @return [description]
     */
    public static String iterateOverFieldNamesInSObject(SObject sobj, String fieldName) {
        String result = ApexConstants.EmptyString;

        if ( fieldName != null && sobj != null ) {
            List<String> fields = fieldName.split(ApexConstants.CommaDelimiter);
            Integer sz = fields.size();
            for (String item : fields ) {
                // get the name of the sobject, if any
                result += ApexUtilities.getFieldFromSObjectSafe(sobj, item);
                if ( sz > 0 ) {
                    result += ' ';
                }
            } // endfor
        } // endif

        return result;
    } // end of iterateOverFieldNamesInSObject

    /**
     * @brief Get the sub field from an SObject
     * @details Get the sub field from an SObject
     *
     * @param sObj [description]
     * @param field [description]
     *
     * @return [description]
     */
    public static Object getSubFieldValueFromSObject(SObject sObj, String field) {
        Object results = null;

        try {
            if ( sObj != null ) {
                if ( field.contains(ApexConstants.Period) ) {
                    String nextField = field.substringAfter(ApexConstants.Period);
                    String relation = field.substringBefore(ApexConstants.Period);
                    results = ApexUtilities.getSubFieldValueFromSObject((SObject)sObj.getSObject(relation), nextField);
                } else {
                    results = sObj.get(field);
                }
            }
        } catch (Exception excp) {
            ApexRunEnvironmentSingleton.getInstance().logger().debug('ApexUtilities.getSubFieldValueFromSObject Exception: ' + excp.getMessage());
        }

        return results;
    } // end of getSubFieldValueFromSObject

} // end of ApexUtilities

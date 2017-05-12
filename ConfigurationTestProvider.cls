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
 * @description This class provides access to static resource for testing. The resource
 * is used to determine if we use soft-assertions and if we are testing a particular method.
 *
*/

public class ConfigurationTestProvider implements IConfigurationProvider {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    // our static resource
    private static final List<StaticResource> staticResources = [SELECT Body FROM StaticResource WHERE Name = 'TestUtilityData' LIMIT 1];
    // our class used to map name-value pairs
    private static StaticTestDataJSON mapping = null;

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctor
    ////////////////////////////////////////////////////////////////////////////////
    /**
     * @brief default ctor
     * @description default ctor
     */
    public ConfigurationTestProvider() {

    } // end of ctor
    ////////////////////////////////////////////////////////////////////////////////
    /// Public Methods
    ////////////////////////////////////////////////////////////////////////////////
    /**
     * @brief load the resource
     * @description load the custom setting resource
     * @return true, if loaded
     */
    public Boolean load() {
        if ( mapping == null ) {
            if ( staticResources.size() == 0) {
                ConfigurationTestProvider.mapping = this.getFallbackResource();
            } else {
                ConfigurationTestProvider.mapping = (StaticTestDataJSON) JSON.deserialize(staticResources[0].Body.toString()
                        , StaticTestDataJSON.class);
            }
        }
        return mapping != null;
    } // end of load
    /*
    * @description Find the <name,value> pair of static resources. Controls
    *              the tests and soft-asserts.
    *
    */

    public  Object get( String name) {

        if ( !this.load()) {
            return null;
        }

        String result = '';
        try {
            // is there a resource
            if ( ConfigurationTestProvider.mapping != null ) {
                result = ConfigurationTestProvider.mapping.KeyValuePair.get(name);
            }
        } catch (Exception excp) {
            TestEnvironmentSingleton.getInstance().logger().write('\nEXCEPTION in get :' + excp.getMessage());
        }
        return result;

    } // end of get
    ////////////////////////////////////////////////////////////////////////////////
    /// Private Methods
    ////////////////////////////////////////////////////////////////////////////////
    /**
    * @brief get fallback resources
    * @description get fallback resources
    * @return StaticTestDataJSON
    */
    private StaticTestDataJSON getFallbackResource() {
        StaticTestDataJSON resource = null;
        try {
            resource = new StaticTestDataJSON();

            IFallbackResources fallback = TestEnvironmentSingleton.getInstance().fallbackResources();
            resource.KeyValuePair = fallback.toMap();
        } catch (Exception excp) {
            TestEnvironmentSingleton.getInstance().logger().write('\nEXCEPTION in getFallbackResource :' + excp.getMessage());
        }

        return resource;
    } // end of getFallbackResource
}// end of ConfigurationTestProvider
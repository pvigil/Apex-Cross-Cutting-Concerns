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
 * @description Name/Value pair for the fallback resources
 */
@isTest
public class ApexTestJSONDataFallback implements IFallbackResources {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * Define the fallback resources, we want to use soft-asserts
     */
    private static final String DefaultStaticResource = '{' +
            '"SoftAssert" : "on" ' +
            '}';
    private String defaultResource;

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctor
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief default ctor
     * @description ctor
     */
    public ApexTestJSONDataFallback() {
        this.defaultResource = ApexTestJSONDataFallback.DefaultStaticResource;
    } // end of ctor

    ////////////////////////////////////////////////////////////////////////////////
    /// Public Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief  ctor
     * @description ctor
     */
    public ApexTestJSONDataFallback(String defaultValue) {
        this.defaultResource = defaultValue;

        if ( String.isBlank(this.defaultResource) ) {
            this.defaultResource = ApexTestJSONDataFallback.DefaultStaticResource;
        }
    } // end of ctor

    /**
     * @brief Get Fallback Resources
     * @description Get Fallback Resources
     * @return Object - fallback resource
     */
    public Object fallbackResource() {
        return this.defaultResource ;
    } // end of fallbackResource

    /**
     * @brief get fallback resource as a string
     * @description get fallback resource as a string
     * @return get fallback resource as a string
     */
    public override String toString() {
        return this.defaultResource ;
    } // end of toString

    /**
     * @brief get fallback resource as a Map<String,String>
     * @description get fallback resource as a Map<String,String>
     * @return get fallback resource as a Map<String,String>
     */
    public Map<String, String> toMap() {
        Map<String, String> dataPair;

        try {
            TestEnvironmentSingleton.getInstance().logger().write('\n*** USING Fallback Resources in ApexTestJSONDataFallback.toMap : Salesforce StaticResource not found "' + ApexTestUtilities.CustomResourceNameInSalesforce + '" ***');
            dataPair = (Map<String,String>) JSON.deserialize(this.toString() , Map<String,String>.class);
        } catch (Exception excp) {
            TestEnvironmentSingleton.getInstance().logger().write('\n*** EXCEPTION in ApexTestJSONDataFallback.toMap :' + excp.getMessage() + ' ***');
        }
        return dataPair;
    } // end of toMap

} // end of ApexTestJSONDataFallback
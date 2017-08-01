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
 * @brief Test Utilities
 * @description common test utilities
 */
public with sharing class ApexTestUtilities extends ApexUtilities {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    public static final String AssertResource = 'Asserts';
    public static final String FallbackTestResource = 'FallbackTestResource';
    public static final String CustomResourceNameInSalesforce = 'TestUtilityData';
    public static final String AttributeIsOn = 'on';
    public static final String AttributeIsOff = 'off';
    public static final String AttributeSoftAssert = 'SoftAssert';

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctors
    ////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////
    /// Public Methods
    ////////////////////////////////////////////////////////////////////////////////

    //
    // is it a provider
    //
    public static Boolean isProvider(Object obj) {
        try {
            IConfigurationProvider isConfig = (IConfigurationProvider) obj;

            if ( isConfig != null ) {
                return true;
            }
        } catch (Exception excp) {}

        return false;
    } // end of isProvider

    //
    // is it a logger
    //
    public static Boolean isLogger(Object obj) {
        try {
            ILogger isLogger = (ILogger)obj;

            if ( isLogger != null ) {
                return true;
            }
        } catch (Exception excp) {}

        return false;
    } // end of isLogger

    //
    // is a fallback resource
    //
    public static Boolean isFallback(Object obj) {
        try {
            IFallbackResources fb = (IFallbackResources)obj;

            if ( fb != null ) {
                return true;
            }
        } catch (Exception excp) {}

        return false;
    } // end of isFallback

    //
    // is a factory
    //
    public static Boolean isFactory(Object obj) {
        try {
            IApexFactory factory = (IApexFactory)obj;

            if ( factory != null ) {
                return true;
            }
        } catch (Exception excp) {}

        return false;
    } // end of isFactory

    //
    // is a exception handler
    //
    public static Boolean isExceptionHandler(Object obj) {
        try {
            IApexExceptionHandler handler = (IApexExceptionHandler)obj;

            if ( handler != null ) {
                return true;
            }
        } catch (Exception excp) {}

        return false;
    } // end of isExceptionHandler

    //
    // is a cache handler
    //
    public static Boolean isCache(Object obj) {
        try {
            ICache  handler = (ICache)obj;

            if ( handler != null ) {
                return true;
            }
        } catch (Exception excp) {}

        return false;
    } // end of isCache

    //
    // is a isPreviousTransactionResult handler
    //
    public static Boolean isPreviousTransactionResult(Object obj) {
        try {
            IPreviousTransactionResult handler = (IPreviousTransactionResult)obj;

            if ( handler != null ) {
                return true;
            }
        } catch (Exception excp) {}

        return false;
    } // end of isPreviousTransactionResult

} // end of ApexTestUtilities
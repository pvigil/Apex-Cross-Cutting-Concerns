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
 * @brief Creates singleton for ApexBaseRuntimeEnvironment
 * @description FCreates singleton for ApexBaseRuntimeEnvironment
 * @group Common Layer
 */
public with sharing class ApexRunEnvironmentSingleton extends ApexBaseRuntimeEnvironment {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    // our run environment
    private static ApexRunEnvironmentSingleton classInstance = null;

    ////////////////////////////////////////////////////////////////////////////////
    /// Static Initializer
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief static initializer
     * @description static initializer
     */
    static {
        ApexRunEnvironmentSingleton.classInstance = new ApexRunEnvironmentSingleton();
    } // end  of static initializer

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctors
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief private ctor of the singleton
     * @description private ctor of the singleton -- one instance
     */
    private ApexRunEnvironmentSingleton() {

    } // end of default ctor

    /**
     * @brief get the singleton instance of the environment
     * @description get the singleton instance of the test environment
     * @return ITestEnvironment
     */
    public static IApexRunEnvironment getInstance() {
        return ApexRunEnvironmentSingleton.classInstance;
    } // end of getInstance

} // end of ApexRunEnvironmentSingleton
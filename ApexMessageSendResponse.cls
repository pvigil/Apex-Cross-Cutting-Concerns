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
 * @brief Message sent response
 * @description SMessage sent response
 * @group Common Layer
 */
global with sharing class ApexMessageSendResponse {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    // object specific response
    private Object theResponse;
    // the exception, if any
    private Exception theException;

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctors
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief ctor
     * @description ctor
     * 
     * @param response object specific response ( must be cast)
     * 
     */
    public ApexMessageSendResponse(Object response) {
        this.theException = null;
        this.theResponse = response;
    } // end of ctor

    /**
     * @brief ctor
     * @description ctor
     * 
     * @param response object specific response ( must be cast)
     * @param excp the exception, if any
     * 
     */
    public ApexMessageSendResponse(Object response, Exception excp) {
        this.theException = excp;
        this.theResponse = response;
    } // end of ctor

    ////////////////////////////////////////////////////////////////////////////////
    /// Public Members
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief the response
     * @description the response ( must be casted appropriately)
     * @return Object
     */
    public Object getResponse() {
        return this.theResponse;
    } // end of getResponse

    /**
     * @brief the exception
     * @description the exception
     * @return Exception -- typically ApexApplicationException
     */
    public Exception getException() {
        return this.theException;
    } // end of getException

} // end of ApexMessageSendResponse
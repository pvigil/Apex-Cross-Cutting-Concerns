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
 * @brief Helper methods used by the selector layer (query)
 * @description Helper methods used by the selector layer (query)
 */
public without sharing class HelperForSelectors {

    /**
     * @brief mcreate a set condition from name and set type
     * @details mcreate a set condition from name and set type
     * 
     * @param byString String
     * @param setName String
     * 
     * @return String
     */
    public static String makeSetCondition(String byString, String setName) {
        return byString != null ? byString + ' in :' + setName : 'Id in :idSet';
    } // end of makeSetCondition

    /**
     * @brief verify condition
     * @details verify condition
     * 
     * @param byString [description]
     * @param setName [description]
     * @param stringIds [description]
     * @return [description]
     */
    public static String verifyCondition(String byString, String setName, Set<String> stringIds) {
        if ( stringIds == null || stringIds.size() == 0 ) {
            return null;
        }

        return HelperForSelectors.makeSetCondition(byString, setName);
    } // end of verifyCondition

    /**
     * @brief create a component SOQL statement
     * @details create a component SOQL statement
     * 
     * @param srcString1 [description]
     * @param srcString2 [description]
     * @param compound [description]
     * @return [description]
     */
    public static String makeCompondCondition(String srcString1, String srcString2, String compound) {
        if ( srcString1 == null  && srcString2 != null ) {
            return srcString2;
        } else if ( srcString2 == null && srcString1 != null ) {
            return srcString1;
        } else if ( srcString2 == null && srcString1 == null ) {
            return '';
        }

        return srcString1 + ApexConstants.WhitespaceString + compound + ApexConstants.WhitespaceString + srcString2;
    } // end of makeCompondCondition

}
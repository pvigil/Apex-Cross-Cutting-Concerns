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
 * Encapsulates all behaviour logic relating to the
 *
 * @author Salesforce
 * @date
 * @brief
 * @description For more guidelines and details see
 *     https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Domain_Layer
 * @group Domain Layer
 */
public class ApexLabelManager {

    public final static String Migrationlabel = 'lnrMigrationExclusionMessage';

    /**
     * @brief ctor
     * @description ctor
     *
     */
    public ApexLabelManager() {

    } // end of ctor

    /**
     * @brief Get the System Label Name
     * @details Get the System Label Name
     *
     * @param labelName the label name
     * @return the value of the label in the system
     */
    public static string getLabel(String labelName) {
        String result;

        try {
            // ARGH! need to find a dynamic way!
            if ( labelName == Migrationlabel ) {
                result = System.Label.lnrMigrationExclusionMessage;
            }
        } catch (Exception excp) {
            ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
        }

        return result;
    } // end of getLabel

    /**
     * @brief format the label string, if the label string requires fillers
     * @details format the label string, if the label string requires fillers
     *
     * @param placeholder the place holder
     * @param valueFillers values to filler into the placeholder
     *
     * @return [description]
     */
    public static string formatLabelString(String placeholder, List<String> valueFillers) {
        String formatted;

        try {
            formatted = String.format(placeholder, valueFillers);
        } catch (Exception excp) {
            ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
        }

        return formatted;
    } // end of formatLabelString

} // end of ApexLabelManager
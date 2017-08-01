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
 * @date 06/14/2016
 * @brief Send information via email
 * @description Send information via email
 * @group Common Layer
 *
 * TBD -- localization
 */
global without sharing class ApexMailMessageSender extends ApexBaseMessageSender {

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctor
    ////////////////////////////////////////////////////////////////////////////////
    public ApexMailMessageSender() {

    } // end of ctor

    ////////////////////////////////////////////////////////////////////////////////
    /// Public Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief Send information
     * @description Send information
     *
     * @param messagePayload broken into parts
     * @return ApexMessageSendResponse.
     */
    public override ApexMessageSendResponse send(ApexMessagePayload messagePayload) {
        ApexMessageSendResponse response = null;
        // first reset the state
        this.reset()

        if ( messagePayload != null ) {
            // Step 1: get the data
            List<String> sendTo = this.getRecipients(messagePayload);
            List<String> ccAddress = this.getCCAddresses(messagePayload);
            List<String> bccAddress = this.getBCCAddresses(messagePayload);
            String replyTo = this.getReply(messagePayload);
            String displayName = this.getDisplayName(messagePayload);
            String subject = this.getSubject(messagePayload);
            String body = this.getBody(messagePayload);
            // Step 2: valid data
            if ( sendTo == null || replyTo == null || displayName == null || subject == null || body == null ) {
                response = new ApexMessageSendResponse(null, this.sendException);
            } else {
                // Step 3: attempt to send
                response = this.sendmessagePayloadImpl(sendTo, ccAddress, bccAddress, replyTo, displayName, subject, body);
            }
        }

        return response;
    } // end of send

    ////////////////////////////////////////////////////////////////////////////////
    /// Private Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief reset state
     * @description  reset state -- set exception back to null
     */
    //private void reset() {
    //  this.sendException = null;
    //} // end of reset

    /**
     * @brief create and send email messagePayload
     * @description create and send email messagePayload
     *
     * @param sendTo whom to send to
     * @param ccAddress whom to CC
     * @param bccAddress whom to BCC
     * @param replyTo  whom to reply to
     * @param displayName email display name
     * @param subject email subject
     * @param body of email (html)
     * @return ApexMessageSendResponse
     */
    private ApexMessageSendResponse sendmessagePayloadImpl(List<String> sendTo
            , List<String> ccAddress
            , List<String> bccAddress
            , String replyTo
            , String displayName
            , String subject
            , String body) {
        Messaging.SendEmailResult[] result = null;

        try {
            // Create a new Email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            /// set email information
            mail.setToAddresses(sendTo);
            mail.setReplyTo(replyTo);
            mail.setSenderDisplayName(displayName);
            mail.subject = subject;
            mail.setHtmlBody (body);

            if ( ccAddress != null ) {
                mail.setCcAddresses(ccAddress);
            }
            if ( bccAddress != null ) {
                mail.setBccAddresses(bccAddress);
            }

            // creating email message list
            Messaging.SingleEmailMessage[] emails = new List<Messaging.SingleEmailMessage> {mail};
            //  send the email
            result = Messaging.sendEmail(emails);
            // check results
            if ( !result[0].success ) {
                this.sendException = new ApexApplicationException(result[0].errors[0].message);
            }
        } catch (Exception excp) {
            this.sendException = new ApexApplicationException ('ApexMailmessagePayloadSender: Error sending email', excp);
        }

        return new ApexMessageSendResponse(result, this.sendException);
    } // end of sendmessagePayloadImpl

    /**
     * @brief Get the recipients
     * @description Get the recipients
     *
     * @param messagePayload payload with name-value pairs
     * @return list of recipients
     */
    private List<String> getRecipients(ApexMessagePayload messagePayload) {
        return this.getStringArrayFromPayload(messagePayload, 'Recipients', 'Bad email recipients-- Not found.', false);
    } // end of getRecipients

    /**
     * @brief Get the cc addresses
     * @description Get the cc addresses
     *
     * @param messagePayload payload with name-value pairs
     * @return list of CCs
     */
    private List<String> getCCAddresses(ApexMessagePayload messagePayload) {
        return this.getStringArrayFromPayload(messagePayload, 'CC', 'Bad email CC addresss-- Not found.', true);
    } // end of getCCAddresses

    /**
     * @brief Get the blind cc  addresses
     * @description Get the blind cc addresses
     *
     * @param messagePayload payload with name-value pairs
     * @return list of BCCs
     */
    private List<String> getBCCAddresses(ApexMessagePayload messagePayload) {
        return this.getStringArrayFromPayload(messagePayload, 'BCC', 'Bad email BCC-- Not found.', true);
    } // end of getBCCAddresses

    /**
     * @brief Get the reply to
     * @description Get the reply to
     *
     * @param messagePayload payload with name-value pairs
     * @return reply tos
     */
    private String getReply(ApexMessagePayload messagePayload) {
        return this.getStringFromPayload(messagePayload, 'Reply', 'Bad email reply-to -- Not found.', false);
    } // end of getReply

    /**
     * @brief Get the subject
     * @description Get the reply to
     *
     * @param messagePayload payload with name-value pairs
     * @return reply tos
     */
    private String getSubject(ApexMessagePayload messagePayload) {
        return this.getStringFromPayload(messagePayload, 'Subject', 'Bad email subject -- Not found.', false);
    } // end of getSubject

    /**
     * @brief Get the display name
     * @description Get the display name
     *
     * @param messagePayload payload with name-value pairs
     * @return string of the display name
     */
    private String getDisplayName(ApexMessagePayload messagePayload) {
        return this.getStringFromPayload(messagePayload, 'DisplayName', 'Bad email display name -- Not found.', false);
    } // end of getDisplayName

    /**
     * @brief Get the email body
     * @description Get the email body
     *
     * @param messagePayload payload with name-value pairs
     * @return string of the email body
     */
    private String getBody(ApexMessagePayload messagePayload) {
        return this.getStringFromPayload(messagePayload, 'Body', 'Bad email body -- Not found.', false);
    } // end of getBody

} // end of ApexMailmessagePayloadSender
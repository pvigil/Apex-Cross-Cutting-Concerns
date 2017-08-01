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
 * Encapsulates all behaviour logic relating to the Trigger invocation
 *
 * NOTE: This is Temporary. This class it to be used by the trigger classes that are performing.
 * Until the Apex Enterprise Framework is added, this class stems the tide. Once we add Apex Enterprise Framework
 * and the lennar base class for the domain, then DELETE this class!!!!
 *
 * @group Domain Layer
 */
public class TriggerHelperClass {

    public final static String BeforeInsert = 'before insert';
    public final static String BeforeUpdate =  'before update';
    public final static String BeforeDelete = 'before delete' ;
    public final static String AfterInsert = 'after insert' ;
    public final static String AfterUpdate =  'after update' ;
    public final static String AfterDelete =  'after delete'  ;
    public final static String AfterUndelete =  'after undelete' ;

    private static Map<String, Boolean> triggerAction = new Map<String, Boolean> {
        BeforeInsert  => true
        , BeforeUpdate => true
        , BeforeDelete => true
        , AfterInsert => true
        , AfterUpdate  => true
        , AfterDelete  => true
        , AfterUndelete => true
    };

    /**
     * @brief first time the trigger is invoked
     * @details first time the trigger is invoked
     *
     */
    // @deprecated
    private static boolean firstRun = true;

    /**
     * @brief Toggles the first run state, first time it is true
     * @details Toggles the first run state, first time it is true
     * @return Boolean, the last state
     */
    // @deprecated
    public static Boolean togglerFirstRunState() {
        Boolean lastState = TriggerHelperClass.firstRun;

        if ( TriggerHelperClass.firstRun ) {
            TriggerHelperClass.firstRun = !TriggerHelperClass.firstRun;
        }

        return lastState;
    } // end of togglerFirstRunState

    /**
     * @brief Toggles the first run state, first time it is true
     * @details Toggles the first run state, first time it is true
     *
     * @param action [description]
     * @return Boolean, the last state
     *
     */
    public static Boolean togglerFirstRunState(String action) {
        // note, put returns the Previous value at that location
        return action == null ? false : TriggerHelperClass.triggerAction.put(action, false);
    } // end of togglerFirstRunState

    /**
     * @brief reset the trigger check
     * @details reset the trigger check
     */
    public static void reset() {
        for (String action : TriggerHelperClass.triggerAction.keyset()) {
            TriggerHelperClass.triggerAction.put(action, true);
        }
    } // end of reset

} // end of TriggerHelperClass
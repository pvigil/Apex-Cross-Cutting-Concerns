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
 * @brief Test Cache
 * @description Test Cache
 *
 * Note: The cache MUST BE SETUP FIRST!!!
 * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_cache_partition_setup.htm
 */
@isTest
private class ApexCacheTest {

    @isTest
    static void TestCtor() {
        // assign & act
        ICache mcache = new ApexCache();
        // assert
        System.Assert(mcache != null, 'Test ApexCache ctor');
    } // end of TestCtor

    @isTest
    static void TesttoggleEnabled() {
        // assign
        ApexCache mcache = new ApexCache();
        Boolean toggleEnabled = false;
        // act
        Boolean result = mcache.toggleEnabled();
        // assert
        System.Assert(result == toggleEnabled, 'Test ApexCache toggleEnabled');
    } // end of TesttoggleEnabled

    @isTest
    static void TestisAvailable() {
        // assign
        ICache mcache = new ApexCache();
        Boolean isAvailable = true;
        // act
        Boolean result = mcache.isAvailable();
        // assert
        System.Assert(isAvailable == result, 'Test ApexCache isAvailable');
    } // end of TestisAvailable

    @isTest
    static void TestgetString() {
        // assign
        ICache mcache = new ApexCache();
        String key = ApexUtilities.newGuid();
        // act
        String result = (String)mcache.get(key);
        // assert
        System.Assert(result == null, 'Test ApexCache get');
    } // end of TestgetString

    @isTest
    static void TestputString() {
        // assign
        ICache mcache = new ApexCache();
        String key = ApexUtilities.newGuid();
        // act
        mcache.put(key, key);
        String result = (String)mcache.get(key);
        // assert
        System.Assert(result == key, 'Test ApexCache put');
    } // end of TestputString

    @isTest
    static void TestgetKeys() {
        // assign
        ICache mcache = new ApexCache();
        Set<String> keys = new Set<String>();
        Set<String> results = null;
        String key;
        // act
        for (Integer inx = 0; inx < 100; inx++) {
            key = ApexUtilities.newGuid();
            keys.add( key);
            mcache.put(key, key);
            System.assert((String)mcache.get(key) == key,'TestgetKeys expected entry, not found');
        }

        // act
        results = mcache.getKeys();
        for (String item : results) {
            keys.remove(item);
        }
        // assert
        System.Assert( keys.size() == 0, 'Test ApexCache getkeys');
    } // end of TestputString

    @isTest
    static void Testcontains() {
        // assign
        ICache mcache = new ApexCache();
        String key =  ApexUtilities.newGuid();

        // act
        mcache.put(key, 'key');
        Boolean result = mcache.contains(key);

        // assert
        System.Assert(result == true, 'Test ApexCache Contains');
    } // end of Testcontains

    @isTest
    static void TestputStringTTL() {
        // assign
        ICache mcache = new ApexCache();
        String key = ApexUtilities.newGuid();

        // act
        mcache.put(key, key, ApexCache.DEFAULT_MIN_TTL_IN_SECS);

        String result = (String)mcache.get(key);
        // assert
        System.Assert(result == key, 'Test ApexCache put TTL');
    } // end of TestputStringTTL

    @isTest
    static void Testremove() {
        // assign
        ICache mcache = new ApexCache();
        String key = ApexUtilities.newGuid();

        // act
        mcache.put(key, key);
        mcache.remove(key);
        String result = (String)mcache.get(key);
        // assert
        System.Assert(result == null, 'Test ApexCache remove');
    } // end of Testremove

    @isTest
    static void TestpartitionName() {
        // assign
        ICache mcache = new ApexCache();
        String key = ApexUtilities.newGuid();
        String expNS = ApexCache.CACHE_NS;
        String expPN = ApexCache.CACHE_PARTITON;
        String expected = expNS + '.' + expPN;
        // act
        String partitionName = mcache.partitionName();

        // assert
        System.Assert(partitionName == expected, 'Test ApexCache partition');
    } // end of partitionName

}
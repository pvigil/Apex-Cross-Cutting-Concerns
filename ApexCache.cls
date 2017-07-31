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
 * @brief Caching
 * @description Caching -- the default is to use Cache Org and not session. This may change
 * @group Common Layer
 * See https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_cache_Org.htm#apex_cache_Org_methods
 *
 * Note: The cache MUST BE SETUP FIRST!!!
 * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_cache_partition_setup.htm
 */
public virtual without sharing class ApexCache implements ICache {

    ///////////////////////////////////////////////////////////////////////////////////////////////
    // Data Members
    ///////////////////////////////////////////////////////////////////////////////////////////////

    public static final Integer DEFAULT_TTL_IN_SECS = 600;
    public static final Integer DEFAULT_MIN_TTL_IN_SECS = 300;
    // Name of our partition -- must be created in Org (Setup) First!!!
    public static final String CACHE_NS = 'local';
    public static final String CACHE_PARTITON = 'work';

    private String cacheNamespace = CACHE_NS;
    private String cachePartition = CACHE_PARTITON;

    private String orgPartitionName = null;
    // Our Org partition object
    private Cache.OrgPartition orgPartition = null;
    // is cached enabled
    private Boolean cacheEnabled = true;
    // is the parition available ( already created in Org)
    private Boolean cacheIsAvailable = false;

    ///////////////////////////////////////////////////////////////////////////////////////////////
    // Ctors
    ///////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief default ctor
     * @decription default ctor
     */
    public ApexCache() {
        this(CACHE_NS, CACHE_PARTITON);
    }// end of ctor

    /**
     * @brief default ctor
     * @decription default ctor
     */
    public ApexCache(String namespace, String partition) {
        String nsInput = String.isBlank(namespace) ? this.cacheNamespace : namespace;
        String partitionInput = String.isBlank(partition) ? this.cachePartition : partition;
        String orgPartitionNameInput = nsInput + '.' + partitionInput;

        this.orgPartitionName = orgPartitionNameInput;
        this.cacheNamespace = nsInput;
        this.cachePartition = partitionInput;

        // now go check that this partition is already created ( setup->cache in the Org)
        this.cacheIsAvailable = this.getPartition() != null ;
    } // end of ctor

    ///////////////////////////////////////////////////////////////////////////////////////////////
    // Public Methods
    ///////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief cache partition name
     * @description cache partition name
     * @return String
     */
    public String partitionName() {
        return this.orgPartitionName;
    } // end of partitionName

    /**
     * @brief toggle on/off the cache
     * @description toggle on/off the cache
     * @return current value
     */
    public Boolean toggleEnabled() { // Use for testing misses
        cacheEnabled = !cacheEnabled;
        return cacheEnabled;
    }

    /**
     * @brief is cache available
     * @description is cache available (always for 'Org')
     * @return Boolean
     */
    public Boolean isAvailable() {
        if ( !this.cacheIsAvailable ) {
            return false;
        }

        return this.getPartition().isAvailable();
    } // end of isAvailable

    /**
     * @brief get an item from cache
     * @description get an item from cache
     * @return Object
     */
    public Object get(String key) {
        Object results = null;

        if ( key != null && this.cacheIsAvailable ) {
            results = this.getPartition().get(key);
        }

        return results;
    } // end of get

    /**
     * @brief item in cache
     * @description item in the cache
     * @return Boolean
     */
    public Boolean contains(String key) {
        Boolean results = false;

        if ( key != null && this.cacheIsAvailable ) {
            results = this.getPartition().contains(key);
        }

        return results;
    } // end of contains

    /**
     * @brief get cahce keys
     * @description get cache keys
     * @return Boolean
     */
    public Set<String> getKeys() {
        Set<String> data = null;

        if ( this.cacheIsAvailable ) {
            data = this.getPartition().getKeys();
        }

        return data;
    } // end of getKeys

    /**
     * @brief put value into cache
     * @description put value into cache
     * @return void
     */
    public void put(String key, Object value) {
        this.put(key, value, DEFAULT_TTL_IN_SECS);
    }

    /**
     * @brief put value in cache
     * @description put value into cache
     *
     * @param key String name
     * @param value object value
     * @param ttlSecstime to live in seconds (max. in 8 hrs == 28,800 secs - min is 300 secs) MAX_TTL_SECS
     */
    public void put(String key, Object value, Integer ttlSecs) {
        if ( key != null && this.cacheIsAvailable ) {
            Integer ttl = ttlSecs < DEFAULT_MIN_TTL_IN_SECS ? DEFAULT_MIN_TTL_IN_SECS : ttlSecs;
            this.getPartition().put(key, value);//, ttl, Cache.Visibility.ALL, true);
        }
    } // end of put

    /**
     * @brief remove from cache
     * @description remove case sensitive key value from cache
     *
     * @param key case sensitive string name
     * @return Boolean true if removed
     */
    public Boolean remove(String key) {
        Boolean results = false;

        if ( key != null && this.cacheIsAvailable ) {
            results = this.getPartition().remove(key);
        }

        return results;
    } // end of remove

    ///////////////////////////////////////////////////////////////////////////////////////////////
    // Private Methods
    ///////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief Get/Create the Org partition
     * @decription Get/Create the Org partition
     * @return Cache.Org.Partition
     */
    private Cache.OrgPartition getPartition() {
        if ( this.orgPartition == null ) {
            try {
                this.orgPartition = Cache.Org.getPartition(this.orgPartitionName);
            } catch (Cache.Org.OrgCacheException excp) {
                // if there is not data by the key, the parition may not have been created
                ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
            }
        }
        return this.orgPartition;
    } // end of getPartition

} // end of ApexCache
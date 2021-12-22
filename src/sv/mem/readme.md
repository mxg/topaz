Mem
===

Demonstration of the decorator pattern.

The basis of this example is a simple memory model, implemented in
mem.svh.  The memory model provides methods for reading and writing
single bytes.  The implementation is sparse, and it uses an
associative array to store and look-up addresses.  The result is
reasonably memory efficient, but not necessarily fast.

A cache, as implemented in mem_cache.svh, improves the overall read
and write performance of the memory.  At the expense of a little bit
of memory, the cache provides a fast means of storing and retrieving
items (bytes) in the memory. The cache does not shadow the entire
memory, only a small portion.  Writes are sped up when a cache entry
is available and only the cache has to be updated.  Reads are sped up
when an item is already in the cache and the memory does not have to
be accessed.

An operation that only accesses the cache is called a _cache hit_.  An
operation that requires accessing the memory is called a _cache miss_.
Most use cases will end up using a mix of cache hits and cache
misses. The more cache hits that occur, the faster the average speed
of the read and write operations.

The cache is derived from the same interface as the memory.  It uses
the decorator pattern to layer the cache on top of the memory.  The
read() and write() methods in the cache delegate to the read() and
write() methods in the memory when cache misses occur.  The original
memory model is untouched.
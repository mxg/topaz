Strategy
========

Different cache coherency algorithms use differens FSMs to represent
the state transitions of a cache location.  The exampe is a cache
coherency scoreboard.  It follows along with the state of the cache to
ensure that it is always correct. We employ the strategy pattern to
enable different FSMs to be swapped in.
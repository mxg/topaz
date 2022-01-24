Proxy
=====

To illustrate the proxy pattern we use a message logger.  The logger
is a singleton.  It's role is to assemble all the pieces of a message
and print it.  Each logger client instantiates a proxy object.  The
proxy object allows some details of the message rendering to be
configured.  Each client can thus configure the messages differently.

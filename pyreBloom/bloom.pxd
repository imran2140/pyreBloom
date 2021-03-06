# Copyright (c) 2011 SEOmoz
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

cdef extern from "bloom.h":
    ctypedef unsigned int uint32_t

    ctypedef struct redisContext:
        int err
        char errstr[128]
        int fd
        int flags
        char *obuf
    
    ctypedef struct pyrebloomctxt:
        uint32_t capacity
        uint32_t bits
        uint32_t hashes
        float    error
        uint32_t * seeds
        unsigned char * key
        redisContext * ctxt

    bint init_pyrebloom(pyrebloomctxt * ctxt, unsigned char * key, uint32_t capacity, float error, char* host, uint32_t port)
    bint free_pyrebloom(pyrebloomctxt * ctxt)
    
    bint add(pyrebloomctxt * ctxt, char * data, uint32_t len)
    bint add_complete(pyrebloomctxt * ctxt, uint32_t count)
    
    bint check(pyrebloomctxt * ctxt, char * data, uint32_t len)
    bint check_next(pyrebloomctxt * ctxt)
    
    bint delete(pyrebloomctxt * ctxt)
    
    uint32_t hash(unsigned char * data, uint32_t len, uint32_t hash, uint32_t bits)

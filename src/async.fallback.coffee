###
Asynchronous enumeration

Returns:
  cb(error):      error
  cb(null, crt):  certificate
  cb():           done
###
path = require 'path'
spawn = require 'child_process'
  .spawn

split = require 'split'
forge = require 'node-forge'

asn1 = forge.asn1
pki = forge.pki

bufferFrom = Buffer.from or (data, encoding)->
  new Buffer data, encoding

module.exports = (cb)->
  spawn path.join __dirname, 'roots'
    .stdout.pipe split (blob)->
      unless blob
        return
      blob = bufferFrom blob, 'hex'
      cb null, pki.certificateFromAsn1 asn1.fromDer blob.toString 'binary'
    .on 'end', ->
      cb null
      return
# Puppet Module - Policy Based Autosigner Example

## Purpose

This module exists to setup an example of using Puppet's policy-based autosigner
(https://docs.puppet.com/puppet/latest/reference/ssl_autosign.html#policy-based-autosigning)
with a minimal 'password' CSR attribute. In essence, you can 'bless' nodes/templates/AMIs/etc...
with a pre-determined password and allow Puppet to automatically sign any node's
certificate given they have the correct 'password' CSR attribute.

For information on CSR Attributes, see:  https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html


## Usage

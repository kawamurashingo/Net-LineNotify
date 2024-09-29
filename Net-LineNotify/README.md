Net::LineNotify

This module is a simple wrapper for the LINE Notify API. It allows you to send notifications to LINE via Perl.

To install:

  perl Makefile.PL
  make
  make test
  make install

Usage example:

  use Net::LineNotify;

  my $line = Net::LineNotify->new(access_token => 'YOUR_ACCESS_TOKEN');
  $line->send_message('Hello from Perl!');

Dependencies:

  - LWP::UserAgent
  - HTTP::Request::Common


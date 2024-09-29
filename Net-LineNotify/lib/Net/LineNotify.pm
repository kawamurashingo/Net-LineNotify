package Net::LineNotify;

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request::Common;

our $VERSION = '0.01';

# コンストラクタ
sub new {
    my ($class, %args) = @_;
    my $self = {
        access_token => $args{access_token},  # アクセストークン
    };
    bless $self, $class;
    return $self;
}

# LINE Notifyにメッセージを送信するメソッド
sub send_message {
    my ($self, $message) = @_;
    my $url = 'https://notify-api.line.me/api/notify';

    # UserAgentのセットアップ
    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    # POSTリクエストの作成
    my $req = POST(
        $url,
        'Authorization' => "Bearer " . $self->{access_token},  # トークンをヘッダーに追加
        Content_Type    => 'form-data',
        Content         => [ message => $message ],            # メッセージを送信
    );

    # リクエストを送信し、レスポンスを受け取る
    my $response = $ua->request($req);

    if ($response->is_success) {
        return 1;  # 成功
    } else {
        return 0;  # 失敗
    }
}

1;  # パッケージの終わりには1を返す必要があります。

__END__

=head1 NAME

Net::LineNotify - A simple wrapper for LINE Notify API

=head1 SYNOPSIS

  use Net::LineNotify;

  my $line = Net::LineNotify->new(access_token => 'YOUR_ACCESS_TOKEN');
  $line->send_message('Hello from Perl!');

=head1 DESCRIPTION

Net::LineNotify is a simple Perl wrapper for sending notifications via the LINE Notify API.

=head1 METHODS

=head2 new

  my $line = Net::LineNotify->new(access_token => 'YOUR_ACCESS_TOKEN');

Creates a new Net::LineNotify object. Requires an access token for authentication.

=head2 send_message

  $line->send_message('Hello!');

Sends a message to the LINE account associated with the access token.

=head1 AUTHOR

Your Name <your.email@example.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
